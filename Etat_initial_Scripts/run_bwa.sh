#!/bin/bash

# Crée un dossier de sortie
mkdir -p bwa_output

# Liste des préfixes d’échantillons
for sample in BP EP FP; do
    echo "🔄 Alignement BWA mem tolérant pour $sample"

    bwa mem -t 4 -k 15 -w 200 -d 200 -r 2.0 -c 20000 -A 1 -B 3 -O 5 -E 1 -L 2 -U 7 -M \
        index_psbO/psbO_ref_unique.fna \
        data_filtered_post_bwa/${sample}_1_min70.fastq \
        data_filtered_post_bwa/${sample}_2_min70.fastq \
        > bwa_output/${sample}_filtered_unique.sam
done

echo "✅ Tous les alignements sont terminés."