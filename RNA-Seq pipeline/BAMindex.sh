#!/bin/bash
# Bam index:
nohup samtools index CSWB1Aligned.sortedByCoord.out.bam &
nohup samtools index CSWB2Aligned.sortedByCoord.out.bam &
nohup samtools index CSWB3Aligned.sortedByCoord.out.bam &
nohup samtools index CSWB4Aligned.sortedByCoord.out.bam &
nohup samtools index DfMB1Aligned.sortedByCoord.out.bam &
nohup samtools index DfMB2Aligned.sortedByCoord.out.bam &
nohup samtools index DfMB3Aligned.sortedByCoord.out.bam &
nohup samtools index DfMB4Aligned.sortedByCoord.out.bam &
