library(ggplot2)
library(readxl)
library(RColorBrewer)
setwd("~/Desktop")

# bar blot with legend
# data input
df <- read_excel("copia protein levels_new.xlsx")
df2 <- read_excel("copia protein levels_new_rd.xlsx")
df$sample <- factor(df$sample, levels = c("eCS", "eM"))
df2$sample <- factor(df2$sample, levels = c("eCS", "eM"))
yname = "Normalized Copia intensity"
stp = .5
ylimit = 2
xlimit = c("pre","post")
xlabel = c("pre","post")
myfills <- c("white", "white")
mycols <- c("black", "black")
set.seed(27)

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
    scale_y_continuous(name=yname, limits=c(0, ylimit), breaks=seq(0,ylimit,stp), expand=expansion(mult = c(0, .03))) + 
    scale_x_discrete(limits = xlimit, labels = xlabel) +
    theme_classic() +
    theme(aspect.ratio=1.5,
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
  ggsave(p, file="test.pdf", width=11, height=18, units="cm") 
  p}

bardot(df, df2, yname, stp, ylimit, xlimit, xlabel, myfills, mycols)