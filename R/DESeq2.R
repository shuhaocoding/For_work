library(DESeq2)
setwd("/Users/shuhao/Files/UMMS/Research/Protocols/RNA-Seq/RNA-Seq try/Stae_KO_CNS") 
counts_data <- read.csv('counts_matrix.csv', header = TRUE, sep = ",") 
sample_data <- read.csv('sample_table.csv', header = TRUE, sep = ",") 
all(colnames(counts_data) %in% rownames(sample_data))
all(colnames(counts_data) == rownames(sample_data)) # MAKING SURE THE ROW NAMES IN colData MATCHES TO COLUMN NAMES IN counts_data

dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = sample_data,
                              design = ~ condition, tidy = TRUE)
keep <- rowSums(counts(dds)) >=10 # keeping rows that have at least 10 reads total
dds <- dds[keep,]
dds
dds$condition <- relevel(dds$condition, ref = "control")

# RUN DESEQ2 FUNCTION TO PERFORM THE DIFFERENTIAL EXPRESSION ANALYSIS
dds <- DESeq(dds)
res <- results(dds)
resOrdered <- res[order(res$pvalue),]
resSig <- res[(!is.na(res$padj) & (res$padj < 0.050000) & (abs(res$log2FoldChange)> 0.000000)), ]
resSigOrdered <- resSig[order(resSig$pvalue),]
write.csv(res, file = "Results_DESeq2_Statera_Trial_CNS_all_genes.csv")
write.csv(resOrdered, file = "")
write.csv(resSig, file="")
write.csv(resSigOrdered, file="")
capture.output(summary(res), file = "")

#Enhanced Volcano
library(EnhancedVolcano)
Volcano_Top5_StaeKO_BWM <- EnhancedVolcano(res, lab = rownames(res), x = 'log2FoldChange', y = 'padj', pCutoff = 0.05, FCcutoff = 1, col=c('#737373', '#737373', '#737373', '#d7191c'), colAlpha = 1)
pdf('Volcano_Top5_StaeKO_BWM.pdf')
Volcalo_Top5_StaeKO_BWM
dev.off()


#Volcano Plot
pdf('Volcanoplot.pdf')
par(mfrow=c(1,1))
with(res, plot(log2FoldChange, -log10(pvalue), pch=20, main='Volcano Plot', xlim=c(-16,16)))
# Add colored points: blue if padj<0.01, red if log2FC>1 and padj<0.05)
with(subset(res, padj<.01 ), points(log2FoldChange, -log10(pvalue), pch=20, col="blue"))
with(subset(res, padj<.01 & abs(log2FoldChange)>1), points(log2FoldChange, -log10(pvalue), pch=20, col="red"))
dev.off()

# MA plot
topGene <- rownames(res)[which.min(res$padj)] #the gene which had the smallest p value from the results 
selected_resOrdered <- rownames(resOrdered)[c(1, 2, 3, 4, 5)]
pdf("plotMA_topgene.pdf")
plotMA(res, ylim=c(-15,15))
with(res[topGene, ], {
  points(baseMean, log2FoldChange, col="dodgerblue", cex=2, lwd=2)
  text(baseMean, log2FoldChange, topGene, pos=4, col="dodgerblue") 
})
dev.off()

pdf("plotMA_top5.pdf")
plotMA(resOrdered, ylim=c(-15,15))
with(res[selected_resOrdered , ], {
  points(baseMean, log2FoldChange, col="dodgerblue", cex=2, lwd=2)
  text(baseMean, log2FoldChange, selected_resOrdered, pos=3, col="dodgerblue") 
})
dev.off()

#PCA
#First we need to transform the raw count data
#vst function will perform variance stabilizing transformation
pdf('plotPCA.pdf')
vsdata <- vst(dds, blind=FALSE)
plotPCA(vsdata, intgroup="condition") #using the DESEQ2 plotPCA fxn we can look at how our samples group by treatment
dev.off()

# PlotCounts: To examine the counts of reads for a single gene across the groups
#Here specify the gene which had the smallest p value from the results table created above.
pdf("plotCount_KO_vs_Control_top gene.pdf")
plotCounts(dds, gene=which.min(res$padj), intgroup="condition") #Here specify the gene which had the smallest p value from the results table created above.
dev.off()

