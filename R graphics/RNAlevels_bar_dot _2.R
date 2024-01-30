library(ggplot2)
library(readxl)
library(RColorBrewer)
setwd("~/Desktop")

# bar blot with dots
# data input
df <- read_excel("sta in darc1 and copia RNAi in VNC.xlsx")
df2 <- read_excel("sta in darc1 and copia RNAi in VNC_rd.xlsx")
yname = expression(paste("Normalized ", italic("stae"), " RNA levels"))
stp = .2
ylimit = stp*ceiling(max(df2[2])/stp)
xlimit = c("CS", "Copiai", "Copiagagi","Arci")
xlabel = c("Control", expression(paste("Copia"^"full", "-RNAi-pre")), expression(paste("Copia"^"gag", "-RNAi-pre")), "dArc1-RNAi-pre")
set.seed(5)

bardot <- function(df, df2, yname, stp, ylimit, xlimit, xlabel) {
  p <- ggplot() + 
    geom_col(data=df, aes_string(y=names(df)[2], x=names(df)[1]), width=0.7, fill = "white", colour = "black", size=1) + 
    geom_errorbar(data=df, aes_string(x=names(df)[1], ymin=names(df)[3], ymax=names(df)[4]), width=.2, size=1) +
    geom_point(data=df2, aes_string(y=names(df2)[2], x=names(df2)[1]), position = position_jitter(width = 0.25, seed = 5), shape = 21, size=4.2, fill = "white", stroke = .7) +
    scale_y_continuous(name=yname, limits=c(0, 2), breaks=seq(0,2,stp), expand=expansion(mult = c(0, 0))) + 
    scale_x_discrete(limits = xlimit, labels = xlabel) +
    theme_classic() +
    theme(aspect.ratio=1.8,
          plot.margin = unit(c(2, 0, 0, 0), "cm"),
          panel.border = element_blank(), axis.line = element_line(colour = "black", size = 1, lineend = "square"),
          axis.ticks = element_line(colour = "black", size = 1), axis.ticks.length = unit(0.3,"cm"),
          axis.text.x = element_text(hjust = .98, vjust = .95, angle = 45, color = "black", size = 30), 
          axis.text.y = element_text(color = "black", size = 30), 
          axis.title.x = element_blank(),
          axis.title.y = element_text(color = "black", size = 30))
  ggsave(p, file="test.pdf", width=16, height=24, units="cm")
  p}

bardot(df, df2, yname, stp, ylimit, xlimit, xlabel)