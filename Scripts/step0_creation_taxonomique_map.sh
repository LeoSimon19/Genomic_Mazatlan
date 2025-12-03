#!/bin/bash

###############################################################################
# SCRIPT : step0_taxonomy_map_creation.sh
# OBJECTIF :
#   Extraire, à partir d’un fichier FASTA d'acides nucléiques psbO, une table
#   de correspondance entre les identifiants de séquences et leur lignée
#   taxonomique. Ce fichier servira ensuite comme "taxonomy map" pour
#   l'assignation taxonomique dans des pipelines downstream.
#
# CONTEXTE :
#   - Les en-têtes du FASTA psbO (20210825) suivent le format :
#         >ID Taxonomy
#     Exemple :
#         >Seq_001 Bacteria;Cyanobacteria;...
#
# FAIRNESS & REPRODUCTIBILITÉ :
#   - Le script documente ses étapes et prérequis.
#   - Le fichier de sortie peut être versionné et inclut un format tabulé clair.
#   - Le code n’utilise aucune dépendance non standard (uniquement awk).
#
# INPUT :
#   databases/psbO_20210825.fna
#
# OUTPUT :
#   Outputs/index_psbO/psbO_taxonomy_map_fixed.tsv
#
# AUTEUR : <CACAO M.F Solane/ Projet_FAIR / 03/12/2025>
###############################################################################


# Vérifie la présence du fichier FASTA d’entrée
if [[ ! -f databases/psbO_20210825.fna ]]; then
    echo "Erreur : le fichier databases/psbO_20210825.fna est introuvable."
    exit 1
fi

# Crée le dossier de sortie si nécessaire
mkdir -p Outputs/index_psbO


###############################################################################
# AWK : Version GNU Awk 5.3.1
#   - Séparateur d’entrée = espace
#   - Séparateur de sortie = tabulation
#   - Pour chaque ligne commençant par '>' :
#       1. enlever le '>'
#       2. séparer l’ID et la lignée taxonomique
#       3. si aucune taxonomie fournie → 'Unclassified'
#       4. imprimer ID <tab> taxonomy
###############################################################################

awk '
BEGIN {
    FS = " "; OFS = "\t";  # champs séparés par espace ; sortie tabulée
}

# Chaque ligne d’en-tête FASTA commence par ">"
/^>/ {
    # Enlever le caractère ">" en début de ligne
    header = substr($0, 2);

    # Split sur les espaces : fields[1] = ID, fields[2] = Taxonomie (optionnelle)
    split(header, fields, " ");

    id = fields[1];

    # Si la taxonomie existe, l'utiliser, sinon mettre "Unclassified"
    taxonomy = (length(fields) > 1) ? fields[2] : "Unclassified";

    # Sortie : ID    Taxonomy
    print id, taxonomy;
}
' databases/psbO_20210825.fna \
  > Outputs/index_psbO/psbO_taxonomy_map_fixed.tsv


echo "✔ Fichier Outputs/index_psbO/psbO_taxonomy_map_fixed.tsv généré avec succès."
