#!/bin/bash
# Counting
nohup htseq-count -f bam -r pos -s no ./alignment/CSWB1Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > CSWB1output_file.txt &
nohup htseq-count -f bam -r pos -s no ./alignment/CSWB2Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > CSWB2output_file.txt &
nohup htseq-count -f bam -r pos -s no ./alignment/CSWB3Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > CSWB3output_file.txt &
nohup htseq-count -f bam -r pos -s no ./alignment/CSWB4Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > CSWB4output_file.txt &
nohup htseq-count -f bam -r pos -s no ./alignment/DfMB1Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > DfMB1output_file.txt &
nohup htseq-count -f bam -r pos -s no ./alignment/DfMB2Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > DfMB2output_file.txt &
nohup htseq-count -f bam -r pos -s no ./alignment/DfMB3Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > DfMB3output_file.txt &
nohup htseq-count -f bam -r pos -s no ./alignment/DfMB4Aligned.sortedByCoord.out.bam ~/data/dm6.ncbiRefSeq.gtf > DfMB4output_file.txt &