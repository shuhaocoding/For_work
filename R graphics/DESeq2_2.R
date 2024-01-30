library(DESeq2)
setwd("/Users/shuhao/Files/UMMS/Research/Paper/Statera/DE Stae elav KD/BWM") 
counts_data <- read.csv('TEtranscripts_statera_11-4-22_new_withNames.csv', header = TRUE, sep = ",") 
sample_data <- read.csv('stateraCNS_CSWB_DfMB_sample_info.csv', header = TRUE, sep = ",") 
all(colnames(counts_data) %in% rownames(sample_data))
all(colnames(counts_data) == rownames(sample_data)) # MAKING SURE THE ROW NAMES IN colData MATCHES TO COLUMN NAMES IN counts_data

dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = sample_data,
                              design = ~ condition) # tidy = TRUE change if needed
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
write.csv(res, file = "")
write.csv(resOrdered, file = "")
write.csv(resSig, file="")
write.csv(resSigOrdered, file="")
capture.output(summary(res), file = "")

#Enhanced Volcano
library(ggplot2)
library(EnhancedVolcano)
goi = c('FBgn0033926')
Volcano <- EnhancedVolcano(res, lab = rownames(res), x = 'log2FoldChange', y = 'padj', selectLab = goi, pCutoff = 0.05, FCcutoff = 1, pointSize = 1.5, labSize = 3, col=c('#969696', '#969696', '#969696', '#d7191c'), shape = 19, colAlpha = 1) +
ggplot2::scale_x_continuous(limits=c(-10,10), breaks=seq(-8,8,4)) +
ggplot2::scale_y_continuous(limits=c(0,40), breaks=seq(0,40,20)) +
ggplot2::theme(aspect.ratio=1, axis.ticks = element_line(colour = "black"), axis.text.x = element_text(color = "black"), axis.text.y = element_text(color = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
pdf('Volcano_Top5_StaeelavRNAi_BWM_darc1.pdf')
Volcano
dev.off()
#'FBti0018967'
#'FBgn0033926'

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

