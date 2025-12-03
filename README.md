\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## [**Projet de FAIRISATION du sujet de stage de Master 1:**]{.underline}

## [**Analyse métagénomique de la diversité photosynthétique (gène psbO) dans la Baie de Mazatlán et le Lagon Urias (Mexique)**]{.underline}

Ce README documente le processus de FAIRISATION de l’ensemble des scripts, données, métadonnées et étapes analytiques utilisés durant le stage de Master 1 de **Solane Cacao-Martins-Février** au laboratoire XXX (Mazatlán, Mexique).\
Il vise à rendre le pipeline plus **FAIR** (Findable, Accessible, Interoperable, Reusable) et à faciliter la reproductibilité des analyses. En expliquant nottament les différentes étapes de FAIRISATION mises en place dans cette démarche. Tout le projet n'a pas pu être entièrement FAIRISE, mais ce Readme sert à montrer et expliquer les différentes choses qui ont pu l'être.

La partie une présente le context général du stage et l'état initial "non-FAIR" de certains points, tandis que la partie deux présente des objets qui ont été amélioré dans le but de FAIRISATOIN.

# **PARTIE 1 - ETAT INITIAL (Non-FAIR)**

But : décrire objectivement comment étaient les données, scripts, fichiers, et pourquoi ça n’était PAS FAIR.

## **1. Contexte scientifique**

Le projet utilise une approche métagénomique ciblée sur le gène **psbO**, dans l'objectif d’obtenir un aperçu fonctionnel de la diversité photosynthétique (procaryotes + eucaryotes) dans différents sites :

-   **BP** : Stations de la Baie de Mazatlán

-   **EP** : Entrée du lagon (zone anthropisée)

-   **FP** : Fond du lagon

L’échantillonnage a été effectué à l’aide de bouteille Niskin à 1 m de profondeur à . Les extraits ADN ont été séquencés (NGS, MacroGen ; paired-end 150 bp). Pour plus d'informations concernant les protocoles utilisés durant le stage, nous vous invitons à vous référer au document de métadonnées disponible dans notre dossier github. Ce dernier que nous avons amélioré et précisé dans le processus de FAIRISATION.

## 2. Structure du projet intitial

L'arborescence des dossiers du stages était organisé de facon très dispersé avec un très grands nombres de fichiers et dossier dans tous les sens. Par exemple, l'environnement de travail de Solane comprenaient 590 répertoires et 4726 fichiers différents. Ce qui rendait pour l'auteur du projet un replongement dans les donnnées très fastideux, rendant cette tâche pour une personne extérieur absolument impossible. Ce qui est en fait très peu FAIR, nottament sur les trois critères Accessible, Interoperable et Reusable.

Voyez ci-dessous, une capture d'écran d'une infime partie de l'arborescence du projet intial, infime car celle-etait gigantesque.

```         
├── psbO_db.4.bt2
│   ├── psbO_db.rev.1.bt2
│   ├── psbO_db.rev.2.bt2
│   ├── ref_humangenom.1.bt2
│   ├── ref_humangenom.2.bt2
│   ├── ref_humangenom.3.bt2
│   ├── ref_humangenom.4.bt2
│   ├── ref_humangenom.rev.1.bt2
│   └── ref_humangenom.rev.2.bt2
├── bwa_psbO_tools
│   ├── analyze_composition_taxonomique.sh
│   ├── BP_1.fastq.gz -> ../metagenomics_mzt/BP_1.fastq.gz
│   ├── BP_2.fastq.gz -> ../metagenomics_mzt/BP_2.fastq.gz
│   ├── bwa_output
│   │   ├── aligned_only
│   │   │   ├── BP_aligned.sam
│   │   │   ├── EP_aligned.sam
│   │   │   └── FP_aligned.sam
│   │   ├── BP_filtered.sam
│   │   ├── BP_filtered_unique.sam
│   │   ├── EP_filtered.sam
│   │   ├── EP_filtered_unique.sam
│   │   ├── FP_filtered.sam
│   │   ├── FP_filtered_unique.sam
│   │   └── matched_ids
│   │       ├── BP_ref_counts_inv.tsv
│   │       ├── BP_ref_counts_tab.txt
│   │       ├── BP_ref_counts.txt
│   │       ├── BP_ref_counts.txt.bak
│   │       ├── BP_ref_hits.txt
│   │       ├── EP_ref_counts_inv.tsv
│   │       ├── EP_ref_counts_tab.txt
│   │       ├── EP_ref_counts.txt
│   │       ├── EP_ref_hits.txt
│   │       ├── FP_ref_counts_inv.tsv
│   │       ├── FP_ref_counts_tab.txt
│   │       ├── FP_ref_counts.txt
│   │       └── FP_ref_hits.txt
│   ├── complexity_stats
│   │   ├── BP_1_ids.txt
│   │   ├── BP_1_stats.tsv
│   │   ├── BP_2_ids.txt
│   │   ├── BP_2_stats.tsv
│   │   ├── EP_1_ids.txt
│   │   ├── EP_1_stats.tsv
│   │   ├── EP_2_ids.txt
│   │   ├── EP_2_stats.tsv
│   │   ├── FP_1_ids.txt
│   │   ├── FP_1_stats.tsv
│   │   ├── FP_2_ids.txt
│   │   └── FP_2_stats.tsv
│   ├── data_filtered_post_bwa
│   │   ├── BP_1_min70.fastq
│   │   ├── BP_2_min70.fastq
│   │   ├── EP_1_min70.fastq
│   │   ├── EP_2_min70.fastq
│   │   ├── FP_1_min70.fastq
│   │   └── FP_2_min70.fastq
│   ├── EP_1.fastq.gz -> ../metagenomics_mzt/EP_1.fastq.gz
│   ├── EP_2.fastq.gz -> ../metagenomics_mzt/EP_2.fastq.gz
│   ├── filtrage_complexity.sh
│   ├── FP_1.fastq.gz -> ../metagenomics_mzt/FP_1.fastq.gz
│   ├── FP_2.fastq.gz -> ../metagenomics_mzt/FP_2.fastq.gz
│   ├── index_psbO
│   │   ├── psbO_20210825.fna -> ../psbO_20210825.fna
│   │   ├── psbO_20210825.fna.amb
│   │   ├── psbO_20210825.fna.ann
│   │   ├── psbO_20210825.fna.bwt
│   │   ├── psbO_20210825.fna.pac
│   │   ├── psbO_20210825.fna.sa
│   │   ├── psbO_ref_unique.fna
│   │   ├── psbO_ref_unique.fna.amb
│   │   ├── psbO_ref_unique.fna.ann
│   │   ├── psbO_ref_unique.fna.bwt
│   │   ├── psbO_ref_unique.fna.pac
│   │   ├── psbO_ref_unique.fna.sa
│   │   └── taxonomy_map
│   │       ├── psbO_taxonomy_map_fixed.tsv
│   │       ├── psbO_taxonomy_map.tsv
│   │       └── psbO_taxonomy_map.tsv.bak
│   ├── matched_ids
│   │   ├── BP_ref_hits.txt
│   │   ├── EP_ref_hits.txt
│   │   └── FP_ref_hits.txt
│   ├── psbO_20210825.fna -> /botete/solane/databases/psbO_20210825.fna
│   ├── psbO_taxonomy_map.tsv -> index_psbO/taxonomy_map/psbO_taxonomy_map.tsv
│   ├── run_bwa.sh
│   └── taxonomic_profiles
│       ├── BP_taxonomic_profile_newtest.tsv
│       ├── BP_taxonomic_profile.tsv
│       ├── EP_taxonomic_profile_newtest.tsv
│       ├── EP_taxonomic_profile.tsv
│       ├── FP_taxonomic_profile_newtest.tsv
│       └── FP_taxonomic_profile.tsv
 ...................
```

Une FAIRISATION de cette arborescence avec un exemple de départ et des parties bien disctinctes est absolument nécessaire.

## **3. Dépendances et environnement**

Les outils informatiques utilisés tel que les logiciels, les versions de ces logiciels, les langages de codes etc, n'étaient pas décrit. Ce qui n'est pas FAIR du tout. Dans la deuxième partie de ce Read me nous avons donc essayé de préciser le plus de choses concernant les environnement utilisés que possible.

## 4. Données

### 4.1 Données d'entrées (input)

Les données d'entrées sont très conséquentes et proviennent des séquencages réalisés via les échantillons Niskin collectés lors du stage.\
Elles comprennent **6 fichiers .fastq.gz** non diffusables :

-   BP1.fastq.gz

-   BP2.fastq.gz

-   EP1.fastq.gz

-   EP2.fastq.gz

-   FP1.fastq.gz

-   FP2.fastq.gz

**Accès :** stockés sur le serveur du laboratoire XXX (Mazatlán), avec un accès restreint.

Le fait qu'il ne soient pas difusables et restreint sur le serveur du laboratoire n'est pas FAIR. De plus leur nomination ne sont pas claires pour quelqu'un extèrieur au projet.

### 4.1 Données de sorties (output)

Les fichiers de données sortantes n'étaient pas très claires, avec des noms peu compréhensible, les formats non informés, et pas d'explication sur l'utilité de chaques sortie. Ci-dessous un exemple des noms des anciens scripts:

|                       |
|-----------------------|
| qc_report_BP1.html    |
| BP1_filtered.fastq.gz |
| BP1.sam / .bam        |
| BP1_idxstats.txt      |
| taxonomy_BP1.csv      |

## **5. Scripts**

Plusieurs aspects des scripts les rendaient non FAIR. Leur noms n'étaient pas claires, nottament n'indiquant pas leur ordre d'utilisationdans la formation de la pipeline. La fonction de chaque script n'était pas précisé. De plus, les scripts en eux mêmes étaient très difficilement lisible, avec peu d'annotations et donc peu compréhensible, pour toute personne extèrieur mais aussi par l'auteur lui même. Rendant très compliqué leur réutilisations.

Exemple du contenue d'un des anciens scripts:

```         
```

# **PARTIE 2 - ETAT FAIR**

## **1. Objectif de la partie 2**

Ce fichier décrit :

-   les **scripts** utilisés (Python, Visual, etc.),

-   les **formats et sources des données**,

-   les **outputs** générés,

-   les **versions logicielles**,

-   le **pipeline analytique complet**

## **2. Structure du projet**

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
| perl       | x.x                          |
| Packages R | dplyr x.x, ggplot2 x.x, etc. |

## **4. Données d’entrée (Input)**

### **4.1 Données brutes**

Les données proviennent des échantillons Niskin collectés lors du stage.\
Elles comprennent **6 fichiers .fastq.gz** non diffusables :

-   BP1.fastq.gz

-   BP2.fastq.gz

-   EP1.fastq.gz

-   EP2.fastq.gz

-   FP1.fastq.gz

-   FP2.fastq.gz

**Accès :** stockés sur le serveur du laboratoire XXX (Mazatlán), accès restreint.

### **4.2 Référence taxonomique**

Base psbO ([Pierella Karlusich *et al.* 2023]{.underline}) :\
Contient les séquences psbO issues de bases eucaryotes et procaryotes.\
Lien : (S-BSST659), DOI: <https://doi.org/10.1111/1755-0998.13592>

[Ci-dessous un exemple d'une séquence issus de l'article :]{.underline}

```         
>CK_Cya_NS01_02631_5.2_5.2B_1_93-810 Bacteria;Cyanobacteria;Synechococcales;Synechococcaceae;Cyanobium;Cyanobium_sp. species=Cyanobium_sp. SubCluster=5.2 Clade=5.2 SubClade=5.2B Pigment.type=1 Reference=Doré_et_al.(2020) Database=Cyanorak-v2.1
CAATCTCACCTACGAAGACATCCACAACACCGGCCTGGCCAACGACTGCCCCTCCCTGCCCGAATCGGCCCGCGGTTCGATCCCCCTGGATTCCGGCACCGCCTACCAGCTCAGGGAGATCTGCATGCACCCCGCCGAGGTGTTCGTGAAGGGCGAACCCGCCAACAAGCGCCAGGAGGCCCAGTTCGTCGCCGGCAAGATCCTCACCCGCTTCACCACCAGCCTGGATCAGGTCTATGGCGACCTGACCGTCAGCGGTGACTCCCTCAACTTCAAGGAGCAGGGCGGTCTCGACTTCCAGATCGTCACCGTGTTGCTGCCCGGCGGTGAGGAGGTGCCCTTCGTGTTCTCCAGCAAGCAGCTCAAGGCCACGGCCGACGGCGCCGCCATCAGCACCAGCACGGACTTCACCGGCACCTACCGGGTGCCCAGCTACCGCACCTCCAACTTCCTGGATCCCAAGTCGCGCGGGCTCACCACCGGCGTGGACTACACCCAGGGCCTGGTGGGCCTCGGCGCCGACGGTGATGGCCTGGAGCGCGAGAACATCAAGAGCTACGTGGACGGCGCCGGCTCGATGGAGCTGGCGATCACCCGGGTGGATGCCAGCACCGGTGAGTTCGCCGGTGTGTTCACCGCCCTGCAGCCCTCCGACACCGACATGGGCTCCAAGGATCCCCTTGACGTGAAGATCACCGGTGAGGTCTACGGCCGTCTG
```

## **5. Scripts**

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
