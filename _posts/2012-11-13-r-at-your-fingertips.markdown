---
title: R at your fingertips
wordpress_id: 11
categories:
- R and Stat
tags:
- Basic
- R
- Statistics
---

R is an open source statistical software, which mean that it is free and that you can access all the codes that you are using.

You can also create your own functions and packages and the community will use and test them. Most of us (Biologist or non-Math scientific) do not need to go that far but R clearly out perform (to my opinion) any other statistical software. First of all you have the control of what you are doing, you are deciding how to customize your analysis to you data, this need a little bit more statistical knowledge but is far better than just getting a p-value out of an automated process which you do not understand what it is doing. Second since every one can contribute to it a wealth of additional packages have been created, each corresponding to particular needs.

I hope I convince you to go into R let's start:


## Basics;


I strongly recommend you to use Rstudio ([http://www.rstudio.com/ide/](http://www.rstudio.com/ide/))which is a very nice interface to work with,  get familiar with the different panels present on the windows I will focus on the output panel.

Everything in R start with the prompt (>) and you can do basic calculation:

    
```r
4 + 3

25 / 4
```

You can also store values into variable using “<-” :

```r
a <- 4
b <- 5.5 #important point: the decimal separator is a dot and not a comma
c <- a + b
c
#9.5
```                                     

Then you can create vectors using “c” which means in R that several elements are put together and use some basic statistical functions:

```r
v <- c(3, 4, 5)
mean(a)
median(a)
max(a)
min(a)
```
In R when you do not save the values into variables (using <-) they are printed on the screen but are not saved if you want to use them later on you have to save them in a variable. Be very careful of what you are typing in. If you forget or misplace a single characters R will not be happy, if there is an error message do not destroy your PC (not yet) but re-read your code to spot the mistake.

## Creating and playing with Matrix;


A matrix is data organised into rows and columns with an equal numbers of elements in each rows and columns (you cannot have in one row 4 numbers and in the next one only 2)

You can create a matrix using the function “matrix” (functions usually do what they tell by their names nothing fancy):

```r
a <- c(3, 4, 5)
b <- c(-6, 2, 1)
mat <- matrix(c(a, b), nrow = 3, ncol = 2)
```    

By default matrix are filled column-wise, if you want the matrix to be filled row-wise you need to set _byrow = TRUE_.

Indexing of matrices in R work through "[]"

```r
mat[1, 1] #the element on the first row, first column
mat[3, 2] #the element on the third row, second column
mat[1,] #the elements on the first row
mat[,2] #the elements on the first column
```
 You can give names to the columns and to the rows using respectively colnames() and rownames() (without forgetting to use the c!!:

```r
rownames(mat) <- c("1", "2", "4")
colnames(mat) <- c("A", "B")
```
    
Do not forget to add quotes around the strings, if you just give some bare string into R say _x_, R will look for a variable named _x_ and if there is no variable with that name, R will throw an error. So if you want to specify names use quotes.

You can apply functions on matrix using the function _apply_:

```r
col.means <- apply(mat, 2 , mean)
row.sum <- apply(mat, 1, sum)
```

The apply function expect: (i) a matrix, (ii) an integer specifying if the calculation must be done per rows (1) or per columns (2) and (iii) the function to apply.

## Uploading data into R;


Most of the time we are dealing with rather big dataset usually typed in an excelsheet and we don't want to type in all 200 numbers into R. So we have to import data into R. Usually an excel spreadsheet looks like this:

[![](http://biologyforfun.files.wordpress.com/2012/11/table1.jpg?w=300)](http://biologyforfun.files.wordpress.com/2012/11/table1.jpg)

There are several issues here that need to be corrected if you want R to accept your data:

-No colours

-No space in the column names

-No comma separating numbers and decimals

-No text (except in the first line)

-Missing values should be marked by NA

Here is the same spreadsheet with the modifications:

[![](http://biologyforfun.files.wordpress.com/2012/11/table2.jpg?w=300)](http://biologyforfun.files.wordpress.com/2012/11/table2.jpg)

Now we need to save this in a special format: csv, which means comma separated values, when you click on the save under in your excel or other software change the extension name from .xls to .csv ,

then to read a table you will use the read.csv function:

```r
setwd("path_to_file")
dat <- read.csv("file.csv")
head(dat)
##  site1 site2 site3
##1     1     4    10
##2     2     5    20
##3     3     6     0
##4	0     2     NA
```

The tricky part is that R needs to find the file in the computer, the _setwd_ function will anchor the R script to a specific path and then will be able to access all files that are in this folder. The path to the file look like this on a windows machine: "C:/Documents and settings/users/data_folder"
Now your table is in R as a DataFrame which we will explore below.


## Data Frame;


Data Frame are organised matrix with variable (the column), you can access a column using the same indexing as before or by using the '$' sign:

```r
dat$sample
#1 2 3 4 5
```


You can also create new variables using this let's create for example a variable containing values from a fourth site;

```r
dat$site4 <- c(3, -1, 14, 29)
head(dat)
```



Now if you want to change a particular value, say that one NA has now a value;

    
```r
dat[4,3] 
#NA
dat[4,3] <- 2
```


More useful things will be covered later on, ordering a data frame by a particular variable, changing the column order, going from wide to long format, applying functions on data frame, summarising...

Now let's turn to what follow a usual analysis: graphical observations of the data and statistical tests.


## Basic Graphics;


The first thing we usually want to see is the distribution of the data, this can be done using the function 'hist';

    
 ```r
hist(dat$site4)
```

[![](http://biologyforfun.files.wordpress.com/2012/11/rplot.png?w=300)](http://biologyforfun.files.wordpress.com/2012/11/rplot.png)

This is not very helpful because every values that are between 0 and 20 are into the same column, we want to have more precision, this can be done by using the argument 'breaks' into the hist function:


```r
hist(dat$site4,breaks=10)
```

[![](http://biologyforfun.files.wordpress.com/2012/11/rplot01.png?w=300)](http://biologyforfun.files.wordpress.com/2012/11/rplot01.png)

You can always play around a bit with this until you are satisfied, now the next thing we would like to do is to plot one variable against the other to look at correlation or in this situation how is the site value changing in the different samples, a function that do it very will is the 'plot' function;

```r
plot(Sample ~ site4, dat)
```


[![](http://biologyforfun.files.wordpress.com/2012/11/rplot02.png?w=300)](http://biologyforfun.files.wordpress.com/2012/11/rplot02.png)

A complete post will develop and present other parameters and functions to do more advanced and nice graph (with title, X axis labels..), boxplot, density plot, plot with regression line...


## Basic Statistics:


We biologists are fans of p-values, so here are a few basic statistical tests that you can do with R, I will not explain the theory behind each test and hope that you know already the assumptions and what each of them conclude (in the example I will use below I will not respect that for the simplicity sake).

In our example if we want to compare the means of two sites and look if they are significantly different we can use a t-test, I let you guess what the function is named in R;

```r
t.test(dat$site1, dat$site4)
```

The output give us the t-value, its degrees of freedom (df) and the p-value, it even give us the alternative hypothesis (H1), the 95% confidence interval of the alternative hypothesis mean, and the estimate of the mean of the two variable we are comparing. This is an independent t-test, we assume that the two variable are independent from one another, if the two variables are not independent we have to use a paired t-test;

```r   
t.test(dat$site1,dat$Site4,paired=TRUE)
```

Now after looking at our data, we are almost certain that our data are not normally distributed (it would be very hard for such a small sample anyway), so we should/must use non-parametric tests instead, the Mann-Whitney for independent variables, and the Wilcoxon for paired variable, as for the 't.test' function the 'wilcox.test' works for both;

```r   
wilcox.test(dat$site1,dat$site4)
```

Now a last test for this post: the correlation, in R the function doing this is cor.test and work like this;


```r
cor.test(dat$site1,dat$site2,method="pearson")
cor.test(dat$site1,dat$site2,method="spearman")
```    

The 'method' argument specify if you want to use the parametric Pearson correlation or the non-parametric Spearman. The output gives you the values of the test (t or S), the p-value associated to it, the alternative hypothesis (H1), in the Pearson method the 95% confidence interval of the estimated association measure (note in this case how wide it span) and the association measure (cor, rho) which is the coefficient of correlation.

Next will come, regressions, ANOVAs, linear mixed model …

Hope you enjoyed this first post, any questions and comments are welcomed.
