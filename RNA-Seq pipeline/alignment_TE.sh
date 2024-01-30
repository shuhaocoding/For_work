#!/bin/bash
# Alignment using STAR, ./seq folder to put fastq files, ./genome folder to put genome index files, ./alignment to put output files.
# Create genome index files
nohup STAR --runMode genomeGenerate \
--genomeDir ./genome \
--genomeFastaFiles ~/data/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa \
--sjdbGTFfile ~/data/Drosophila_melanogaster.BDGP6.32.106.gtf &

# This block of code can be repeated to align multiple fastq files. Each block read two paired files from paired end sequencing.
nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/CSMilM1_1.fq.gz ./seq/CSMilM1_2.fq.gz \
--outFileNamePrefix ./alignment/CSMilM1 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &
