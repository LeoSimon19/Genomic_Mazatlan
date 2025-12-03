#!/bin/bash

###############################################################################
# SCRIPT : step3_sequence_comptage.sh
#
# OBJECTIF :
#   Convertir les fichiers SAM issus de BWA en fichiers BAM triés et indexés,
#   puis générer des fichiers de comptage par contig à l’aide de samtools idxstats.
#
# WORKFLOW :
#   1. SAM → BAM
#   2. BAM → Tri (coordinate-sorted)
#   3. BAM → Indexation (.bai)
#   4. Extraction des counts avec samtools idxstats
#
# INPUTS :
#   Outputs/bwa_output/<sample>_filtered_unique.sam
#
# OUTPUTS :
#   Outputs/bwa_output/<sample>_filtered_unique.bam
#   Outputs/bwa_output/<sample>_filtered_unique.sorted.bam
#   Outputs/bwa_output/<sample>_filtered_unique.sorted.bam.bai
#   Outputs/bwa_output/matched_ids/<sample>_ref_counts.txt
#
# SOFTWARES UTILISES :
#   samtools : Version 1.19.2
#
# ÉCHANTILLONS :
#   BP, EP, FP  -> Peuvent être interchangeables
#
# NOTES :
#   - samtools idxstats renvoie : contig | length | mapped | unmapped
#   - Ce script extrait uniquement : contig | mapped
###############################################################################


### ------------------------------------------------------------------------ ###
### Définition des dossiers d’entrée / sortie
### ------------------------------------------------------------------------ ###
INPUT_SAM_DIR="Outputs/bwa_output"
OUT_COUNT_DIR="Outputs/bwa_output/matched_ids"

# Création du dossier de sortie si absent
mkdir -p "$OUT_COUNT_DIR"


### ------------------------------------------------------------------------ ###
### Loop sur les échantillons
### ------------------------------------------------------------------------ ###
for sample in BP EP FP; do
    echo "🔄 Traitement du fichier SAM pour $sample"

    sam="$INPUT_SAM_DIR/${sample}_filtered_unique.sam"
    bam="$INPUT_SAM_DIR/${sample}_filtered_unique.bam"
    sorted="$INPUT_SAM_DIR/${sample}_filtered_unique.sorted.bam"
    counts="$OUT_COUNT_DIR/${sample}_ref_counts.txt"


    ### -------------------------------------------------------------------- ###
    ### 1. Conversion SAM → BAM
    ###   - SAM : format texte, volumineux
    ###   - BAM : format binaire compressé
    ###   - -bS : entrée SAM, sortie BAM
    ###   - -@ 4 : utiliser 4eme threads
    ### -------------------------------------------------------------------- ###
    samtools view -@ 4 -bS "$sam" > "$bam"


    ### -------------------------------------------------------------------- ###
    ### 2. Tri du BAM par coordonnées
    ###   - requis avant l’indexation et idxstats
    ###   - -@ 4 : utilisation de 4 threads
    ### -------------------------------------------------------------------- ###
    samtools sort -@ 4 "$bam" -o "$sorted"


    ### -------------------------------------------------------------------- ###
    ### 3. Indexation du BAM trié
    ###   - génère un .bai
    ###   - requis pour idxstats
    ### -------------------------------------------------------------------- ###
    samtools index "$sorted"


    ### -------------------------------------------------------------------- ###
    ### 4. Extraction des counts par contig
    ###   - idxstats renvoie :
    ###       contig | length | mapped | unmapped
    ###   - awk extrait seulement :
    ###       contig | mapped
    ###
    ###   Format final :  <contig> <tab> <mapped_reads>
    ### -------------------------------------------------------------------- ###
    samtools idxstats "$sorted" | awk -F'\t' '{print $1 "\t" $3}' > "$counts"


    echo "📄 Counts générés : $counts"
done


### ------------------------------------------------------------------------ ###
echo "✅ Tous les fichiers de comptage sont prêts."
### ------------------------------------------------------------------------ ###