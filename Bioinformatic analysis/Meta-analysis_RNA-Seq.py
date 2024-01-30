'''
I wrote this script to form a candidate gene list from multiple differential expression analysis datasets. The datasets are from different KO/KD mutants of the same gene, versus controls.
The script computes the total occurrence, the average expression, and the average fold change of each gene from the datasets.
The script can be used as a meta-analysis of RNA-Seq. The result of this script can be combined with other analyses, such as WGCNA, to select candidate genes for further functional studies.
'''

import os
import glob
import pandas as pd
import numpy as np
from numpy import mean

# Set the directory of your gene expression tables as working directory
os.chdir("/Users/shuhao/Desktop/BWM")
# Fetch a list of file names from the directory
fl = glob.glob("./*.csv")

# Parse the data from individual files, and generate a set of candidate genes
dic_list = []
gn_list = []
gn_set = set()
for file in fl:
    dics = pd.read_csv(file, header=0).set_index('name').to_dict('index') # Convert each csv file to a nested dictionary
    dic_list.append(dics) # Generate a list of all dictionaries
    df = pd.read_csv(file, header=0)
    gn_list.append(df.name.tolist()) # Generate a list of all gene name lists
    gn_set = gn_set|set(df.name.tolist()) # Generate a set of all gene names

# Generate a dictionary that contains gene names as keys and the occurrence of gene names as items
count_dic = {}
for gn in gn_set:
    count = 0
    for gnl in gn_list:
        if gn in gnl:
            count+=1
    count_dic[gn] = count

# Generate two other dictionaries that contain gene names as keys and the average baseMean/log2FoldChange values as items
expression_dic = {}
foldchange_dic = {}
for gn in gn_set:
    expl = []
    chl = []
    for dic in dic_list:
        if gn in dic:
            expl.append(dic[gn]['baseMean'])
            chl.append(abs(dic[gn]['log2FoldChange']))
    aveexp = mean(expl)
    avech = mean(chl)
    expression_dic[gn] = aveexp
    foldchange_dic[gn] = avech
    
# Combine and write all three dictionaries to a summary table
f = open('/Users/shuhao/Desktop/candidate gene list_BWM.txt', 'w')
header = 'name,occurrence,ave_exp,ave_log2ch'
f.write(header+'\n')
for gn in gn_set:
    f.write(gn+','+str(count_dic[gn])+','+str(expression_dic[gn])+','+str(foldchange_dic[gn])+'\n')
f.close()
