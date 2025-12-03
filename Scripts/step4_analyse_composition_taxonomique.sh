#!/bin/bash


###############################################################################
# SCRIPT : step4_analyse_composition_taxonomique.sh
#
# OBJECTIF :
#   Combiner les counts par contig (résultant de l’alignement BWA) avec la carte
#   taxonomique psbO pour produire un profil d’abondance par taxon.
#
# PIPELINE :
#   1. Inverser l’ordre des colonnes du fichier de counts (mapped → ID)
#   2. Faire une jointure avec la taxMap (contig → taxonomie)
#   3. Additionner les counts par taxon
#   4. Calculer les abondances relatives (%)
#   5. Générer un tableau final trié par counts décroissants
#
# INPUTS :
#   Outputs/bwa_output/matched_ids/<sample>_ref_counts.txt
#       Format : contig[TAB]mapped_reads
#
#   Outputs/index_psbO/psbO_taxonomy_map_fixed.tsv
#       Format : contig[TAB]taxonomy
#
# OUTPUTS :
#   Outputs/taxonomic_profiles/<sample>_taxonomic_profile.tsv
#       Colonnes : Taxonomy | Count | Relative_Abundance(%)
#
# DÉPENDANCES du script :
#   awk : Version 5.3.1
#   sort : Version 9.4
#
# INFOS :
#   Le script :
#     - gère les contigs sans taxonomie → "Unclassified"
#     - normalise les abondances (somme = 100 %)
#     - ne modifie pas les formats d’entrée/sortie
###############################################################################


### ------------------------------------------------------------------------ ###
### Dossiers et fichiers
### ------------------------------------------------------------------------ ###
INPUT_DIR="Outputs/bwa_output/matched_ids"
TAX_MAP="Outputs/index_psbO/psbO_taxonomy_map_fixed.tsv"
OUT_DIR="Outputs/taxonomic_profiles"

mkdir -p "$OUT_DIR"


### ------------------------------------------------------------------------ ###
### Boucle principale sur les échantillons
### ------------------------------------------------------------------------ ###
for sample in BP EP FP; do
  echo "🔄 Traitement de $sample..."

  counts_file="$INPUT_DIR/${sample}_ref_counts.txt"
  counts_inv="$INPUT_DIR/${sample}_ref_counts_inv.tsv"
  profile="$OUT_DIR/${sample}_taxonomic_profile.tsv"


  ### -------------------------------------------------------------------- ###
  ### 1. Inversion des colonnes du fichier de counts
  ###    counts.txt     → contig \t mapped
  ###    counts_inv.tsv → mapped \t contig
  ###    (awk home-made join nécessite ID en première colonne)
  ### -------------------------------------------------------------------- ###
  awk '{print $2 "\t" $1}' "$counts_file" > "$counts_inv"


  ### -------------------------------------------------------------------- ###
  ### 2. Jointure taxonomique + sommation + abondance relative
  ###
  ###  Fichier 1 chargé en mémoire (NR==FNR) :
  ###      TAX_MAP  -> tax[contig] = taxonomy
  ###
  ###  Fichier 2 lu ensuite :
  ###      counts_inv -> id (contig), count (mapped)
  ###
  ###  Pour chaque contig :
  ###     - récupérer le taxon (ou "Unclassified")
  ###     - accumulateur abund[taxon] += count
  ###     - accumulateur total += count
  ###
  ###  END :
  ###     imprime Taxonomy | Count | Relative_Abundance(%)
  ###     puis tri décroissant selon Count
  ### -------------------------------------------------------------------- ###
  awk -v OFS="\t" '
    NR==FNR {                     # Lecture de la taxMap
      tax[$1]=$2;                # tax[contig] = taxonomy
      next;
    }

    {                             # Traitement des counts
      id=$1; count=$2;

      if (id in tax) {
        taxa = tax[id];
      } else {
        taxa = "Unclassified";
      }

      abund[taxa] += count;      # Accumulateur par taxon
      total += count;            # Compteur total global
    }

    END {                         # Sortie finale
      print "Taxonomy", "Count", "Relative_Abundance(%)";

      for (t in abund) {
        rel = (abund[t] / total) * 100;
        print t, abund[t], rel;
      }
    }
  ' "$TAX_MAP" "$counts_inv" | sort -k2,2nr > "$profile"


  echo "📄 Profil taxonomique pour $sample sauvegardé dans : $profile"
done


### ------------------------------------------------------------------------ ###
echo "✅ Tous les profils taxonomiques sont générés."
### ------------------------------------------------------------------------ ###