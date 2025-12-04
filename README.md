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

-    **BP (Bahía Photosynthetic)** : stations de la Baie de Mazatlán

-    **EP (Entrada Photosynthetic)** : entrée du lagon (zone anthropisée)

-    **FP (Fundo Photosynthetic)** : fond du lagon

L’échantillonnage de l’ADNe a été réalisé à l’aide de bouteilles Niskin à 1 m de profondeur. Les extraits d’ADNe ont ensuite été séquencés (NGS, MacroGen ; paired-end 150 bp).

Pour plus d’informations sur les protocoles utilisés durant le stage, veuillez consulter le document de métadonnées disponible dans le dépôt GitHub. Celui-ci a été clarifié et enrichi dans le cadre du processus de FAIRISATION.

-\> (Lien vers tableau métadonnées)

## 2. Structure du projet initial

L’arborescence des dossiers du stage était organisée de manière très dispersée, avec un grand nombre de fichiers et de répertoires éparpillés sans logique apparente.\
Par exemple, l’environnement de travail de Solane comprenait [**590 répertoires** et **4 726 fichiers** différents.]{.underline}

Cela rendait tout retour sur les données très fastidieux pour l’auteur, et quasiment impossible pour une personne extérieure.\
Cet état initial était donc très peu FAIR, notamment concernant les critères **Accessible**, **Interoperable** (vocabulaire non standardisé, absence de liens entre les données) et **Reusable**.

Ci-dessous, un aperçu d’une infime partie de l’arborescence initiale.\
├── psbO_db.4.bt2
│ ├── psbO_db.rev.1.bt2
│ ├── psbO_db.rev.2.bt2
│ ├── ref_humangenom.1.bt2
│ ├── ref_humangenom.2.bt2
│ ├── ref_humangenom.3.bt2
│ ├── ref_humangenom.4.bt2
│ ├── ref_humangenom.rev.1.bt2
│ └── ref_humangenom.rev.2.bt2
├── bwa_psbO_tools
│ ├── analyze_composition_taxonomique.sh
│ ├── BP_1.fastq.gz -\> ../metagenomics_mzt/BP_1.fastq.gz
│ ├── BP_2.fastq.gz -\> ../metagenomics_mzt/BP_2.fastq.gz
│ ├── bwa_output
│ │ ├── aligned_only
│ │ │ ├── BP_aligned.sam
│ │ │ ├── EP_aligned.sam
│ │ │ └── FP_aligned.sam
│ │ ├── BP_filtered.sam
│ │ ├── BP_filtered_unique.sam
│ │ ├── EP_filtered.sam
│ │ ├── EP_filtered_unique.sam
│ │ ├── FP_filtered.sam
│ │ ├── FP_filtered_unique.sam
│ │ └── matched_ids
..........
│ ├── matched_ids
│ │ ├── BP_ref_hits.txt
│ │ ├── EP_ref_hits.txt
│ │ └── FP_ref_hits.txt
│ ├── psbO_20210825.fna -\> /botete/solane/databases/psbO_20210825.fna
│ ├── psbO_taxonomy_map.tsv -\> index_psbO/taxonomy_map/psbO_taxonomy_map.tsv
│ ├── run_bwa.sh
│ └── taxonomic_profiles
│ ├── BP_taxonomic_profile_newtest.tsv
│ ├── BP_taxonomic_profile.tsv
│ ├── EP_taxonomic_profile_newtest.tsv
│ ├── EP_taxonomic_profile.tsv
│ ├── FP_taxonomic_profile_newtest.tsv
│ └── FP_taxonomic_profile.tsv
..........

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

Pour la FAIRISATION, chaques scripts a été renommer, et leur ordre d'utilisation bien énuméré. Leur contenue a également été largement améliorer, avec des annotations claires pour chaques étapes du scripts et leur fonctions. De plus, les différents scripts utilisés et retravaillés sont énumérés et leur fonction expliqué ci dessous:

-   step0_taxonomy_map_creation.sh =

-   step1_filtrage_complexity.sh =

-   step2_run_bwa.sh =

-   step3_sequence_count.sh =

-   step4_analyze_composition_taxonomique.sh =

-   step5_profil_and_abundancy.sh =

Chaque script utilisé dans la mise en place du pipeline et la structuration des données est détaillé ci-dessous :

### **namescript1.R – Quality Control**

-   **Input** : fichiers FASTQ

-   **Output** : rapports FastQC

-   **Fonction** : contrôle de qualité, filtrage \<70 nt

```         
### **namescript2.sh – Indexation de la base psbO**
```

-   **Input** : psb_db_unique.fasta

-   **Output** : fichiers d’index BWA

-   **Fonction** : préparation pour l'alignement

### **namescript3.sh – Alignement BWA + comptage**

-   **Input** : FASTQ filtrés

-   **Output** : .sam, .bam, idxstats.txt

-   **Commandes** : `bwa mem …` puis `samtools idxstats`

-   **Fonction** :

*(à compléter avec des exemples de scripts ???)*

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

Scripts libres / données restreintes.\
Contact : Solane Cacao-Martins-Février – email…\
Superviseur :

Laboratoire d'acceuil:

....
