\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

# **Titre du Stage**

## [**Analyse métagénomique de la diversité photosynthétique (gène psbO) dans la Baie de Mazatlán et le Lagon Urias (Mexique)**]{.underline}

Ce README documente l’ensemble des scripts, données, métadonnées et étapes analytiques utilisés durant le stage de Master 1 de **Solane Cacao-Martins-Février** au laboratoire XXX (Mazatlán, Mexique).\
Il vise à rendre le pipeline plus **FAIR** (Findable, Accessible, Interoperable, Reusable) et à faciliter la reproductibilité des analyses.

## **1. Contexte scientifique**

Le projet utilise une approche métagénomique ciblée sur le gène **psbO**, permettant d’obtenir un aperçu fonctionnel de la diversité photosynthétique (procaryotes + eucaryotes) dans différents sites :

-    **BP** : Stations de la Baie de Mazatlán

-    **EP** : Entrée du lagon (zone anthropisée)

-    **FP** : Fond du lagon

L’échantillonnage a été effectué à l’aide d’une bouteille Niskin à 1 m de profondeur. Les extraits ADN ont été séquencés (NGS, MacroGen ; paired-end 150 bp).

## **2. Objectif du README**

Montrer le **AVANT APRES FAIR**

Ce fichier décrit :

-    les **scripts** utilisés (Python, Visual, etc.),

-    les **formats et sources des données**,

-    les **outputs** générés,

-    les **versions logicielles**,

-    le **pipeline analytique complet**

## **3. Structure du projet**

= Mettre l'aborescence avant la fairisation ou un extrait, et expliquer comment on l'a rendu plus fair

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

## **4. Dépendances et environnement**

Listes à compléter selon ton stage des versions et logiciels utilisés

| Outil      | Version                      |
|------------|------------------------------|
| Python     | x.x.x                        |
| Visual     | x.x                          |
| samtools   | x.x                          |
| fastqc     | x.x                          |
| seqkit     | x.x                          |
| perl       | x.x                          |
| Packages R | dplyr x.x, ggplot2 x.x, etc. |

## **5. Données d’entrée (Input)**

### **5.1 Données brutes**

Les données proviennent des échantillons Niskin collectés lors du stage.\
Elles comprennent **6 fichiers .fastq.gz** non diffusables :

-    BP1.fastq.gz

-    BP2.fastq.gz

-    EP1.fastq.gz

-    EP2.fastq.gz

-    FP1.fastq.gz

-    FP2.fastq.gz

**Accès :** stockés sur le serveur du laboratoire XXX (Mazatlán), accès restreint.

### **5.2 Référence taxonomique**

Base psbO ([Pierella Karlusich *et al.* 2023]{.underline}) :\
Contient les séquences psbO issues de bases eucaryotes et procaryotes.\
Lien : (S-BSST659), DOI: <https://doi.org/10.1111/1755-0998.13592>

```         
Mettre là l'exemple du texte des seq que m'a montré Solane
```

## **6. Scripts**

Chaque script utilisé dans la mise en place du pipeline et la structuration des données est détaillé ci-dessous :

### **namescript1.R – Quality Control**

-    **Input** : fichiers FASTQ

-    **Output** : rapports FastQC

-    **Fonction** : contrôle de qualité, filtrage \<70 nt

    ### **namescript2.sh – Indexation de la base psbO**

-    **Input** : psb_db_unique.fasta

-    **Output** : fichiers d’index BWA

-    **Fonction** : préparation pour l'alignement

### **namescript3.sh – Alignement BWA + comptage**

-    **Input** : FASTQ filtrés

-    **Output** : .sam, .bam, idxstats.txt

-    **Commandes** : `bwa mem …` puis `samtools idxstats`

-   **Fonction** :

*(à compléter avec des exemples de scripts ???)*

## **7. Pipeline analytique**

1.   **QC** des reads → FastQC

2.   **Filtrage** (\<70 nt, complexité \>70%) → seqkit + perl

3.   **Préparation de la base psbO**

    -    modification des headers

    -    déduplication (`seqkit rmdup`)

    -    indexation (`bwa index`)

4.   **Alignement BWA MEM** avec paramètres permissifs

5.   **Comptage** (`samtools idxstats`)

6.   **Création de la taxonomy_map**

7.   **Génération des profils taxonomiques**

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
