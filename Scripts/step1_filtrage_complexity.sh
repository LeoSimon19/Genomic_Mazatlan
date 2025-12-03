#!/bin/bash

# Se placer dans le bon dossier (adapter si besoin)
cd ~/"Workspace"

# Étape 1 : créer les dossiers si besoin
mkdir -p Outputs/complexity_stats
mkdir -p Outputs/data_filtered_post_bwa

# Étape 2 : extraire les stats de complexité
for prefix in BP EP FP; do  #A prendre depuis les dossiers de séquençage dans "Inputs"
  for pair in 1 2; do
    echo "Calcul de la complexité pour ${prefix}_${pair}..."
    seqkit fx2tab -n -i data_filtered_post_bwa/${prefix}_${pair}_min70.fastq > complexity_stats/${prefix}_${pair}_stats.tsv
  done
done

# Étape 3 : filtrer les reads complexes (complexité >= 0.75)
for prefix in BP EP FP; do
  for pair in 1 2; do
    echo "Filtrage des IDs complexes pour ${prefix}_${pair}..."
    awk '$3 >= 0.75 {print $1}' complexity_stats/${prefix}_${pair}_stats.tsv > complexity_stats/${prefix}_${pair}_ids.txt
  done
done

# Étape 4 : extraire les séquences complexes uniquement
for prefix in BP EP FP; do
  for pair in 1 2; do
    echo "Extraction des reads complexes pour ${prefix}_${pair}..."
    seqkit grep -f complexity_stats/${prefix}_${pair}_ids.txt data_filtered_post_bwa/${prefix}_${pair}_min70.fastq \
      -o data_filtered_post_bwa/final/${prefix}_${pair}_filtered.fastq
  done
done

echo "✅ Filtrage terminé. Résultats dans data_filtered_post_bwa/final/"