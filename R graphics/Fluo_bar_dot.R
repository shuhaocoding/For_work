library(ggplot2)
library(readxl)
library(RColorBrewer)
library(ggbeeswarm)
library(ungeviz)
setwd("~/Desktop")

# dot plot
# data input
df <- read_excel("copiagag protein levels.xlsx")
df$sample <- factor(df$sample, levels = c("CSW", "DfM"))
yname = "Normalized fluorescence intensity"
stp = 0.5
ylimit = 2
xlimit = c("pre","post","muscle")
xlabel = c("pre","post","muscle")
mycolors = c("#525252", "#a50f15")
myfills = c("#d9d9d9", "#fcbba1")
#c("#636363", "#006d2c")
#c("#bdbdbd", "#74c476")
#c("#969696", "#31a354")
SEM <- function(x){data.frame(y=mean(x),
                              ymin=mean(x)-sd(x)/sqrt(length(x)),
                              ymax=mean(x)+sd(x)/sqrt(length(x)))}
set.seed(7)

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

dot <- function(df, yname, stp, ylimit, xlimit, xlabel, mycolors, myfills, SEM) {
  p <- ggplot(data = df, aes_string(y=names(df)[3], x=names(df)[1], colour=names(df)[2], fill = names(df)[2])) +
    stat_summary(fun = "mean", geom = "bar", position = position_dodge(width = .85), width = .65, size = 2) +
    geom_quasirandom(dodge.width = .85, method = "tukeyDense", size = 3.2, width = .2) +
    stat_summary(fun.data = SEM, geom="errorbar", position = position_dodge(width = .85), width = .3, size = 2) +
    scale_colour_manual(values = mycolors) +
    scale_fill_manual(values = myfills) +
    scale_y_continuous(name=yname, limits=c(0, ylimit), breaks=seq(0,ylimit,stp), expand=expansion(mult = c(0, 0))) + 
    scale_x_discrete(limits = xlimit, labels = xlabel) +
    theme_classic() +
    theme(aspect.ratio = 1.1,
        plot.margin = unit(c(2, 0, 0, 0), "cm"),
        panel.border = element_blank(), axis.line = element_line(colour = "black", size = 1, lineend = "square"),
        axis.ticks = element_line(colour = "black", size = 1), axis.ticks.length = unit(0.3,"cm"),
        axis.text.x = element_text(hjust = .98, vjust = .95, angle = 45, color = "black", size = 30), 
        axis.text.y = element_text(color = "black", size = 30), 
        axis.title.x = element_blank(), 
        axis.title.y = element_text(color = "black", size = 30),
        legend.title = element_blank(),
        legend.position = c(.85, 1.1),
        legend.key.size = unit(.85, "cm"),
        legend.text = element_text(color = "black", size = 30))
    ggsave(p, file="test.pdf", width=14, height=16, units="cm")
p}

dot(df, yname, stp, ylimit, xlimit, xlabel, mycolors, myfills, SEM)