# read data
library(readxl)
df <- read_excel("...xlsx", 1)
# save images
png('test.png', units="in", width=7.5, height=3.5, res=1000)
ggplot(..)
dev.off()
# bar plot
ggplot(df, aes(x=..., y=...)) + geom_col(position = "dodge", fill = "cornflowerblue", colour = "black", width=0.7, size=0.8)
.. + geom_col(position = "fill") + scale_y_continuous(labels = scales::percent) # proportional stacked bar
ggplot(df, aes(x = , y = , fill = ...)) + geom_col(position = "dodge") # two categorical variables 
# error bars
..+ geom_errorbar(aes(ymin = .. - se, ymax = .. + se), position = position_dodge(0.9), width = .2)
# violin plot
ggplot(df, aes(x=..., y=...)) + geom_violin(trim=FALSE, size=0.6, width=0.9, position=position_dodge(0.8))
# change colors
..+ scale_fill_manual(values = c("#CCEEFF", "#FFDDDD"))
..+ scale_fill_brewer(palette = "Pastel1"/"Set1")
# flip, reverse, scale the axes
..+ coord_flip()
..+ scale_y_reverse()
..+ coord_fixed(ratio = ..)
# set themes
..+ theme_classic()/theme_bw()
# set axis tick marks and titles
..+ scale_y_continuous(limits=c(..), breaks=c(..))
..+ scale_x_discrete(limits = c("1", "2"))
..+ scale_x_continuous(name="..")
# style tick labels, tick marks, lines, and titles
..+ theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
..+ theme(axis.text.x = element_text(angle = .., hjust = 1, vjust = 1, family = "Times", face = "italic",
                                   colour = "darkred", size = rel(0.9)), axis.ticks.x = element_line(..))
..+ theme(axis.line = element_line(colour = .., size = .., lineend = "square"), panel.border = element_blank())
..+ theme(axis.title.x = element_blank())
..+ theme(axis.title.x = element_text(angle = .., hjust = 1, vjust = 1, family = "Times", face = "italic",
                                     colour = "darkred", size = rel(0.9)))
# set legend labels and titles
..+ scale_fill_discrete(limits = c(..), labels = c(..))
..+ scale_fill_discrete(name = "..")
# style legend labels, positions, and titles
..+ theme(legend.text = element_text(face = "italic", family = "Times", colour = "red", size = 18))
..+ theme(legend.position = "top"/c(.8, .3))
..+ theme(legend.title = element_blank())
# add significance stars
geom_signif(comparisons=list(c("S1", "S2")), annotations="***", y_position = 9.3, tip_length = 0, vjust=0.4)



