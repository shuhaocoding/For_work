'''
This script was modified from 'Meta-analysis_RNA-Seq.py, tailored to the needs of gene co-expression analysis (WGCNA). 
The script computes the total occurrence of each gene from the GO analysis results, to generate a list of candidate co-expressed genes.
'''
import os
import glob
import pandas as pd
import numpy as np
from numpy import mean

# Set the directory of your gene expression tables as working directory
os.chdir("/Users/shuhao/Desktop/for run")
# Fetch a list of file names from the directory
fl = glob.glob("./*.xlsx")

# Parse the data from individual files, and generate a set of candidate genes
all_genes = set()
gs_list = []
for file in fl:
    ls = pd.read_excel(file, header=0).Genes.tolist()
    gene_set = set()
    for string in ls:
        for item in string.split(","):
            gene_set.add(item)
            all_genes.add(item)
    gs_list.append(gene_set)

# Generate a dictionary that contains gene names as keys and the occurrence of gene names as items
count_dic = {}
for gene in all_genes:
    count = 0
    for gs in gs_list:
        if gene in gs:
            count+=1
    count_dic[gene] = count

# Write the above dictionary to a summary table
f = open('/Users/shuhao/Desktop/WGCNA gene list.txt', 'w')
header = 'name,occurrence'
f.write(header+'\n')
for gene in all_genes:
    f.write(gene+','+str(count_dic[gene])+'\n')
f.close()
