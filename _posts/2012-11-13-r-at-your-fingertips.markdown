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

Everything in R start with the prompt (>) and you can do basic calculation (in blue is what is typed in the command and in black what R returns):

    
    <span style="font-family:Ubuntu Mono;color:#0000ff;">> 4+3
    </span><span style="font-family:Ubuntu Mono;">7
    </span><span style="font-family:Ubuntu Mono;color:#0000ff;">>5*5
    </span><span style="font-family:Ubuntu Mono;">25</span>


You can also store values into variable using “<-” :

    
    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>a<-4</span>
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>b<-5.5</span> ← Here is a very important point, the point is the character separating numbers and their decimals not the comma!!!
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>c<-a+b</span> 
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>c</span>
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">9.5</span></span>


Then you can create lists using “c” which means in R that several elements are put together and use some basic statistical functions:

    
    <span style="font-family:Ubuntu Mono;color:#0000ff;"><span style="font-size:small;">>a<-c(3,4,5)</span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>mean(a)</span>
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">>median(a)
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">>max(a)
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">>min(a)
    </span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3</span></span>


In R when you do not save the values into variables (using <-) they are printed on the screen but are not saved if you want to use them later on you have to save them in a variable. Be very careful of what you are typing in if you forget or misplace a single characters R will not be happy, if there is an error message do not destroy your PC (not yet) but re-read your code to spot the mistake.


## Creating and playing with Matrix;


A matrix is data organised into rows and columns with an equal numbers of elements in each rows and columns (you cannot have in one row 4 numbers and in the next one only 2)

You can create a matrix using the function “matrix” (functions usually do what they tell by their names nothing fancy):

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;">>a<-c(3,4,5)
    >b<-c(-2,6,1)
    >matrix <-matrix(c(a,b),nrow=3,ncol=2)
    >matrix
    
    </span></span><span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">	[,1] [,2]</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1,]    3    -2</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[2,]    4    6</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[3,]    5    1</span></span></span>


The c() is needed because why are giving more than one elements, nrow determine the number of row and ncol the number of columns. You can give names to the columns and to the rows using respectively colnames() and rownames() (without forgetting to use the c!!:

    
    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">>rownames(matrix)<-c(1,2,3)
    <span style="color:#0000ff;">>colnames(matrix)<-c(“A”,”B”)</span> ← the quotes here are compulsory when using characters otherwise R think that we are calling variables
    <span style="color:#0000ff;">>matrix
    
    </span></span></span><span style="color:#000000;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">A B</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1 3 -2</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">2 4 6</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3 5 1</span></span></span>


You can get every elements in the matrix using the indexing:

    
    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>matrix[1,]</span>  ← this returns the first row of the matrix, the comma is after the number</span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">A B </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5 3
    </span></span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>matrix[,1]</span> ← this returns the first column of the matrix, the comma is before the number
    
    </span></span><span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1 2 3 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3 4 5
    </span></span></span><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">>matrix[1,2]</span> ← this returns a specific cell in the matrix: the first row, second column
    [1] -2</span></span>


And you can apply functions on the matrix using the functions... apply():

    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">> col.means<-apply(m, 2, mean)</span> ← first give the object (here the matrix) to apply the 						function, then specify if it should be applied to rows (1) 					or colulns (2) and then the function to apply</span></span></span>
    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> col.means</span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">A B </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4 1.67 </span></span></span>
    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> row.sum<-apply(m,1,sum)</span></span>
    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> row.sum</span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1 2 3 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">8 7 9 </span></span></span>




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

then to read a table you will use the read.table function:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> table<-read.table("/home/lionel/Documents/Test.csv",sep=",",head=TRUE)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> table</span></span></span>
    <span style="color:#000000;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Sample Site1 Site2 Site3</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1      1  23.0    NA     7</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">2      2    NA   3.0     8</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3      3  34.0  56.0    NA</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4      4  45.9   7.0     1</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5      5   5.0   6.7    56</span></span></span>


The first argument in this function is the path to the file between double quotes, then you specify which character is separating the values in our case this is the comma and then we tell R that the first line is headers.

Now your table is in R as a DataFrame which we will explore below.


## Data Frame;


Data Frame are organised matrix with variable (the column), you can access a column using the same indexing as before or by using the '$' sign:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> table$Sample</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] 1 2 3 4 5</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> table[,1]</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] 1 2 3 4 5</span></span></span>


You can also create new variables using this let's create for example a variable containing values from a fourth site;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">>table$Site4<-c(34,5.34,7,21,21)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">>table</span></span></span>
    <span style="color:#000000;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Sample Site1 Site2 Site3 Site4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1      1  23.0    NA     7 34.00</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">2      2    NA   3.0     8  5.34</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3      3  34.0  56.0    NA  7.00</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4      4  45.9   7.0     1 21.00</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5      5   5.0   6.7    56 21.00</span></span></span>


Now if you want to change a particular value, say that one NA has now a value;

    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">> table[1,3]<-4	</span><span style="color:#000000;">← Change the cell value of the first line third column into 4</span></span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> table</span></span></span>
    <span style="color:#000000;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Sample Site1 Site2 Site3 Site4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1      1  23.0   4.0     7 34.00</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">2      2    NA   3.0     8  5.34</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3      3  34.0  56.0    NA  7.00</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4      4  45.9   7.0     1 21.00</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5      5   5.0   6.7    56 21.00</span></span></span>


More useful things will be covered later on, ordering a data frame by a particular variable, changing the column order, going from wide to long format, applying functions on data frame, summarising...

Now let's turn to what follow a usual analysis: graphical observations of the data and statistical tests.


## Basic Graphics;


The first thing we usually want to see is the distribution of the data, this can be done using the function 'hist';

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> hist(table[,4])</span></span></span>


[![](http://biologyforfun.files.wordpress.com/2012/11/rplot.png?w=300)](http://biologyforfun.files.wordpress.com/2012/11/rplot.png)

This is not very helpful because every values that are between 0 and 20 are into the same column, we want to have more precision, this can be done by using the argument 'breaks' into the hist function:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> hist(table[,4],breaks=10)</span></span></span>


[![](http://biologyforfun.files.wordpress.com/2012/11/rplot01.png?w=300)](http://biologyforfun.files.wordpress.com/2012/11/rplot01.png)

You can always play around a bit with this until you are satisfied, now the next thing we would like to do is to plot one variable against the other to look at correlation or in this situation how is the site value changing in the different samples, a function that do it very will is the 'plot' function;

    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">> plot(table$Sample,table$Site4) </span><span style="color:#000000;">← The first variable is plotted as X and the second as Y</span></span></span></span>


[![](http://biologyforfun.files.wordpress.com/2012/11/rplot02.png?w=300)](http://biologyforfun.files.wordpress.com/2012/11/rplot02.png)

A complete post will develop and present other parameters and functions to do more advanced and nice graph (with title, X axis labels..), boxplot, density plot, plot with regression line...


## Basic Statistics:


We biologists are fans of p-values, so here are a few basic statistical tests that you can do with R, I will not explain the theory behind each test and hope that you know already the assumptions and what each of them conclude (in the example I will use below I will not respect that for the simplicity sake).

In our example if we want to compare the means of two sites and look if they are significantly different we can use a t-test, I let you guess what the function is named in R;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> t.test(table[,1],table[,2])</span></span></span>
    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Welch Two Sample t-test</span></span></span>
    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">data:  table[, 1] and table[, 2] </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">t = -2.7498, df = 3.04, p-value = 0.06972</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">alternative hypothesis: true difference in means is not equal to 0 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">95 percent confidence interval:</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">-51.5179   3.5679 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">sample estimates:</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">mean of x mean of y </span></span></span>
    <span style="color:#000000;">    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3.000    26.975 </span></span></span>


The output give us the t-value, its degrees of freedom (df) and the p-value, it even give us the alternative hypothesis (H1), the 95% confidence interval of the alternative hypothesis mean, and the estimate of the mean of the two variable we are comparing. This is an independent t-test, we assume that the two variable are independent from one another, if the two variables are not independent we have to use a paired t-test;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> t.test(table$Sample,table$Site1,paired=TRUE)</span></span></span>
    
    <span style="color:#000000;">        <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Paired t-test</span></span></span>
    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">data:  table[, 1] and table[, 2] </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">t = -2.6677, df = 3, p-value = 0.07584</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">alternative hypothesis: true difference in means is not equal to 0 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">95 percent confidence interval:</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">-52.027719   4.577719 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">sample estimates:</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">mean of the differences </span></span></span>
    <span style="color:#000000;">                <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">-23.725 </span></span></span>


Now after looking at our data, we are almost certain that our data are not normally distributed (it would be very hard for such a small sample anyway), so we should/must use non-parametric tests instead, the Mann-Whitney for independent variables, and the Wilcoxon for paired variable, as for the 't.test' function the 'wilcox.test' works for both;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> wilcox.test(table[,2],table[,4])</span></span></span>
    
    <span style="color:#000000;">        <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Wilcoxon rank sum test</span></span></span>
    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">data:  table[, 2] and table[, 4] </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">W = 10, p-value = 0.6857</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">alternative hypothesis: true location shift is not equal to 0 </span></span></span>
    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> wilcox.test(table$Site1,table$Site3,paired=TRUE)</span></span></span>
    
    <span style="color:#000000;">        <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Wilcoxon signed rank test</span></span></span>
    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">data:  table[, 2] and table[, 4] </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">V = 3, p-value = 1</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">alternative hypothesis: true location shift is not equal to 0</span></span></span>


Now a last test for this post: the correlation, in R the function doing this is cor.test and work like this;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> cor.test(table$Sample,table$Site1,method="pearson")</span></span></span>
    
    <span style="color:#000000;">        <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Pearson's product-moment correlation</span></span></span>
    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">data:  table$Sample and table$Site1 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">t = -0.2763, df = 2, p-value = 0.8082</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">alternative hypothesis: true correlation is not equal to 0 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">95 percent confidence interval:</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">-0.9734430  0.9431481 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">sample estimates:</span></span></span>
    <span style="color:#000000;">       <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">cor </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">-0.1917533 </span></span></span>
    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> cor.test(table$Sample,table$Site1,method="spearman")</span></span></span>
    
    <span style="color:#000000;">        <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Spearman's rank correlation rho</span></span></span>
    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">data:  table$Sample and table$Site1 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">S = 12, p-value = 0.9167</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">alternative hypothesis: true rho is not equal to 0 </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">sample estimates:</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">rho </span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">-0.2 </span></span></span>


The 'method' argument specify if you want to use the parametric Pearson correlation or the non-parametric Spearman. The output gives you the values of the test (t or S), the p-value associated to it, the alternative hypothesis (H1), in the Pearson method the 95% confidence interval of the estimated association measure (note in this case how wide it span) and the association measure (cor, rho) which is the coefficient of correlation.

Next will come, regressions, ANOVAs, linear mixed model …

Hope you enjoyed this first post, any questions and comments are welcomed.
