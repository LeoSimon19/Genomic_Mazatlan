#!/bin/bash

###############################################################################
# SCRIPT : step1_filtrage_complexite.sh
#
# OBJECTIF :
#   - Calculer la complexité de chaque read (via seqkit fx2tab).
#   - Filtrer les reads dont la complexité est ≥ 0.75.
#   - Extraire uniquement ces reads "complexes" dans un nouveau FASTQ.
#
# CONTEXTE :
#   - Le filtrage de complexité permet d’éliminer les séquences peu informatives
#     (homopolymères, faible diversité, artefacts PCR…).
#   - Se base sur seqkit, option -i pour calculer l'indice de complexité.
#
# INPUTS ATTENDUS :
#   data_filtered_post_bwa/<prefix>_<pair>_min70.fastq
#   Exemple : BP_1_min70.fastq
#   Données provenant de l'étape post-BWA.
#
# OUTPUTS :
#   Outputs/complexity_stats/<prefix>_<pair>_stats.tsv      (statistiques complètes)
#   Outputs/complexity_stats/<prefix>_<pair>_ids.txt        (IDs filtrés ≥ 0.75)
#   Outputs/data_filtered_post_bwa/final/<prefix>_<pair>_filtered.fastq
#
# DEPENDANCES :
#   - seqkit Version 2.3.0
#   - awk : Version GNU Awk 5.3.1
#
# FAIRNESS :
#   - Le script documente ses étapes, formats, outils et versions attendues.
#   - Les chemins sont explicites et versionnables.
#   - Les étapes sont déterministes et reproductibles.
#
# AUTEUR :
#   <CACAO M.F Solane> — <03/12/2025>
###############################################################################


### ------------------------------------------------------------------------ ###
### Étape 0 : Configuration générale
### ------------------------------------------------------------------------ ###

# Se placer dans l'espace de travail (adapter si besoin)
cd ~/Workspace || {
  echo "❌ ERREUR : Impossible d'accéder à ~/Workspace"
  exit 1
}

# Préfixes correspondant aux échantillons (adapter si besoin)
PREFIXES=("BP" "EP" "FP")

# Valeur seuil de complexité
THRESHOLD=0.75


### ------------------------------------------------------------------------ ###
### Étape 1 : Préparation des dossiers de sortie
### ------------------------------------------------------------------------ ###
mkdir -p Outputs/complexity_stats
mkdir -p Outputs/data_filtered_post_bwa/final


### ------------------------------------------------------------------------ ###
### Étape 2 : Extraction des stats de complexité
### seqkit fx2tab -n -i :
###   -n : imprime l'ID
###   -i : calcule & imprime l’indice de complexité (Shannon)
### ------------------------------------------------------------------------ ###
echo "### Extraction des statistiques de complexité ###"

for prefix in "${PREFIXES[@]}"; do
  for pair in 1 2; do

    input="Outputs/data_filtered_post_bwa/${prefix}_${pair}_min70.fastq"
    output_stats="Outputs/complexity_stats/${prefix}_${pair}_stats.tsv"

    echo "➡ Calcul de la complexité pour ${prefix}_${pair}..."

    if [[ ! -f "$input" ]]; then
      echo "⚠ Fichier introuvable : $input — ignoré."
      continue
    fi

    seqkit fx2tab -n -i "$input" > "$output_stats"
  done
done


### ------------------------------------------------------------------------ ###
### Étape 3 : Filtrage des IDs dont la complexité ≥ THRESHOLD
### ------------------------------------------------------------------------ ###
echo "### Filtrage des IDs complexes ###"

for prefix in "${PREFIXES[@]}"; do
  for pair in 1 2; do

    input_stats="Outputs/complexity_stats/${prefix}_${pair}_stats.tsv"
    output_ids="Outputs/complexity_stats/${prefix}_${pair}_ids.txt"

    if [[ ! -f "$input_stats" ]]; then
      echo "⚠ Stats absentes : $input_stats — ignoré."
      continue
    fi

    echo "➡ Filtrage des IDs (complexité ≥ ${THRESHOLD}) pour ${prefix}_${pair}..."

    awk -v t=$THRESHOLD '$3 >= t {print $1}' "$input_stats" > "$output_ids"
  done
done


### ------------------------------------------------------------------------ ###
### Étape 4 : Extraction des reads complexes via seqkit grep
### ------------------------------------------------------------------------ ###
echo "### Extraction des reads complexes ###"

for prefix in "${PREFIXES[@]}"; do
  for pair in 1 2; do

    input_fastq="Outputs/data_filtered_post_bwa/${prefix}_${pair}_min70.fastq"
    id_file="Outputs/complexity_stats/${prefix}_${pair}_ids.txt"
    output_fastq="Outputs/data_filtered_post_bwa/final/${prefix}_${pair}_filtered.fastq"

    if [[ ! -f "$input_fastq" || ! -f "$id_file" ]]; then
      echo "⚠ Fichier absent pour ${prefix}_${pair} — extraction ignorée."
      continue
    fi

    echo "➡ Extraction des reads complexes pour ${prefix}_${pair}..."

    seqkit grep -f "$id_file" "$input_fastq" -o "$output_fastq"
  done
done


### ------------------------------------------------------------------------ ###
echo "✅ Filtrage terminé."
echo "Les fichiers filtrés se trouvent dans : Outputs/data_filtered_post_bwa/final/"
### ------------------------------------------------------------------------ ###