# general
?/help(".."), getwd(), setwd(".."), list.files()
install.packages(".."), library(..)
install.packages('..', dependencies = TRUE)
BiocManager::install("..") # install biocmanager packages
print(..)
# datatypes
class(..), str(..), as.numeric,character,factor(..)
# vector
a = c(..), 1:n, seq(1,3,1 or length.out=..)
a[n], [c(1,n)], [1:n], [a>n], which..
# factor: convert to categorical variables good for dealing with typos
factor(a)
# matrix
a = matrix(c(..) or 0, m, n)
a[m,n], a[m,], nrow(a), ncol(a), dim(a)=c(m,n)
# dataframe
a = data.frame(a=1,b=c(1,2)..)
a[m,n], a[“name”] # give a dataframe, can be used to add a column
a$name # give a vector
# operators
+,-,*,/,^,sqrt(),%% # also for vectors
mean,median,sd(a),popsd(),min,max,sum(a), floor(), ceiling(), sample(x,n) (pick a random value)
# quick plot
par(mfrow=c(m,n))
barplot(a), plot(a,b), hist(x), image(a,b,c), qqnorm(x), qqline(x), abline(h=x,v=x), heatmap(2)(a) #a is a matrix
# read files
read.table, read.csv
library(readr), read_c/tsv(..)
library(readxl), read_excel(..)
# dplyr
newdf = filter(df, "col name"=="..") (Subset rows using column values)
newdf = select(df, col name) (Subset columns using their names)
unlist(newdf) (convert to numeric vector)
sum(x == n) (count the number of n in vector x)
# for loop
for (i in 1:n) {
  commands
}
# function
prop = function(q) {
  mean(x <= q)
}
props = sapply(qs, prop) (apply the function to all the q in qs)
props = replicate(n, prop) (apply the function n times)
%>% (called pipe, send variable to the next command)
e.g. newdf = filter(df, "col name"=="..") %>% select(col name) %>% unlist

