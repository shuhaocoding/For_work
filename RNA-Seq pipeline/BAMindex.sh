#!/bin/bash
# Bam index, required for some pipelines, can be repeated several times as well
nohup samtools index CSWB1Aligned.sortedByCoord.out.bam & # the name of bam files can be modified