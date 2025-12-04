\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## [**Projet de FAIRISATION du sujet de stage de Master 1:**]{.underline}

## [**Analyse métagénomique de la diversité photosynthétique (gène psbO) dans la Baie de Mazatlán et le Lagon Urias (Mexique)**]{.underline}

Ce README documente le processus de FAIRISATION de l’ensemble des scripts, données, métadonnées et étapes analytiques utilisés durant le stage de Master 1 de Solane Cacao-Martins-Février au laboratoire de l’UNAM (Mazatlán, Mexique).\
Il vise à rendre le pipeline plus FAIR (Findable, Accessible, Interoperable, Reusable), en expliquant notamment les différentes étapes mises en place pour passer d’un état initial « non FAIR » à un état amélioré.\
Tout le projet n’a pas pu être entièrement traité, mais ce README présente et explique les éléments qui ont pu être clarifiés et rendus plus FAIR.

La **PARTIE 1** présente le contexte général du stage et l’état initial « non FAIR » de certains aspects, tandis que la **PARTIE 2** décrit les améliorations réalisées dans le cadre de la FAIRISATION.

# PARTIE 1 — ÉTAT INITIAL (Non FAIR)

### Objectif

Dresser un état des lieux de la structuration des données, scripts et fichiers, et expliquer pourquoi ils ne respectaient pas les principes FAIR.

## 1. Contexte scientifique

Le projet utilise une approche métagénomique basée sur l’ADN environnemental (ADNe), ciblant l’assignation taxonomique de séquences comparées à une base de données du gène **psbO**, dans l’objectif d’obtenir un aperçu de la diversité des organismes planctoniques photosynthétiques (procaryotes + eucaryotes) et d’estimer leur abondance dans différents sites :

-   **BP (Bahía Photosynthetic)** : stations de la Baie de Mazatlán

-   **EP (Entrada Photosynthetic)** : entrée du lagon (zone anthropisée)

-   **FP (Fundo Photosynthetic)** : fond du lagon

L’échantillonnage de l’ADNe a été réalisé à l’aide de bouteilles Niskin à 1 m de profondeur. Les extraits d’ADNe ont ensuite été séquencés (NGS, MacroGen ; paired-end 150 bp).

Pour plus d’informations sur les protocoles utilisés durant le stage, veuillez consulter le document de métadonnées disponible dans le dépôt GitHub. Celui-ci a été clarifié et enrichi dans le cadre du processus de FAIRISATION.

-\> [📄 Accéder au dossier Metadonnees](Metadonnees)

## 2. Structure du projet initial

L’arborescence des dossiers du stage était organisée de manière très dispersée, avec un grand nombre de fichiers et de répertoires éparpillés sans logique apparente.\
Par exemple, l’environnement de travail de Solane comprenait [**590 répertoires** et **4 726 fichiers** différents.]{.underline}

Cela rendait tout retour sur les données très fastidieux pour l’auteur, et quasiment impossible pour une personne extérieure.\
Cet état initial était donc très peu FAIR, notamment concernant les critères **Accessible**, **Interoperable** (vocabulaire non standardisé, absence de liens entre les données) et **Reusable**.

Ci-dessous, un aperçu d’une infime partie de l’arborescence initiale.\
├── psbO_db.4.bt2 │ ├── psbO_db.rev.1.bt2 │ ├── psbO_db.rev.2.bt2 │ ├── ref_humangenom.1.bt2 │ ├── ref_humangenom.2.bt2 │ ├── ref_humangenom.3.bt2 │ ├── ref_humangenom.4.bt2 │ ├── ref_humangenom.rev.1.bt2 │ └── ref_humangenom.rev.2.bt2 ├── bwa_psbO_tools │ ├── analyze_composition_taxonomique.sh │ ├── BP_1.fastq.gz -\> ../metagenomics_mzt/BP_1.fastq.gz │ ├── BP_2.fastq.gz -\> ../metagenomics_mzt/BP_2.fastq.gz │ ├── bwa_output │ │ ├── aligned_only │ │ │ ├── BP_aligned.sam │ │ │ ├── EP_aligned.sam │ │ │ └── FP_aligned.sam │ │ ├── BP_filtered.sam │ │ ├── BP_filtered_unique.sam │ │ ├── EP_filtered.sam │ │ ├── EP_filtered_unique.sam │ │ ├── FP_filtered.sam │ │ ├── FP_filtered_unique.sam │ │ └── matched_ids .......... │ ├── matched_ids │ │ ├── BP_ref_hits.txt │ │ ├── EP_ref_hits.txt │ │ └── FP_ref_hits.txt │ ├── psbO_20210825.fna -\> /botete/solane/databases/psbO_20210825.fna │ ├── psbO_taxonomy_map.tsv -\> index_psbO/taxonomy_map/psbO_taxonomy_map.tsv │ ├── run_bwa.sh │ └── taxonomic_profiles │ ├── BP_taxonomic_profile_newtest.tsv │ ├── BP_taxonomic_profile.tsv │ ├── EP_taxonomic_profile_newtest.tsv │ ├── EP_taxonomic_profile.tsv │ ├── FP_taxonomic_profile_newtest.tsv │ └── FP_taxonomic_profile.tsv ..........

Une FAIRISATION, soit ici une refonte structurée de l’organisation des dossiers était absolument nécessaire.

## 3. Dépendances et environnement

Les outils utilisés (logiciels, versions, langages, dépendances, etc.) n’étaient pas documentés.\
Dans la deuxième partie de ce README, nous avons tenté de préciser autant que possible les environnements et dépendances nécessaires à l’exécution du pipeline.

## 4. Données

### 4.1 Données d’entrée (input)

Les données d’entrée proviennent des séquençages des échantillons collectés lors du stage.\
Elles comprennent **6 fichiers .fastq.gz non diffusables** :

-   BP1.fastq.gz

-   BP2.fastq.gz

-   EP1.fastq.gz

-   EP2.fastq.gz

-   FP1.fastq.gz

-   FP2.fastq.gz

**Accès :** stockés sur le serveur du laboratoire de l’UNAM à Mexico City, avec un accès restreint.

Plusieurs problèmes les rendent non FAIR :

-   Non diffusables et accès restreint

<!-- -->

-   Noms trop peu explicites pour quelqu’un d’extérieur

<!-- -->

-   Absence de métadonnées décrivant l’origine, les conditions d’échantillonnage ou le contenu

### 4.2 Données de sortie (output)

Les fichiers produits lors des traitements n’étaient pas clairement identifiés.\
Retrouver les sorties pertinentes pour l’analyse était complexe, ce qui rendait la reproductibilité quasi impossible.\
Les obstacles principaux :

-   Noms peu compréhensibles

-   Formats non documentés ;

-   Absence d’explications sur le rôle des fichiers générés.

Ci-dessous, un exemple d’anciens noms de scripts (non FAIR).

|                       |
|-----------------------|
| qc_report_BP1.html    |
| BP1_filtered.fastq.gz |
| BP1.sam / .bam        |
| BP1_idxstats.txt      |
| taxonomy_BP1.csv      |

## 5. Scripts

Plusieurs éléments rendaient les scripts non FAIR :

-   Noms peu explicites,

-   Ordre d’utilisation non indiqué,

-   Absence de description de leur fonction,

-   Très peu de commentaires,

-   Lisibilité réduite,

-   Difficilement compréhensibles pour quelqu’un d’extérieur… voire pour l’auteur après quelques mois.

Cela rendait leur **réutilisation** particulièrement compliquée.

Exemple du contenu d’un ancien script :

```{python}
#!/bin/bash

# Se placer dans le bon dossier (adapter si besoin)
cd ~/bwa_psbO_tools

# Étape 1 : créer les dossiers si besoin
mkdir -p complexity_stats
mkdir -p data_filtered_post_bwa/final

# Étape 2 : extraire les stats de complexité
for prefix in BP EP FP; do
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
```

# **PARTIE 2 - ETAT FAIR**

But : décrire objectivement les étapes de FAIRISATION effectués en réponses aux éléments non-FAIR décrits en partie 1.

## **1. Contexte scientifique**

Les protocoles et materiels utilisés, ainsi que les métadonnées concernant le stages ont été nettement plus complètées au sein du document Metadonnées disponible dans notre projet Github, nous vous invitions ainsi à vous y référer pour plus d'informations à ces sujets.

## **2. Structure du projet**

L'arborescence a été retravaillé, et refaite afin de FAIRISER. On retrouvrel'exemple de ce qu'il aurait fallu faire est représenté ci-dessous. On y retrouve des fichiers claires et bien rangé, avec une structuration logique.

```{bash}
├── Inputs
│   ├── databases
│   │   ├── psbO_20210825.fna
│   │   └── psbO_taxonomy_map_fixed.tsv
│   └── raw_data
├── Outputs
│   ├── bwa_output
│   │   └── matched_ids
│   ├── complexity_stats
│   ├── data_filtered_post_bwa
│   ├── index_psbO
│   │   └── psbO_taxonomy_map_fixed.tsv
│   └── taxonomic_profiles
├── README.md
├── Scripts
│   ├── step0_taxonomy_map_creation.sh
│   ├── step1_filtrage_complexity.sh
│   ├── step2_run_bwa.sh
│   ├── step3_sequence_count.sh
│   ├── step4_analyze_composition_taxonomique.sh
│   └── step5_profil_and_abundancy.sh
└── Sol_Genomic_Mazatlan.Rproj

```

Avec:

-   Inputs = Comprent les données d'entrées. (en réalité en accés restreint)

-   Outputs = Contient les données sortant des scripts utilisées.

-   Readme = Fichier texte, comme celui dans lequel vous vous trouvez actuellement. Expliquant les différents éléments du projet.

-   Scripts = Contenant les scripts utilisées dans la mise en place de la pipeline

-   Sol_genomic_Mazatlan.Rproj = Contient le projet du logiciel de programmation utilisé (R dans cet exemple).

## **3. Dépendances et environnement**

Il faudra noter que cette liste est inssufisante, en effet certains outils et packages utilisé lors du stage ont été oublier avec le temps car ils n'ont opas été enregistrer/noter. D'où l'importance de garder une trace ecrite durant et tout le long de la réalisation du stage.

Listes à compléter selon ton stage des versions et logiciels utilisés

| Outil      | Version                      |
|------------|------------------------------|
| Python     | x.x.x                        |
| Visual     | x.x                          |
| samtools   | x.x                          |
| fastqc     | x.x                          |
| seqkit     | x.x                          |
|            | x.x                          |
| Packages R | dplyr x.x, ggplot2 x.x, etc. |

## **4. Données**

### **4.1 Données d'entrées (input)**

Pour rendre plus FAIR les données d'entrées, il aurait fallu par exemple leur attribuer un DOI et pour ce faire les rendres publiques. Ce qui n'est pas possibles ici, les données de séquencages étant restreintes sur le serveur du laboratoire de Mazatlan de l'UNAM.

Pour FAIRISER, les étapes d'acquisitions de ces données sont décrites ci-dessous:

1.  Séquencage des échantillons d'eaux réalisé par l'entreprise Koréenne MACROGENE, via la technique (TruSeq Nano and 8G on NovaSeq X 150PE) protocole décrit dans le le lien suivant: ......
2.  ...

### **4.2 Référence taxonomique**

Une partie de la FAIRISATION est aussi de donner les séquences psbO utilisé comme référence pour la comparaisons avec les séquences provenant des échantillons. Les séquences de références proviennent de [Pierella Karlusich *et al.* 2023,]{.underline} issues de bases eucaryotes et procaryotes.\
Lien : (S-BSST659), DOI: <https://doi.org/10.1111/1755-0998.13592>

[Ci-dessous un exemple d'une séquence issus de l'article :]{.underline}

```         
>CK_Cya_NS01_02631_5.2_5.2B_1_93-810 Bacteria;Cyanobacteria;Synechococcales;Synechococcaceae;Cyanobium;Cyanobium_sp. species=Cyanobium_sp. SubCluster=5.2 Clade=5.2 SubClade=5.2B Pigment.type=1 Reference=Doré_et_al.(2020) Database=Cyanorak-v2.1
CAATCTCACCTACGAAGACATCCACAACACCGGCCTGGCCAACGACTGCCCCTCCCTGCCCGAATCGGCCCGCGGTTCGATCCCCCTGGATTCCGGCACCGCCTACCAGCTCAGGGAGATCTGCATGCACCCCGCCGAGGTGTTCGTGAAGGGCGAACCCGCCAACAAGCGCCAGGAGGCCCAGTTCGTCGCCGGCAAGATCCTCACCCGCTTCACCACCAGCCTGGATCAGGTCTATGGCGACCTGACCGTCAGCGGTGACTCCCTCAACTTCAAGGAGCAGGGCGGTCTCGACTTCCAGATCGTCACCGTGTTGCTGCCCGGCGGTGAGGAGGTGCCCTTCGTGTTCTCCAGCAAGCAGCTCAAGGCCACGGCCGACGGCGCCGCCATCAGCACCAGCACGGACTTCACCGGCACCTACCGGGTGCCCAGCTACCGCACCTCCAACTTCCTGGATCCCAAGTCGCGCGGGCTCACCACCGGCGTGGACTACACCCAGGGCCTGGTGGGCCTCGGCGCCGACGGTGATGGCCTGGAGCGCGAGAACATCAAGAGCTACGTGGACGGCGCCGGCTCGATGGAGCTGGCGATCACCCGGGTGGATGCCAGCACCGGTGAGTTCGCCGGTGTGTTCACCGCCCTGCAGCCCTCCGACACCGACATGGGCTCCAAGGATCCCCTTGACGTGAAGATCACCGGTGAGGTCTACGGCCGTCTG
```

### 4.3 Données de sorties (output)

Pour FAIRISER les données de sorties....

## **5. Scripts**

Pour la FAIRISATION, chaques scripts a été renommer, et leur ordre d'utilisation bien énuméré. Leur contenue a également été largement améliorer, avec des annotations claires pour chaques étapes du scripts et leur fonctions, et une partie d'explication et d'introduction au début de chaque script a également été ajouté. De plus, les différents scripts utilisés et retravaillés sont énumérés et leur fonction expliqué ci dessous:

-   **step0_taxonomy_map_creation.sh =** Génère une table de correspondance entre les identifiants des séquences psbO et leur lignée taxonomique à partir du fichier FASTA. Cette *taxonomy map* est utilisée pour l’assignation taxonomique dans les étapes suivantes.

-   **step1_filtrage_complexity.sh =** Calcule la complexité de chaque read à l’aide de `seqkit fx2tab` et filtre les reads présentant une complexité ≥ 0,75. Produit un FASTQ contenant uniquement les reads conservés.

-   **step2_run_bwa.sh =** Aligne les reads filtrés (R1/R2) sur la référence psbO dédupliquée (`psbO_ref_unique.fna`) avec BWA-MEM. Les paramètres utilisés sont ajustés pour tolérer une forte variabilité des séquences environnementales.

-   **step3_sequence_count.sh =** Convertit les fichiers SAM produits par BWA en fichiers BAM triés et indexés, puis génère les statistiques de comptage par contig via `samtools idxstats`.

-   **step4_analyze_composition_taxonomique.sh =** Fusionne les données de comptage (`idxstats`) avec la *taxonomy map* afin de produire un profil d’abondance par taxon.

Un exemple d'un scirpt retravaillé est montré ci-dessous. Nous vous invitons à regarder le fichier des scripts retravailler dans le Github, afin de voir l'amélioration et la FAIRISATION effectué sur l'ensemble des scripts.

```{python}
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
```

## **7. Pipeline analytique**

1.  **QC** des reads → FastQC

2.  **Filtrage** (\<70 nt, complexité \>70%) → seqkit + perl

3.  **Préparation de la base psbO**

```         
-    modification des headers

-    déduplication (`seqkit rmdup`)

-    indexation (`bwa index`)
```

4.  **Alignement BWA MEM** avec paramètres permissifs

5.  **Comptage** (`samtools idxstats`)

6.  **Création de la taxonomy_map**

7.  **Génération des profils taxonomiques**

## **8. Outputs**

| Fichier               | Format   | Description                      |
|-----------------------|----------|----------------------------------|
| qc_report_BP1.html    | HTML     | Rapport de qualité FastQC        |
| BP1_filtered.fastq.gz | fastq.gz | Reads filtrés                    |
| BP1.sam / .bam        | SAM/BAM  | Alignement psbO                  |
| BP1_idxstats.txt      | TXT      | Comptage des alignements uniques |
| taxonomy_BP1.csv      | CSV      | Profil taxonomique final         |

## **9. Contact et licence**

Afin d'améliorer le critère FINDABLE, nous référencons ici des informations concernant les acteurs et établissements ayant participé à ce stage.

### **Contacts principaux**

-    **Autreur/ Développeur des scripts :**\
    Solane Cacao-Martins-Février — *Solane.cacao\@gmail.com*

-    **Superviseure scientifique :**\
    Dr. Tomasa Del Carmen Cuéllar Martinez — *tcuellar\@ola.icmyl.unam.mx*

### **Institution d’accueil**

**Instituto de Ciencias del Mar y Limnología (ICML)** – UNAM\
Av. Joel Montes Camarena S/N, Apartado Postal 811\
C.P. 82040, Mazatlán, Sinaloa, México\
Tel : +52 (669) 985-28-45

Les données produites durant ce stage sont **non publiques / soumises à restrictions**.\
Elles ne peuvent pas être redistribuées sans accord écrit de :

-    l’ICML-UNAM,

-    et de la superviseure Dr. Cuéllar Martinez.

Pour toute demande d'accès aux données, veuillez contacter les responsables listés ci-dessus.

**Perspectives FAIR :**\
Pour renforcer encore la conformité FAIR, nous aurions pu ajouter une **licence explicite** aux scripts et aux jeux de données, ainsi que renseigner les **identifiants ORCID** des contributeurs, **si ceux-ci avaient existé et été disponibles**. Cela aurait amélioré la traçabilité, l’attribution et la réutilisation des ressources.
