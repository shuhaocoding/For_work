#Before running modify:
	# setwd
	# counts_data
	# colData
	# design
	# dds$condition
	# Writing README file (line 90)
	# Name of output files: csv files and Results_Summary text file.



setwd("/Users/shuhao/Files/Learn/work/R/RNA-Seq") 

library(DESeq2)


## STEP1: PREPARING COUNT DATA:

# READ IN COUNTS DATA
counts_matrix <- 'counts_matrix.csv'
counts_data <- read.csv(counts_matrix, header = TRUE, sep = ",") 
head(counts_data) #rows-gene IDs, columns-samples

# READ IN SAMPLE INFO
sample_table <- 'sample_table.csv'
colData <- read.csv(sample_table, header = TRUE, sep = ",") 
colData

# MAKING SURE THE ROW NAMES IN colData MATCHES TO COLUMN NAMES IN counts_data
all(colnames(counts_data) %in% rownames(colData))

# ARE THEY IN THE SAME ORDER?
all(colnames(counts_data) == rownames(colData))


## STEP2: CREATE A DESeqDataSet OBJECT:
dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = colData,
                              design = ~ condition, tidy = TRUE)
dds


# pre-filtering: removing rows with low gene counts
# keeping rows that have at least 10 reads total
keep <- rowSums(counts(dds)) >=10
dds <- dds[keep,]

dds

# set the factor level
#dds$condition <- factor(dds$condition, levels = c("control","knockout"))
dds$condition <- relevel(dds$condition, ref = "control")

## STEP3: RUN DESEQ2 FUNCTION TO PERFORM THE DIFFERENTIAL EXPRESSION ANALYSIS
dds <- DESeq(dds)
res <- results(dds)

res

# contrasts
resultsNames(dds)

# Explore results
summary(res)


#How many p-values were less than 0.1:
sum(res$padj < 0.1, na.rm=TRUE)


#to adjust the adjusted p-value
res0.01 <- results(dds, alpha = 0.01) 
summary(res0.01)

res0.05 <- results(dds, alpha = 0.05) 
summary(res0.05)
sum(res0.05$padj < 0.05, na.rm=TRUE)

#order results table by smallest p-value
resOrdered <- res[order(res$pvalue),]


resSig <- res[(!is.na(res$padj) & (res$padj < 0.050000) & (abs(res$log2FoldChange)> 0.000000)), ]
resSigOrdered <- resSig[order(resSig$pvalue),]


#########

## WRITING README FILE:
write("Information about Statera_Trial DESeq2 Analysis:", file = "README",append = TRUE, sep = "\n")
cat("The count matrix for this analysis is: ",file="README",append=TRUE)
cat(counts_matrix, file="README", append=TRUE, sep = "\n")
cat("The sample table is: ", file="README", append=TRUE)
cat(sample_table, file="README", append=TRUE, sep = "\n")
cat("Intercept: ",file="README",append=TRUE)
cat(resultsNames(dds), file="README", append=TRUE, sep = "\n")




#########

## EXPORTING RESULTS:

# OUTPUT FILES:
write.csv(res, file = "Results_DESeq2_Statera_Trial_all_genes.csv")
write.csv(resOrdered, file = "Results_DESeq2_Statera_Trial_all_genes_sortedLowestpvalue.csv")
write.csv(resSig, file="Results_DESeq2_Statera_Trial_sigdiff_gene_TE.csv")
write.csv(resSigOrdered, file="Results_DESeq2_Statera_Trial_sigdiff_gene_TE_sortedLowestpvalue.csv")
capture.output(summary(res), file = "Results_Summary_Statera_Trial_.txt")


# PLOTS:
topGene <- rownames(res)[which.min(res$padj)] #the gene which had the smallest p value from the results 
selected_resOrdered <- rownames(resOrdered)[c(1, 2, 3, 4, 5)]

# MA plot (A scatter plot of log2FC  vs the mean of the normalized counts. Blue dots are significantly differently expressed genes. They have adjusted p-values of 0.05)
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

#This function is supposed to let us identify interactively detect the row number of individual genes by clicking on the plot, but it takes a long time
#idx <- identify(res$baseMean, res$log2FoldChange)
#rownames(res)[idx]

##Volcano Plot
pdf('Volcanoplot.pdf')
par(mfrow=c(1,1))
with(res, plot(log2FoldChange, -log10(pvalue), pch=20, main='Volcano Plot', xlim=c(-16,16)))
# Add colored points: blue if padj<0.01, red if log2FC>1 and padj<0.05)
with(subset(res, padj<.01 ), points(log2FoldChange, -log10(pvalue), pch=20, col="blue"))
with(subset(res, padj<.01 & abs(log2FoldChange)>1), points(log2FoldChange, -log10(pvalue), pch=20, col="red"))
dev.off()

library(EnhancedVolcano)
selected_resOrdered <- rownames(resOrdered)[c(1, 2, 3, 4, 5)]
Volcalo_Top5 <- EnhancedVolcano(resOrdered, lab = rownames(resOrdered), x = 'log2FoldChange', y = 'pvalue', selected_resOrdered)
pdf('Volcanoplot_Top5.pdf')
Volcalo_Top5
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

