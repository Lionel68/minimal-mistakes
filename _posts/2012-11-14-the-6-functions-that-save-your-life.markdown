---
title: The 6 functions that save your life (in R)
wordpress_id: 31
categories:
- R and Stat
tags:
- R
- Statistics
---

In this article I will introduce to you the functions that make your life in R so much easier. For example purposes I will use the “mtcars” data frame.


## The ? functions:


This is the most important one, it print the help content related to the functions, for example:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> ?plot</span></span></span>


Will provide you with help on the 'plot' function, if your are able to circumvent the daunting layout it can provides you inestimable service avoiding you to google or to ask your timeless supervisor.


## The str function:



    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> data(mtcars)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> str(mtcars)</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">'data.frame':   32 obs. of  11 variables:</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ cyl : num  6 6 4 6 8 6 8 4 4 6 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ disp: num  160 160 108 258 360 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ hp  : num  110 110 93 110 175 105 245 62 95 123 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ wt  : num  2.62 2.88 2.32 3.21 3.44 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ qsec: num  16.5 17 18.6 19.4 17 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ vs  : num  0 0 1 1 0 1 0 1 1 1 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ am  : num  1 1 1 0 0 0 0 0 0 0 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ gear: num  4 4 4 3 3 3 3 4 4 4 ...</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">$ carb: num  4 4 1 1 2 1 4 2 2 4 ...</span></span></span>


The str function returns the structure of the object, in our case we have a 'data.frame' which consists of 32 observations (rows) of 11 variables (columns) and R gives us the name of each variables (like $mpg) and the class of this variable here 'num' for numeric, plus a sample of values in the variables.

This function is extremely useful, it allows you to understand what type of data you are dealing with and when you have data frames of thousands of rows you don't want to look through them, the output of str is very concise and as every thing you need to know.


## The summary function:



    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:medium;">> summary(mtcars)</span></span></span>
    <span style="color:#000000;">      <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">mpg             cyl             disp             hp             drat             wt       </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0   Min.   :2.760   Min.   :1.513  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080   1st Qu.:2.581  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Median :19.20   Median :6.000   Median :196.3   Median :123.0   Median :3.695   Median :3.325  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7   Mean   :3.597   Mean   :3.217  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920   3rd Qu.:3.610  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0   Max.   :4.930   Max.   :5.424  </span></span></span>
    <span style="color:#000000;">      <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">qsec             vs               am              gear            carb      </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Min.   :14.50   Min.   :0.0000   Min.   :0.0000   Min.   :3.000   Min.   :1.000  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">1st Qu.:16.89   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Median :17.71   Median :0.0000   Median :0.0000   Median :4.000   Median :2.000  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Mean   :17.85   Mean   :0.4375   Mean   :0.4062   Mean   :3.688   Mean   :2.812  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">3rd Qu.:18.90   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  </span></span></span>
    <span style="color:#000000;"> <span style="font-size:small;"><span style="font-family:Ubuntu Mono;">Max.   :22.90   Max.   :1.0000   Max.   :1.0000   Max.   :5.000   Max.   :8.000  </span></span></span>


The summary function returns some basic statistics for every variables (for a data frame if you use this function for other type of objects like matrix or lists you will get different output). You can with one look get a better idea of your values and which should be the next step (test, transformation...).


## _**The head function:**_



    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> head(mtcars)</span></span></span>
    <span style="color:#000000;">                   <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">mpg cyl disp  hp drat    wt  qsec vs am gear carb</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1</span></span></span>


Most of the time to comprehend our data we still need to actually see them, usually we don't need to see every observations (rows) but a subset of them, this is what the head function does, it returns the first rows of a data frame and allows you to see how are your data organised and if certain operations that you made on them resulted in what you expected or not (like sorting, changing names...).


## The write.table function:


Now that you worked on your data frame you want to save your results in a spreadsheet to read it in excel for example.

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> write.table(mtcars,file="Data.csv",sep=",",col.names=NA)</span></span></span>


This will save the object mtcars in the current directory, to access it use: getwd().

The argument 'col.names=NA' is used to indicate that the first column is the row name column otherwise every column would be drifted to the left.


## The read.table function:


Now the opposite you typed in data in a spreadsheet and want to load them into R:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> mtcars<-read.table("/home/lionel/Data.csv",sep=",",header=TRUE,row.names=1)</span></span></span>


This will open the table in the mtcars object. The header argument is to indicate that the first row is the column names and the row.names is to indicate that the first column contain the row names.
