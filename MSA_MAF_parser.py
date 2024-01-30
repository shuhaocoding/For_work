'''
This script is to parse an MAF file of selected genomes and return a fasta file of your region of interest.
The resulting fasta file can be used for MSA to identify homologous genes. 
'''

import os
from Bio import AlignIO, SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from collections import defaultdict

# Set the genomic coordinates of your gene of interest
gene_start = 3544250  # The start position of your gene
gene_end = 3545750   # The end position of your gene
# Define the MAF file path
os.chdir("/Users/shuhao/Desktop/")
maf_file_path = "chrX.maf_124" # This can be set to any chromosome
output_fasta_path = "stae_other_species.fasta"
concatenated_sequences = defaultdict(str)

# Iterate through the alignment blocks in the MAF file
with open(maf_file_path, "r") as maf_file:
    alignments = AlignIO.parse(maf_file, "maf")
    for alignment in alignments:
        # Check if the alignment block contains Drosophila melanogaster chrX sequence
        for rec in alignment:
            if rec.id.startswith("dm6.chrX"):
                # Get the start and end coordinates of the aligned sequence
                seq_start = rec.annotations["start"]
                seq_end = seq_start + rec.annotations["size"]

                # Check if the aligned sequence overlaps with the gene of interest
                if seq_start <= gene_end and seq_end >= gene_start:

                    for record in alignment:
                        species = record.id.split('.')[0]
                        sequence = str(record.seq).replace('-', '')  # Remove hyphens, this is important for forming non-alignment fasta file, for following customized MSA
                        concatenated_sequences[species] += sequence

# Write the concatenated sequences to a FASTA file
records = []
for species, sequence in concatenated_sequences.items():
    record = SeqRecord(Seq(sequence).reverse_complement(), id=species, description="") # Stae is on the - strand so output the RC of genomic sequences
    records.append(record)
SeqIO.write(records, output_fasta_path, "fasta")
