library(ggplot2)
library(readxl)
library(RColorBrewer)
setwd("~/Desktop")

# data input
df <- read_excel("darc1 copia in sta KO in BWM.xlsx")
stp = 10
yname = "Normalized RNA levels"

# bar blot with legend
mycols <- c("black", "red")
df$Sample <- factor(df$Sample, levels = c("Control", "Statera KO"))

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

bar <- function(df, stp, yname) {
  p <- ggplot(data=df, aes_string(y=names(df)[3], x=names(df)[1], fill=names(df)[2])) + 
    geom_col(colour = "black", width=0.6, size=1, position = position_dodge(width = 0.75)) + 
    scale_fill_manual(values = mycols) +
    theme_classic() +
    theme(plot.title = element_text(color="black", size = 30, hjust = .5),
          aspect.ratio=1.2,
          panel.border = element_blank(), axis.line = element_line(colour = "black", size = 1, lineend = "square"),
          axis.ticks = element_line(colour = "black", size = 1),
          axis.ticks.length = unit(0.3,"cm"),
          axis.text.x = element_text(hjust = .5, vjust = .6, angle = 45, color = "black", size = 30), 
          axis.text.y = element_text(color = "black", size = 30), 
          axis.title.x = element_blank(), 
          axis.title.y = element_text(color = "black", size = 30, margin = margin(t = 0, r = 10, b = 0, l = 0)),
          legend.title = element_blank(),
          legend.position = c(.9,.95),
          legend.key.size = unit(.85, "cm"),
          legend.text = element_text(color = "black", size = 30)) +
    scale_y_continuous(name=yname, limits=c(0, stp*ceiling(max(df[5])/stp)), breaks=seq(0,stp*ceiling(max(df[5])/stp),stp), expand=expansion(mult = c(0, .07))) + 
    scale_x_discrete(limits = c("statera", "copia", "copiagag", "darc1"), labels = c(expression(paste(italic("statera"))), expression(paste(italic("copia"^"full"))), expression(paste(italic("copia"^"gag"))), expression(paste(italic("darc1"))))) + # need change
    geom_errorbar(aes_string(ymin=names(df)[4], ymax=names(df)[5]), position = position_dodge(0.75), width=.2, size=1)
  ggsave(p, file="Trial.pdf", width=22, height=20, units="cm") 
  p}

bar(df,stp,yname)