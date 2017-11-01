---
title: The day I stoped using for loops (in R);
wordpress_id: 97
categories:
- R and Stat
tags:
- R
---

For loops are great, they allow you to go elements by elements through a list, data frame... and to perform operations on these subsets of data. This is very usefull but very slow when working with large amont of data. So below is some code that allows you to work faster (because as everyone knows time is money).



#building a random matrix of 100000 rows and 10 columns

m<-matrix(rnorm(1000000),ncol=10)



#normal for loops approach checking for the time the command takes to execute

system.time(for(i in 1:100000){max1<-c(max1,max(m[i,]))})

user system elapsed 

49.524 77.309 127.122 #127 secs..



It took a bit more than 2 minutes for R to compute the maximum value in each rows, in computer time this is almost an eternity for such a basic operation.

R have developed some functions that works in a different way, in this group there is the *apply family which is very usefull:



#using the apply function

system.time(max2<-apply(m,1,max))

user system elapsed 

0.792 0.008 0.800 #0.8sec, 158 times faster than for loop



Apply works on matrix and data frame (see ?apply) and the first argument is the matrix/data frame the computation is done on, then a number indicating wether the function is to work on rows (1) or on columns (2) or both (c(1,2)). There are other functions in the *apply family for different use which are beyond the scope of this post (see ?lapply).

For basic functions such as mean and sum R also have colMeans, rowSum functions and some other of these basic functions (like max, standard deviation) are in the matrixStats package.



#using the rowMaxs from the matrixStats package

library(matrixStats)

system.time(max3<-rowMaxs(m))

user system elapsed 

0.156 0.000 0.159 #0.159 sec, 5 times faster than apply



#testing if the object are the same

identical(max1,max2,max3)

[1] TRUE

identical(max2,max3)

[1] TRUE



Conclusion when doing basics statistics on a matrix working row-wise or column-wise the for loop takes a lot of time on large datasets, using the apply function can save time but even faster functions are the row/col* ones. To put it in a nutschell for loops are great but you should think about using other functions when doing simple computation on large datasets.
