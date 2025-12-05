# [**Analyse de la diversité photosynthétique par le gène psb0**]{.underline}

Ce fichier explique le protocole d’échantillonnage et de traitement des données métagénomiques utilisé dans le cadre de l’analyse de la diversité planctonique photosynthétique de la baie de Mazatlán en utilisant le gène psb0 comme référence. L’objectif étant d’utiliser l’outil métagénomique pour avoir un aperçu rapide, complet et fonctionnel de la diversité photosynthétique et procaryotique de la baie de Mazatlán et du Lagon Urias

[Logiciels et versions nécessaires :]{.underline}

-   awk : GNU Awk 5.3.1

-   bash : GNU bash, version 5.2.21

-   sort : version 9.4

-   samtools : version 1.19.2

-   bwa : version 0.7.19-r1273

-   seqkit : version 2.3.0

[**Echantillonnage :**]{.underline}

12 stations sont déjà régulièrement utilisées par l’observatoire :

-   6 stations caractérisant la Baie de Mazatlán (nommées BP)

-   3 stations caractérisant l’entrée du Lagon (nommées EP)

-   3 stations caractérisant le fond du Lagon (nommées FP)

    -   ----\> Voir Tableau de Métadonnées pour leur position exacte

[Matériel :]{.underline}

-   Bouteille Niskin de 5L

-   3 réservoirs de 20 L (1 par station)

-   Filtres micropores 0.22 µm

#### [**Protocole :**]{.underline}

[Echantillonnage :]{.underline}

Lavage préalable des réservoirs et de la bouteille de prélèvement (javel + eau distillée) Prélèvement des échantillons en surface (1 m de profondeur) Rinçage préalable à l’eau de mer 3 L prélevés par station : regroupés dans 1 seul réservoir : BP, EP ou FP Filtration et Conservation : Filtrage de l’eau des réservoirs : filtres 0,22 µm Conservation des filtres contenant l’ADN au congélateur avec billes de silices (déshydratation totale)

[Extraction et Purification :]{.underline}

Extraction + purification de l’ADN 🡪 kit DNeasy PowerSoil Pro Kit (50) Séquençage : Envoi à MacroGen 🡪 TruSeq Nano and 8G on NovaSeq X 150PE (NGS) Longueur des reads : 150 pb Les résultats de séquençages sont rendus disponibles par l’entreprise procédant au séquençage. (Ici, il s’agit de 6 fichiers .fastq.gz : BP1, EP1,FP1)

[Traitement des données metagénomiques :]{.underline}

Les scripts, le Workflow ainsi que tous les éléments nécessaires au traitement des données séquencées brutes jusqu'à l’obtention de données exploitables est traité et rendu disponible dans Git : voir « ReadMe ».

[Base de référence :]{.underline} psb0 (Rappel) La base de donnée (Pierella Karlusich et al. 2023) est disponible librement ([https://www.ebi.ac.uk/biostudies/studies/S-BSST659](#0){.uri}) et contient les différentes séquences du gène psb0 issues du croisement de nombreuses bases de données. Elle est ici utilisée pour tester son application en tant qu’outil moléculaire de détection des différents organismes photosynthétiques, procaryotes et eucaryotes. Voir article ci-dessous :

Pierella Karlusich, Juan José, Eric Pelletier, Lucie Zinger, et al. 2023. « A Robust Approach to Estimate Relative Phytoplankton Cell Abundances from Metagenomes ». Molecular Ecology Resources 23 (1): 16-40. <https://doi.org/10.1111/1755-0998.13592>.
