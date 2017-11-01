---
title: 'Adding color to R plot: a function'
wordpress_id: 213
categories:
- R and Stat
tags:
- plot
- R
---

A friend of mine told me that she was spending her day colouring R plot because she never understood how to put color in them. This triggered a nerdy reaction in me that I had to put in a basic function. This was actually a funny exercise for two reasons: forced me to think at the place of someone else (called empathy which I may be lacking), made me discover how to pass argument to a function that will be interpreted as column names without specifying them between quotes.

Enough blabla here is the code:

`#plotting data with the standard plot function and coloring points according to a factor variable
plot.col<-function(x,y,factor,data,title.legend,pch=16,...){
require(RColorBrewer)
#get all elements as vectors
arguments x y factor if(class(factor)!="factor"){
factor<-factor(factor)
}
lvl<-length(levels(factor)) if(lvl>7){
cat("More than 7 levels in the provided factor, not enough colors available\n")
break
}
if(lvl==2){
pal<-brewer.pal(lvl+1,"Set1")
pal<-pal[-3]
}
else{
pal<-brewer.pal(lvl,"Set1")
}
par(xpd=TRUE,mar=c(5,4,4,10))
plot(x,y,col=pal[factor],pch=pch,...)
xcoord<-max(x)+((max(x)-min(x))/20)
ycoord<-max(y)
legend(xcoord,ycoord,legend=levels(factor),col=pal,pch=pch,title=title.legend)
par(xpd=FALSE,mar=c(5,4,4,2))
}`

And here is an example on how to use it, just copy paste the above code, put it into some text file save as plot.col.R in a folder and then apply the below code:

`#### A script for easier plotting of colours ####
#set the working directory where you put the plot.col.R file
setwd(...)
#load the function
source("plot.col.R")
#load the color library
install.packages("RColorBrewer")
library(RColorBrewer)
#some fake data
fake<-data.frame(Temperature=runif(21,5,15),Attack=runif(21,50,100),Treatment=rep(c("A","B","C"),7))
#the plot.col function need four arguments: the name of the x column (x), the name of the y column (y), the name of the column with the factor (factor), the name of the dataset (data), the title of the legend (title.legend)
plot.col(x=Temperature,y=Attack,factor=Treatment,data=fake,title.legend="Treatment")
#all settings normally used in plot can be used
plot.col(x=Temperature,y=Attack,factor=Treatment,data=fake,title.legend="Treatment",pch=3,cex=1.4,xlab="Temperature (°)",ylab="Attack rates (%)",main="Relationship between the temperature\n and the attack rates")
#if the title of the legend is not provided the plot will appear but without a legend and with a warning
#not more than seven levels are allowed in the factor variables
#the name of the levels should not be longer than 16 characters
`

Here is the results:

[![example2](http://biologyforfun.files.wordpress.com/2014/02/example2.png?w=300)](http://biologyforfun.files.wordpress.com/2014/02/example2.png)Which is nice.

For the people interested in a bit of theory here is how the col argument work: by providing a vector of colours as long as the number of points, R give to each points the colors specified at the position in the color vector  of the point.

Happy plotting!
