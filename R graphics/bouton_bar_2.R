library(ggplot2)
library(readxl)
library(RColorBrewer)
setwd("~/Desktop")

# data input
df <- read_excel("repo-MRE16KDshRNA-typeIs.xlsx")
stp = 20
yname = "Type Is boutons"

# bar blot
bar <- function(df, stp, yname) {
  p <- ggplot(data=df, aes_string(y=names(df)[2], x=names(df)[1])) + 
    geom_col(position = "dodge", fill = "black", colour = "black", width=0.63, size=1) + 
    theme_classic() +
    theme(plot.title = element_text(color="black", size = 30, hjust = 0.5),
          plot.margin = unit(c(2, 0, 0, 0), "cm"),
          aspect.ratio=1.8,
          panel.border = element_blank(), axis.line = element_line(colour = "black", size = 1, lineend = "square"),
          axis.ticks = element_line(colour = "black", size = 1),
          axis.ticks.length = unit(0.3,"cm"),
          axis.text.x = element_text(hjust = .98, vjust = .95, angle = 45, color = "black", size = 30), 
          axis.text.y = element_text(color = "black", size = 30), 
          axis.title.x = element_blank(), 
          axis.title.y = element_text(color = "black", size = 30)) + 
    scale_y_continuous(name=yname, limits=c(0, stp*ceiling(max(df[4])/stp)), breaks=seq(0,stp*ceiling(max(df[4])/stp),stp), expand=expansion(mult = c(0, .07))) + 
    scale_x_discrete(limits = c("CS", "S1", "S2"), labels = c("Control", "Stae-RNAi1-", "Stae-RNAi2-")) + # need change
    geom_errorbar(aes_string(ymin=names(df)[3], ymax=names(df)[4]), width=.2, size=1)
  ggsave(p, file="Trial.pdf", width=12, height=22, units="cm")
  p}

bar(df,stp,yname)