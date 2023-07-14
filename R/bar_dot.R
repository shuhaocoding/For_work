library(ggplot2)
library(readxl)
library(RColorBrewer)
setwd("~/Desktop")

# bar-dot plot
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

# bar-dot plot with legend
# data input
df <- read_excel("darc1 copia in sta KO in BWM.xlsx")
df2 <- read_excel("darc1 copia in sta KO in BWM_rd.xlsx")
df$Sample <- factor(df$Sample, levels = c("Control", "Statera KO"))
df2$Sample <- factor(df2$Sample, levels = c("Control", "Statera KO"))
yname = "Normalized RNA levels"
stp = 1
ylimit = stp*ceiling(max(df2[3])/stp)
xlimit = c("statera", "copia", "copiagag", "darc1")
xlabel = c(expression(paste(italic("statera"))), expression(paste(italic("copia"^"full"))), expression(paste(italic("copia"^"gag"))), expression(paste(italic("darc1"))))
myfills <- c("white", "white")
mycols <- c("black", "black")
set.seed(100)

# change legend key appearance
draw_key_polygon3 <- function(data, params, size) {
  lwd <- min(data$size, min(size) / 4)
  
  grid::rectGrob(
    width = grid::unit(0.67, "npc"),
    height = grid::unit(0.67, "npc"),
    gp = grid::gpar(
      col = data$colour,
      fill = alpha(data$fill, data$alpha),
      lty = data$linetype,
      lwd = lwd * .pt,
      linejoin = "mitre"
    ))
}
GeomCol$draw_key = draw_key_polygon3

bardot <- function(df, df2, yname, stp, ylimit, xlimit, xlabel, myfills, mycols) {
  p <- ggplot() + 
    geom_col(data=df, aes_string(y=names(df)[3], x=names(df)[1], fill=names(df)[2]), position = position_dodge(width = 0.75), width=0.6, colour = "black", size=1) + 
    geom_errorbar(data=df, aes_string(x=names(df)[1], ymin=names(df)[4], ymax=names(df)[5], colour=names(df)[2]), position = position_dodge(width = 0.75), width=.2, size=1) +
    geom_point(data=df2, aes_string(y=names(df2)[3], x=names(df2)[1], colour=names(df2)[2]), position = position_jitterdodge(jitter.width = 0.42, dodge.width=0.75, seed = 10), shape = 21, size=3.5, fill = "white", stroke = .7) +
    scale_fill_manual(values = myfills) +
    scale_colour_manual(values = mycols) +
    scale_y_continuous(name=yname, limits=c(0, ylimit), breaks=seq(0,ylimit,stp), expand=expansion(mult = c(0, .07))) + 
    scale_x_discrete(limits = xlimit, labels = xlabel) +
    theme_classic() +
    theme(aspect.ratio=1.2,
          panel.border = element_blank(), axis.line = element_line(colour = "black", size = 1, lineend = "square"),
          axis.ticks = element_line(colour = "black", size = 1), axis.ticks.length = unit(0.3,"cm"),
          axis.text.x = element_text(hjust = .5, vjust = .6, angle = 45, color = "black", size = 30), 
          axis.text.y = element_text(color = "black", size = 30), 
          axis.title.x = element_blank(),
          axis.title.y = element_text(color = "black", size = 30, margin = margin(t = 0, r = 10, b = 0, l = 0)),
          legend.title = element_blank(),
          legend.position = c(.9,.95),
          legend.key.size = unit(.85, "cm"),
          legend.text = element_text(color = "black", size = 30))
  ggsave(p, file="test.pdf", width=22, height=20, units="cm") 
  p}

bardot(df, df2, yname, stp, ylimit, xlimit, xlabel, myfills, mycols)