#!/bin/bash

###############################################################################
# SCRIPT : step2_alignement_bwa.sh
#
# OBJECTIF :
#   Aligner des reads filtrés (deux sens de lectures : R1/R2) sur une référence psbO dédupliquée
#   (psbO_ref_unique.fna) via BWA-MEM en utilisant des paramètres ajustés
#   pour tolérer davantage de diversité/mismatches.
#
# INPUTS :
#   data_filtered_post_bwa/<sample>_1_min70.fastq
#   data_filtered_post_bwa/<sample>_2_min70.fastq
#
# DATABASE DE RÉFÉRENCE :
#   index_psbO/psbO_ref_unique.fna   (index BWA déjà généré)
#
# OUTPUTS :
#   Outputs/bwa_output/<sample>_filtered_unique.sam
#
# DÉPENDANCE :
#   bwa = 0.7
#
# ---------------------------------------------------------------------------
# DÉTAIL DES PARAMÈTRES BWA UTILISÉS
# ---------------------------------------------------------------------------
#
# -t 4      : Nombre de threads (4 CPU utilisés)
#
# PARAMÈTRES D’ANCRAGE & SEED
# -k 15     : Taille du seed (15). Plus petit → plus tolérant aux variations.
# -w 200    : Fenêtre de seed (200). Influence la taille des régions considérées.
# -d 200    : Distance maximale entre seeds pour les regrouper.
#
# SCORE ET PÉNALITÉS D’ALIGNEMENT
# -A 1      : Score d’un match      (par défaut 1)
# -B 3      : Pénalité pour mismatch (plus haut → moins tolérant)
# -O 5      : Pénalité d’ouverture de gap
# -E 1      : Pénalité d’extension de gap
# -L 2      : Pénalité de clipping (2)
# -U 7      : Pénalité pour une base "ambiguous" N
#
# PARAMÈTRES DE SENSIBILITÉ / DÉTECTION
# -r 2.0    : Rapport minimum des scores pour décider qu’un alignement est unique
#             (plus petit → plus permissif)
# -c 20000  : Score minimum pour étendre l’alignement (augmente sensibilité)
#
# AUTRES
# -M        : Marque les alignements secondaires comme "secondary" (pour compatibilité
#             avec certains outils comme Picard)
#
###############################################################################


### ------------------------------------------------------------------------ ###
### Étape 1 : Création du dossier de sortie
### ------------------------------------------------------------------------ ###
mkdir -p Outputs/bwa_output


### ------------------------------------------------------------------------ ###
### Étape 2 : Alignement BWA-MEM pour chaque échantillon
### ------------------------------------------------------------------------ ###
SAMPLES=("BP" "EP" "FP")

for sample in "${SAMPLES[@]}"; do
    echo "🔄 Alignement BWA mem tolérant pour $sample"

    bwa mem -t 4 \
        -k 15 -w 200 -d 200 -r 2.0 \
        -c 20000 -A 1 -B 3 -O 5 -E 1 -L 2 -U 7 -M \
        index_psbO/psbO_ref_unique.fna \
        data_filtered_post_bwa/${sample}_1_min70.fastq \
        data_filtered_post_bwa/${sample}_2_min70.fastq \
        > Outputs/bwa_output/${sample}_filtered_unique.sam
done


### ------------------------------------------------------------------------ ###
echo "✅ Tous les alignements BWA-MEM sont terminés."
### ------------------------------------------------------------------------ ###
