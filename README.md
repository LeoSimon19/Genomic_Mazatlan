# README du projet de FAIRISATION du sujet de stage de Master 1

### **Analyse métagénomique de la diversité photosynthétique (gène psbO) dans la Baie de Mazatlán et le Lagon Urias, Mexique** *Réalisé par Solane Cacao-Martins-Février, Mai-Juillet 2025*

#### **Projet de FAIRisation réalisé par :** Solane Cacao-Martins-Février, Léo Simon et Elwann Laurent

Ce README documente le processus de **FAIRisation** de l’ensemble des scripts, données, métadonnées et étapes analytiques utilisés durant le stage de Master 1 de Solane Cacao-Martins-Février au laboratoire de l’UNAM (Mazatlán, Mexique).\
L’objectif est de rendre le pipeline plus FAIR (**Findable, Accessible, Interoperable, Reusable**) en détaillant les actions mises en place pour passer d’un état initial « non FAIR » à un état amélioré.

Tout le projet n’a pas pu être entièrement FAIRisé, mais ce README présente et explique les éléments qui ont pu être clarifiés et rendus plus FAIR.

-   **PARTIE 1** : Contexte général du stage et état initial « non FAIR » de certains aspects.

-   **PARTIE 2** : Améliorations réalisées dans le cadre de la FAIRisation.

# PARTIE 1 — ÉTAT INITIAL (Non FAIR)

### Objectif

Dresser un état des lieux de la structuration des données, scripts et fichiers, et expliquer pourquoi ils ne respectaient pas les principes FAIR.

## 1. Contexte scientifique

Le projet utilise une approche métagénomique basée sur l’ADN environnemental (ADNe), ciblant l’assignation taxonomique de séquences comparées à une base de données du gène **psbO**, dans l’objectif d’obtenir un aperçu de la diversité des organismes planctoniques photosynthétiques (procaryotes + eucaryotes) et d’estimer leur abondance dans différents sites :

-    **BP (Bahía Photosynthetic)** : stations de la Baie de Mazatlán

-    **EP (Entrada Photosynthetic)** : entrée du lagon (zone anthropisée)

-    **FP (Fundo Photosynthetic)** : fond du lagon

L’échantillonnage de l’ADNe a été réalisé à l’aide de bouteilles Niskin à 1 m de profondeur. Les extraits d’ADNe ont ensuite été séquencés (NGS, MacroGen ; paired-end 150 bp).

## 2. Métadonnées

Les métadonnées initiales manquaient de nombreuses informations. Elles incluaient les positions géographiques des zones d’échantillonnage sans précision du format géographique, les identifiants des échantillons n’étaient ni précis ni informatifs, et plusieurs autres informations étaient absentes (ex. : technique d’échantillonnage, date, profondeur échantillonnée).

Une partie du tableau de métadonnées initiales est présentée ci-dessous à titre d’exemple :

|     |                 |           |             |       |
|-----|-----------------|-----------|-------------|-------|
| ID  | Stations        | Latitude  | Longitude   | Type  |
| 1   | Baie_Mazatlan_1 | 23.183611 | -106.446111 | Baie  |
| 2   | Baie_Mazatlan_2 | 23.20395  | -106.451567 | Baie  |
| 3   | Baie_Mazatlan_3 | 23.188689 | -106.4363   | Baie  |
| 4   | Baie_Mazatlan_4 | 23.218017 | -106.464358 | Baie  |
| 5   | Baie_Mazatlan_5 | 23.22745  | -106.4586   | Baie  |
| 6   | Baie_Mazatlan_6 | 23.171464 | -106.409192 | Urias |

## 2. Structure du projet initial

L’arborescence des dossiers du stage était organisée de manière très dispersée, avec un grand nombre de fichiers et de répertoires éparpillés sans logique apparente.\
Par exemple, l’environnement de travail de Solane comprenait [**590 répertoires** et **4 726 fichiers** différents.]{.underline}

Cela rendait tout retour sur les données très fastidieux pour l’auteur, et quasiment impossible pour une personne extérieure.\
Cet état initial était donc très peu FAIR, notamment concernant les critères **Accessible**, **Interoperable** (vocabulaire non standardisé, absence de liens entre les données) et **Reusable**.

Ci-dessous, un aperçu d’une infime partie de l’arborescence initiale :

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
..........
├── datasets
├── fastq_tara_pacific_station
│   ├── ERR562616_1.fastq
│   ├── ERR562616_2.fastq
│   ├── ERR562644_1.fastq
│   ├── ERR562644_2.fastq
│   ├── ERR562672_1.fastq
│   ├── ERR562672_2.fastq
│   ├── ERR598997_1.fastq
│   ├── ERR598997_2.fastq
│   └── ERR599118.fastq
├── fastxtend
│   ├── bin
│   │   ├── fastx_clean
│   │   ├── fastx_duplicatedReads
│   │   ├── fastx_mergepairs
│   │   └── fastx_stats
│   ├── fastx_clean
│   │   ├── fastx_clean.cpp
│   │   └── makefile
│   ├── fastx_duplicatedReads
│   │   ├── fastx_duplicatedReads.cpp
│   │   └── makefile
│   ├── fastx_mergepairs
│   │   ├── fastx_mergepairs.cpp
│   │   └── makefile
...........
```

Une FAIRISATION, soit ici une refonte structurée de l’organisation des dossiers était absolument nécessaire.

## 3. Dépendances et environnement

Les outils utilisés (logiciels, versions, langages, dépendances, etc.) n’étaient pas documentés. Dans la deuxième partie de ce README, nous avons tenté de préciser autant que possible les environnements et dépendances nécessaires à l’exécution du pipeline.

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

-   Noms trop peu explicites pour quelqu’un d’extérieur

-   Absence de métadonnées décrivant l’origine, les conditions d’échantillonnage ou le contenu

### 4.2 Données de sortie (output)

Les fichiers produits lors des traitements n’étaient pas clairement identifiés.\
Retrouver les sorties pertinentes pour l’analyse était complexe, ce qui rendait la reproductibilité quasi impossible.\
Les obstacles principaux :

-   Noms peu compréhensibles

-   Formats non documentés

-   Absence d’explications sur le rôle des fichiers générés

Ci-dessous, un exemple d’anciens noms de fichiers de sorties (non FAIR).

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

-   Difficilement compréhensibles pour une personne extérieure, voire même pour l’auteur après quelques mois.

Cela rendait leur **réutilisation** particulièrement compliquée.

Exemple du contenu d’un ancien script *"filtrage_complexity.sh"* :

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

Nous vous invitons à consulter le document ci-joint*" [Etat_initial_Scripts](https://github.com/LeoSimon19/Genomic_Mazatlan/tree/main/Etat_initial_Scripts)"* dans le dépôt GitHub, qui rassemble l’ensemble des anciens scripts dans leur forme initiale, avant FAIRisation.

# **PARTIE 2 - ETAT FAIR**

**But:** décrire de manière objective les étapes de FAIRisation mises en œuvre pour répondre aux éléments non-FAIR identifiés dans la partie 1.

## **1. Contexte scientifique**

Le contexte scientifique étant déjà relativement clair et constituant, à notre avis, une étape moins critique pour la FAIRisation, nous ne l’avons pas formellement FAIRisé.\
Cependant, avec davantage de temps, il aurait été intéressant d’y apporter des précisions supplémentaires afin de rapprocher encore le projet des principes FAIR.

## 2. Métadonnées

Les métadonnées, telles que les protocoles et le matériel utilisés, ont été **nettement complétées** dans le document ci-joint [Metadonnées.CSV](https://github.com/LeoSimon19/Genomic_Mazatlan/blob/main/Metadonnees/Metadonnees.csv), disponible dans notre projet GitHub. Nous vous invitons à vous y référer si besoin.

Parmi les modifications apportées :

-   Ajout des **dates** avec un format standardisé (YYYY-MM-DD) et indication de la saison.

-   Standardisation des **coordonnées géographiques** selon WGS 84 (°N, °E, DD.dddddd).

-   Ajout d’informations sur le **matériel et les prélèvements** effectués (bouteilles Niskin, volume filtré = 3 L, profondeur).

-   Inclusion des **conditions environnementales** (température).

-   Les identifiants des échantillons ont été **rendus plus précis et informatifs**.

Ci-dessous, un extrait du nouveau tableau de métadonnées après FAIRisation :

|  |  |  |  |  |  |  |  |
|---------|---------|---------|---------|---------|---------|---------|---------|
| Sample_ID | Stations | Ensemble_metagenome | Latitude(°N, DD .dddddd) | Longitude (°E, DD .dddddd) | Type | Date (YYYY-MM-DD)/saison | Méthode |
| BM_1 | Baie_Mazatlan_1 | BP_1 | 23,183611 | -106,446111 | Baie | 2025-06-?? / été | Niskin |
| BM_2 | Baie_Mazatlan_2 | BP_1 | 23,20395 | -106,451567 | Baie | 2025-06-?? / été | Niskin |
| BM_3 | Baie_Mazatlan_3 | BP_1 | 23,188689 | -106,4363 | Baie | 2025-06-?? / été | Niskin |

Nous vous invitons à consulter le nouveau tableau de métadonnées afin de visualiser l’ensemble des modifications et des propositions de FAIRisation effectuées.

**Attention :** certaines informations restent manquantes à ce jour, et certaines colonnes ne sont donc pas entièrement complètes, par exemple celles indiquant la salinité ou les jours d’échantillonnage.

## **2. Structure du projet**

L’arborescence a été retravaillée et réorganisée afin de FAIRiser le projet.\
Un exemple de la structure recommandée est présenté ci-dessous.\
On y retrouve des fichiers clairs et bien rangés, organisés selon une logique cohérente.

```{bash}
├── Etat_initial_Scripts
│   ├── analyze_composition_taxonomique.sh
│   ├── filtrage_complexity.sh
│   ├── run_bwa.sh
│   ├── seq_count.sh
│   └── Tax_Map_creation.sh
├── Inputs
│   ├── databases
│   │   └── psbO_20210825.fna
│   └── raw_data
├── Metadonnees
│   ├── Metadonnees.csv
│   └── protocole_echantillonnage.md
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
│   ├── step0_creation_taxonomique_map.sh
│   ├── step1_filtrage_complexite.sh
│   ├── step2_alignement_bwa.sh
│   ├── step3_sequence_comptage.sh
│   └── step4_analyse_composition_taxonomique.sh
└── Sol_Genomic_Mazatlan.Rproj

```

Avec:

-   **Etat_initial_Scripts** : Contient les scripts initiaux avant FAIRisation.
-   **Inputs** : Contient les données d’entrée (en accès restreint).
-   **Métadonnées** = Dossier comprenant les métadonnées retravaillées.
-   **Outputs** : Contient les données produites par les scripts et utilisées dans le pipeline.
-   **README** : Fichier texte expliquant les différents éléments du projet, comme celui dans lequel vous vous trouvez actuellement.
-   **Scripts** : Contient les scripts utilisés pour la mise en place du pipeline.
-   **Sol_genomic_Mazatlan.Rproj** : Projet R utilisé pour exécuter les analyses.

## **3. Dépendances et environnement**

Afin de rendre le projet plus Findable et Reusable, nous avons tenté de documenter les environnements, logiciels et versions utilisés durant le stage de Solane.\
Il convient de noter que cette liste reste incomplète, certains outils et packages ayant été oubliés avec le temps, faute d’avoir été enregistrés ou notés.\
Cela souligne l’importance de tenir une trace écrite tout au long de la réalisation d’un stage.

Liste des outils utilisé lors du stage:

| Outil           | Version      |
|-----------------|--------------|
| awk: GNU Awk    | 5.3.1        |
| Bash : GNU bash | 5.2.21       |
| samtools        | 1.19.2       |
| bwa             | 0.7.19-r1273 |
| seqkit          | 2.3.0        |

Les principaux outils utilisés dans ce projet de FAIRisation sont également listés ci-dessous :

| Outil                    | Version                  |
|--------------------------|--------------------------|
| Rstudio                  | 4.3.1                    |
| GitHub                   | 3.5.4                    |
| Excel                    | Excel 2024               |
| README (format Markdown) | intégrée à RStudio 4.3.1 |

## **4. Données**

### **4.1 Données d'entrées (input)**

Pour rendre plus FAIR les données d'entrées, il aurait fallu par exemple leur attribuer un DOI et pour ce faire les rendres publiques. Ce qui n'est pas possibles ici, les données de séquencages étant restreintes sur le serveur du laboratoire de Mazatlan de l'UNAM.

Pour FAIRISER ce qu'on pouvait des données d'entrées, les protocoles et les étapes d'acquisitions de celles-ci ont été décrites sur un fichier texte disponible dans le fichier métadonnées sur notr projet Github, présent ci-joint : " [*protocole_echantillonnage.md*](https://github.com/LeoSimon19/Genomic_Mazatlan/blob/main/Metadonnees/protocole_echantillonnage.md) *"*

### **4.2 Référence taxonomique**

Une partie de la FAIRISATION est aussi de donner les séquences psbO utilisé comme référence pour la comparaisons avec les séquences provenant des échantillons. Les séquences de références proviennent de [Pierella Karlusich *et al.* 2023,]{.underline} issues de bases eucaryotes et procaryotes.\
Lien : (S-BSST659), DOI: [*Pierella Karlusich et al., 2023*](https://doi.org/10.1111/1755-0998.13592){.uri}

[Ci-dessous un exemple d'une séquence issus de l'article :]{.underline}

```         
>CK_Cya_NS01_02631_5.2_5.2B_1_93-810 Bacteria;Cyanobacteria;Synechococcales;Synechococcaceae;Cyanobium;Cyanobium_sp. species=Cyanobium_sp. SubCluster=5.2 Clade=5.2 SubClade=5.2B Pigment.type=1 Reference=Doré_et_al.(2020) Database=Cyanorak-v2.1
CAATCTCACCTACGAAGACATCCACAACACCGGCCTGGCCAACGACTGCCCCTCCCTGCCCGAATCGGCCCGCGGTTCGATCCCCCTGGATTCCGGCACCGCCTACCAGCTCAGGGAGATCTGCATGCACCCCGCCGAGGTGTTCGTGAAGGGCGAACCCGCCAACAAGCGCCAGGAGGCCCAGTTCGTCGCCGGCAAGATCCTCACCCGCTTCACCACCAGCCTGGATCAGGTCTATGGCGACCTGACCGTCAGCGGTGACTCCCTCAACTTCAAGGAGCAGGGCGGTCTCGACTTCCAGATCGTCACCGTGTTGCTGCCCGGCGGTGAGGAGGTGCCCTTCGTGTTCTCCAGCAAGCAGCTCAAGGCCACGGCCGACGGCGCCGCCATCAGCACCAGCACGGACTTCACCGGCACCTACCGGGTGCCCAGCTACCGCACCTCCAACTTCCTGGATCCCAAGTCGCGCGGGCTCACCACCGGCGTGGACTACACCCAGGGCCTGGTGGGCCTCGGCGCCGACGGTGATGGCCTGGAGCGCGAGAACATCAAGAGCTACGTGGACGGCGCCGGCTCGATGGAGCTGGCGATCACCCGGGTGGATGCCAGCACCGGTGAGTTCGCCGGTGTGTTCACCGCCCTGCAGCCCTCCGACACCGACATGGGCTCCAAGGATCCCCTTGACGTGAAGATCACCGGTGAGGTCTACGGCCGTCTG
```

### 4.3 Données de sorties (output)

La FAIRISATION effectuée concernant les données de sorties a consisté à leur meilleur structuration et redirection dans l'arborescence, avec un espace dédié directement aux outputs. COrrigeant ainsi le problème de l'état initial dans le quel cette redirdction précise n'était pas faite et l'ensemble les données et fichiers de sorties étaient eparpillé à de nombreux endroits. AUcunes autres fairisation n'a été apporté aux outputs faute de temps, néanmoins il serait nécessaire d'en faire plus, en pensant nottament à mieux décrire la fonction des fichiers de sorties, leurs formats et les scripts auxquels ils sont associées.

On aurait pu avoir par exemple quelque chose comme ceci (**attention** les fichiers ci-dessous sont hypothétique et servent juste à un exemple de ce qui aurait pu être fait afin d'améliorer la FAIRisation) :

| Fichier               | Format   | Description                      |
|-----------------------|----------|----------------------------------|
| qc_report_BP1.html    | HTML     | Rapport de qualité FastQC        |
| BP1_filtered.fastq.gz | fastq.gz | Reads filtrés                    |
| BP1.sam / .bam        | SAM/BAM  | Alignement psbO                  |
| BP1_idxstats.txt      | TXT      | Comptage des alignements uniques |
| taxonomy_BP1.csv      | CSV      | Profil taxonomique final         |

## **5. Scripts**

Dans le cadre de la FAIRISATION, chacun des scripts a été renommé de manière cohérente, ordonné selon leur déroulé logique dans le pipeline, et enrichi de commentaires détaillés.\
Chaque script comporte désormais :

-   **Une introduction** décrivant son objectif, son rôle dans le pipeline et ses dépendances ;

-   **Des annotations claires et standardisées** pour chaque étape du code ;

-   **Des conventions de nommage homogènes** pour faciliter la traçabilité et la réutilisation ;

-   **Une structuration interne plus lisible**, améliorant la reproductibilité.

L’ensemble de ces améliorations permet de rendre le pipeline **plus FAIR**, notamment en améliorant sa *Findability* (scripts clairement nommés et organisés), son *Accessibility* (explications intégrées), son *Interoperability* (format standardisé, outils documentés) et sa *Reusability* (scripts commentés, logique explicite, dépendances précisées).

Les scripts retravaillés sont listés ci-dessous, accompagnés d’une brève description de leur fonction :

-   step0_taxonomy_map_creation.sh =

-   step1_filtrage_complexity.sh =

-   step2_run_bwa.sh =

-   step3_sequence_count.sh =

-   step4_analyze_composition_taxonomique.sh =

-   step5_profil_and_abundancy.sh =

```{python}
###############################################################################
# SCRIPT : step1_filtrage_complexite.sh
#
# OBJECTIF :
#   - Calculer la complexité de chaque read (via seqkit fx2tab).
#   - Filtrer les reads dont la complexité est ≥ 0.75.
#   - Extraire uniquement ces reads "complexes" dans un nouveau FASTQ.
#
#................
#
# FAIRNESS :
#   - Le script documente ses étapes, formats, outils et versions attendues.
#   - Les chemins sont explicites et versionnables.
#   - Les étapes sont déterministes et reproductibles.
#
# AUTEUR :
#   <CACAO M.F Solane> — <03/12/2025>
###############################################################################

### **namescript1.R – Quality Control**

-   **Input** : fichiers FASTQ

-   **Output** : rapports FastQC

-   **Fonction** : contrôle de qualité, filtrage \<70 nt

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

#.................
```

Veuillez trouvez ci-joint le lien vers le dossier contenant les nouveaux scripts FAIRISER : "[*Scripts*](https://github.com/LeoSimon19/Genomic_Mazatlan/tree/main/Scripts)*"*

## **7. Pipeline analytique**

Afin de rendre les étapes du pipeline plus **Findable**, **Interoperable** et **Reusable**, nous avons clarifié sa structure, normalisé les noms des scripts et explicitement documenté l’ordre des opérations.\
L’ensemble du pipeline est désormais organisé en étapes numérotées, chacune liée à un script unique et à une fonction précise.

Voici le déroulé du pipeline FAIRisé :

0.  **Création de la *taxonomy map***\
    *Script :* `step0_taxonomy_map_creation.sh`\
    = Génération d’un fichier de correspondance ID taxonomiques ↔ séquences psbO.
1.  **Contrôle qualité des reads (FastQC)**\
    *Script :* `step1_filtrage_complexity.sh`\
    = Vérification de la qualité globale des reads.
2.  **Filtrage des reads**\
    *Script :* `step1_filtrage_complexity.sh`
    -   Suppression des reads \< 70 nt

    -   Conservation des reads à complexité ≥ 0.75 (via `seqkit`)
3.  **Préparation de la base psbO**\
    *Script :* `step2_run_bwa.sh`
    -   Homogénéisation des en-têtes

    -   Déduplication (`seqkit rmdup`)

    -   Indexation de la base (`bwa index`)
4.  **Alignement BWA-MEM (paramètres permissifs)**\
    *Script :* `step2_run_bwa.sh`\
    Alignement des reads filtrés sur la base psbO dédupliquée.
5.  **Comptage des alignements**\
    *Script :* `step3_sequence_count.sh`\
    = Comptage du nombre d’alignements par contig via `samtools idxstats`.
6.  **Génération des profils taxonomiques**\
    *Script :* `step4_analyze_composition_taxonomique.sh`\
    = Croisement : *counts* + taxonomy_map → abondances taxonomiques.

## **9. Contact et licence**

Scripts libres / données restreintes.\
Contact : Solane Cacao-Martins-Février – email…\
Superviseur :

Laboratoire d'acceuil:

....

Afin d'améliorer le critère FINDABLE, nous référencons ici d'abord les auteurs de ce projet de FAIRISATION, puis des informations concernant les acteurs et établissements ayant participé au stage de Solane.

### **Contacts du Projet de Fairisation**

-   Auteurs:

    -   Solane Cacao-Martins-Février — *Solane.cacao\@gmail.com*

    -   Léo Simon — *Simonleo206\@gmail.com*

    -   Elwann Laurent — *Laurentelwann\@gmail.com*

### **Contacts principaux du stage**

-   **Autreur/ Développeur des scripts :**\
    Solane Cacao-Martins-Février — *Solane.cacao\@gmail.com*

-   **Superviseure scientifique :**\
    Dr. Tomasa Del Carmen Cuéllar Martinez — *tcuellar\@ola.icmyl.unam.mx*

### **Institution d’accueil du Stage**

**Instituto de Ciencias del Mar y Limnología (ICML)** – UNAM\
Av. Joel Montes Camarena S/N, Apartado Postal 811\
C.P. 82040, Mazatlán, Sinaloa, México\
Tel : +52 (669) 985-28-45

### Données du stage

Les données produites durant ce stage sont **non publiques / soumises à restrictions**.\
Elles ne peuvent pas être redistribuées sans accord écrit de :

-   l’ICML-UNAM,

-   et de la superviseure Dr. Cuéllar Martinez.

Pour toute demande d'accès aux données, il faudrait contacter les responsables listés ci-dessus.

## **10. Conclusion & remarques**

Ce projet de FAIRISATION a permis de clarifier et structurer l’ensemble du pipeline analytique issu du stage de Master 1, en améliorant sa lisibilité, sa traçabilité et son potentiel de réutilisation. Malgré la quantité importante de fichiers et l’hétérogénéité initiale du matériel, les principales étapes ont été documentées, les scripts réorganisés et commentés, et les informations critiques regroupées dans un format plus cohérent.

## **11. Perspectives d’amélioration**

Plusieurs actions qui n'ont pas été faites pourraient encore renforcer la conformité aux principes FAIR, notamment :

-   Ajouter une **licence officielle** aux scripts et aux métadonnées pour préciser les conditions de réutilisation ;

-   Associer des **identifiants ORCID** aux contributeurs pour améliorer l’attribution et la connexion aux profils scientifiques ;

-   Structurer davantage les métadonnées (formats standards, vocabulaires contrôlés) ;

-   Publier les scripts dans un dépôt institutionnel ou sur un archiveur pérenne (Zenodo, HAL) pour assurer leur **pérennité et citabilité**.

Globalement, ce travail constitue une base solide qui améliore significativement la transparence du pipeline et facilite sa diffusion future, tout en laissant des pistes claires pour aller vers une FAIRISATION encore plus complète.

## **12. Remerciements**

Nous remercions chaleureusement pour leur aide et leur accompagnement dans ce projet de FAIRISATION : N. Simon (MSU), A. Dairain (MSU), N. Henry (IR) et P. Estoup (IR).
