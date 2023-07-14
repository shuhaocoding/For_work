#!/bin/bash
# Alignment:
nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/CSMilM1_1.fq.gz ./seq/CSMilM1_2.fq.gz \
--outFileNamePrefix ./alignment/CSMilM1 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &

nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/CSMilM2_1.fq.gz ./seq/CSMilM2_2.fq.gz \
--outFileNamePrefix ./alignment/CSMilM2 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &

nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/CSMilM3_1.fq.gz ./seq/CSMilM3_2.fq.gz \
--outFileNamePrefix ./alignment/CSMilM3 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &

nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/CSMilM4_1.fq.gz ./seq/CSMilM4_2.fq.gz \
--outFileNamePrefix ./alignment/CSMilM4 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &

nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/RCSM1_1.fq.gz ./seq/RCSM1_2.fq.gz \
--outFileNamePrefix ./alignment/RCSM1 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &

nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/RCSM2_1.fq.gz ./seq/RCSM2_2.fq.gz \
--outFileNamePrefix ./alignment/RCSM2 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &

nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/RCSM3_1.fq.gz ./seq/RCSM3_2.fq.gz \
--outFileNamePrefix ./alignment/RCSM3 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &

nohup STAR --genomeDir ./genome \
--readFilesIn ./seq/RCSM4_1.fq.gz ./seq/RCSM4_2.fq.gz \
--outFileNamePrefix ./alignment/RCSM4 \
--outSAMtype BAM SortedByCoordinate \
--readFilesCommand zcat \
--runThreadN 20 \
--limitBAMsortRAM 7563196624 \
--winAnchorMultimapNmax 200 \
--outFilterMultimapNmax 100 &
