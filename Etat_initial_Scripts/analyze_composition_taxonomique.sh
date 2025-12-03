#!/bin/bash

INPUT_DIR="bwa_output/matched_ids"
TAX_MAP="index_psbO/taxonomy_map/psbO_taxonomy_map_fixed.tsv"
OUT_DIR="taxonomic_profiles"
mkdir -p "$OUT_DIR"

for sample in BP EP FP; do
  echo "Traitement de $sample..."

  counts_file="$INPUT_DIR/${sample}_ref_counts.txt"
  counts_inv="$INPUT_DIR/${sample}_ref_counts_inv.tsv"
  profile="$OUT_DIR/${sample}_taxonomic_profile.tsv"

  # Inverser colonnes pour avoir ID en 1ère colonne
  awk '{print $2 "\t" $1}' "$counts_file" > "$counts_inv"

  # Jointure, sommation, calcul abondance relative
  awk -v OFS="\t" '
  NR==FNR { tax[$1]=$2; next }
  {
    id=$1; count=$2;
    if(id in tax) {
      taxa = tax[id];
    } else {
      taxa = "Unclassified";
    }
    abund[taxa] += count;
    total += count;
  }
  END {
    print "Taxonomy", "Count", "Relative_Abundance(%)";
    for(t in abund) {
      rel = (abund[t]/total)*100;
      print t, abund[t], rel;
    }
  }
  ' "$TAX_MAP" "$counts_inv" | sort -k2,2nr > "$profile"

  echo "Profil taxonomique pour $sample sauvegardé dans $profile"
done