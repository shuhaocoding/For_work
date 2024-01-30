#!/bin/bash
# Counting reads using TE_transcript, for both genes and transposons, -t: treatment files and -c: control files can be adjusted accordingly
nohup TEtranscripts --sortByPos --format BAM --mode multi \
-t ./alignment/C57vMil1Aligned.sortedByCoord.out.bam \
./alignment/C57vMil2Aligned.sortedByCoord.out.bam \
./alignment/C57vMil3Aligned.sortedByCoord.out.bam \
./alignment/C57vMil4Aligned.sortedByCoord.out.bam \
-c ./alignment/C57vCS1Aligned.sortedByCoord.out.bam \
./alignment/C57vCS2Aligned.sortedByCoord.out.bam \
./alignment/C57vCS3Aligned.sortedByCoord.out.bam \
./alignment/C57vCS4Aligned.sortedByCoord.out.bam \
--GTF ~/data/Drosophila_melanogaster.BDGP6.32.106.gtf \
--TE ~/data/dm6_rmsk_TE_BDGP_chrom.gtf &

# Counting reads using htseq, count only genes, this following code can be repeated for multiple files.
# nohup htseq-count -f bam -r pos -s no ./alignment/CSWB1Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > CSWB1output_file.txt &
