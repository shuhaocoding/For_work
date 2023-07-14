library(ggplot2)
library(readxl)
setwd("~/Desktop")
df <- read_excel("WB anova.xlsx")
# One way anova
s.lm <- lm(Arc ~ Group, data = df)
s.av <- aov(s.lm)
summary(s.av)
# Tukey post hoc test
tukey.test <- TukeyHSD(s.av)
tukey.test
# ttest
ttest <- t.test(treatment, control)
# association test
chisq.test(table(sample_dataframe))
fisher.test(table(sample_dataframe))

