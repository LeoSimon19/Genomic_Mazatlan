#!/bin/bash

INPUT_SAM_DIR=bwa_output
OUT_COUNT_DIR=bwa_output/matched_ids

mkdir -p "$OUT_COUNT_DIR"

for sample in BP EP FP; do
    echo "🔄 Traitement du fichier SAM pour $sample"

    sam="$INPUT_SAM_DIR/${sample}_filtered_unique.sam"
    bam="$INPUT_SAM_DIR/${sample}_filtered_unique.bam"
    sorted="$INPUT_SAM_DIR/${sample}_filtered_unique.sorted.bam"

    # SAM → BAM
    samtools view -@ 4 -bS "$sam" > "$bam"

    # Tri
    samtools sort -@ 4 "$bam" -o "$sorted"

    # Indexation
    samtools index "$sorted"

    # Générer les counts
    # idxstats donne : contig length mapped unmapped
    # On veut : contig mapped
    counts="$OUT_COUNT_DIR/${sample}_ref_counts.txt"

    samtools idxstats "$sorted" | awk -F'\t' '{print $1 "\t" $3}' > "$counts"

    echo "📄 Counts générés : $counts"
done

echo "✅ Tous les fichiers de comptage sont prêts."
