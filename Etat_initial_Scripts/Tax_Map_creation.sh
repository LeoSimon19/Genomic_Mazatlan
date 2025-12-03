#!/bin/bash

awk '
BEGIN {
  FS = " "; OFS = "\t";
}
/^>/ {
  header = substr($0, 2);
  split(header, fields, " ");
  id = fields[1];
  taxonomy = (length(fields) > 1) ? fields[2] : "Unclassified";
  print id, taxonomy;
}
' psbO_20210825.fna > index_psbO/psbO_taxonomy_map_fixed.tsv

echo "Fichier psbO_taxonomy_map_fixed.tsv généré avec succès."
