library(ggplot2)
library(readxl)
library(RColorBrewer)
library(ggbeeswarm)
library(ungeviz)
setwd("~/Desktop")

# dot plot
# data input
df <- read_excel("")
yname = ""
stp = 20
ylimit = stp*ceiling(max(df[2])/stp)
xlimit = c("", "")
xlabel = c("Control", "CRISPRi")
mycolors = c("#969696", "#31a354")
SEM <- function(x){data.frame(y=mean(x),
                              ymin=mean(x)-sd(x)/sqrt(length(x)),
                              ymax=mean(x)+sd(x)/sqrt(length(x)))}
set.seed(9)

dot <- function(df, yname, stp, ylimit, xlimit, xlabel, mycolors, SEM) {
  p <- ggplot(data = df, aes_string(y=names(df)[2], x=names(df)[1], colour=names(df)[1])) +
    geom_quasirandom(method = "tukeyDense", size = 3.4, width = .35) +
    stat_summary(fun.data = SEM, geom="errorbar", width = .35, size = 1, color='black') +
    stat_summary(fun = "mean", geom = "hpline", width = .7, size = 1, color='black') +
    scale_colour_manual(values = mycolors) +
    scale_y_continuous(name=yname, limits=c(0, ylimit), breaks=seq(0,ylimit,stp), expand=expansion(mult = c(0, 0))) + 
    scale_x_discrete(limits = xlimit, labels = xlabel) +
    theme_classic() +
    theme(aspect.ratio=2.3,
          plot.margin = unit(c(2, 0, 0, 0), "cm"),
          panel.border = element_blank(), axis.line = element_line(colour = "black", size = 1, lineend = "square"),
          axis.ticks = element_line(colour = "black", size = 1), axis.ticks.length = unit(0.3,"cm"),
          axis.text.x = element_text(hjust = .98, vjust = .95, angle = 45, color = "black", size = 30), 
          axis.text.y = element_text(color = "black", size = 30), 
          axis.title.x = element_blank(), 
          axis.title.y = element_text(color = "black", size = 30),
          legend.position = "none")
  ggsave(p, file="test.pdf", width=12, height=19, units="cm")
  p}

dot(df, yname, stp, ylimit, xlimit, xlabel, mycolors, SEM)