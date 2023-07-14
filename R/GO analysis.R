setwd("~/Desktop")
#gene enrichment including all the genes
#enrichment analysis using clusterprofiler package created by yuguangchuang
library(clusterProfiler)
library(DOSE)
library(org.Dm.eg.db)
library(topGO)
#get the ENTREZID for the next analysis
#Use https://www.biotools.fr/drosophila/fbgn_converter, and https://flybase.org transfer to FLYBASE first.

sig.gene<-read.csv(file="TEtranscripts_out_sigdiff_gene_TE_StaeKO_BWM_fb.csv")
head(sig.gene)
gene<-sig.gene[,1]
head(gene)
gene.df<-bitr(gene, fromType = "FLYBASE", 
              toType = c("ENTREZID","FLYBASE","ENSEMBL","GENENAME","FLYBASECG", "SYMBOL"),
              OrgDb = org.Dm.eg.db)

head(gene.df, 8)

#Go classification
#Go enrichment analysis
library(stringr)
ego_cc<-enrichGO(gene       = gene.df$FLYBASE,
                 OrgDb      = org.Dm.eg.db,
                 keyType    = 'FLYBASE',
                 ont        = "CC",
                 pvalueCutoff = 0.05,
                 qvalueCutoff = 0.25)
head(ego_cc, 4)
ego_bp<-enrichGO(gene       = gene.df$FLYBASE,
                 OrgDb      = org.Dm.eg.db,
                 keyType    = 'FLYBASE',
                 ont        = "BP",
                 pvalueCutoff = 0.05,
                 qvalueCutoff = 0.25)
head(ego_bp, 4)

ego_mf<-enrichGO(gene       = gene.df$FLYBASE,
                 OrgDb      = org.Dm.eg.db,
                 keyType    = 'FLYBASE',
                 ont        = "MF",
                 pvalueCutoff = 0.05,
                 qvalueCutoff = 0.25)
head(ego_mf, 4)

pdf('The GO_cc barplot of StaeKO_BWM.pdf')
barplot(ego_cc,showCategory = 40,title="GO")
dev.off()
pdf('The GO_cc dotplot of StaeKO_BWM.pdf')
dotplot(ego_cc, x = "GeneRatio", title="GO") #x=Count
dev.off()
pdf('The GO_cc graph of StaeKO_BWM.pdf')
plotGOgraph(ego_cc)
dev.off()
write.csv(ego_cc, file = "The ego_cc of StaeKO_BWM.csv")

pdf('The GO_bp barplot of StaeKO_BWM.pdf')
barplot(ego_bp,showCategory = 40,title="GO")
dev.off()
pdf('The GO_bp dotplot of StaeKO_BWM.pdf')
dotplot(ego_bp, x = "GeneRatio", title="GO") #x=Count
dev.off()
pdf('The GO_bp graph of StaeKO_BWM.pdf')
plotGOgraph(ego_bp)
dev.off()
write.csv(ego_bp, file = "The ego_bp of StaeKO_BWM.csv")

pdf('The GO_mf barplot of StaeKO_BWM.pdf')
barplot(ego_mf,showCategory = 40,title="GO")
dev.off()
pdf('The GO_mf dotplot of StaeKO_BWM.pdf')
dotplot(ego_mf, x = "GeneRatio", title="GO") #x=Count
dev.off()
pdf('The GO_mf graph of StaeKO_BWM.pdf')
plotGOgraph(ego_mf)
dev.off()
write.csv(ego_mf, file = "The ego_mf of StaeKO_BWM.csv")

# KEGG
library(stringr)
kk<-enrichKEGG(gene      = gene.df$ENTREZID,
               organism = 'dme',
               pvalueCutoff = 0.05,
               keyType = 'ncbi-geneid')

head(kk, 10)

pdf('The barplot of KEGG enrichment analysis of StaeKO_BWM.pdf')
barplot(kk,x = "GeneRatio",showCategory = 25, title="KEGG")
dev.off()
pdf('The dotplot of KEGG enrichment analysis of StaeKO_BWM.pdf')
dotplot(kk, x = "GeneRatio", showCategory = 25, title="KEGG")
dev.off()
write.csv(kk, file = "The kk of StaeKO_BWM.csv")


# Gene Set Enrichment Analysis（GSEA）
genelist <- sig.gene$log2FoldChange
names(genelist) <- sig.gene[,1]
genelist <- sort(genelist, decreasing = TRUE)
# GSEA analysis
gsebp <- gseGO(genelist,
               OrgDb = org.Dm.eg.db,
               keyType = "FLYBASE",
               ont="BP",
               pvalueCutoff = 1)

head(gsebp)

gsecc <- gseGO(genelist,
               OrgDb = org.Dm.eg.db,
               keyType = "FLYBASE",
               ont="CC",
               pvalueCutoff = 1)

head(gsecc)

gsemf <- gseGO(genelist,
               OrgDb = org.Dm.eg.db,
               keyType = "FLYBASE",
               ont="MF",
               pvalueCutoff = 1)

head(gsemf)
# plot GSEA
write.csv(gsebp, file = "The gsebp of StaeKO_BWM.csv")
write.csv(gsecc, file = "The gsecc of StaeKO_BWM.csv")
write.csv(gsemf, file = "The gsemf of StaeKO_BWM.csv")
gseaplot(gse_mf, geneSetID="GO:0030030")

