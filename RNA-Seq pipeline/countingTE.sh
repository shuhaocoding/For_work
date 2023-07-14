#!/bin/bash
# Counting
nohup TEtranscripts --sortByPos --format BAM --mode multi \
-t ./alignment/RMilM1Aligned.sortedByCoord.out.bam \
./alignment/RMilM2Aligned.sortedByCoord.out.bam \
./alignment/RMilM3Aligned.sortedByCoord.out.bam \
./alignment/RMilM4Aligned.sortedByCoord.out.bam \
-c ./alignment/RCSM1Aligned.sortedByCoord.out.bam \
./alignment/RCSM2Aligned.sortedByCoord.out.bam \
./alignment/RCSM3Aligned.sortedByCoord.out.bam \
./alignment/RCSM4Aligned.sortedByCoord.out.bam \
--GTF ~/data/Drosophila_melanogaster.BDGP6.32.106.gtf \
--TE ~/data/dm6_rmsk_TE_BDGP_chrom.gtf &