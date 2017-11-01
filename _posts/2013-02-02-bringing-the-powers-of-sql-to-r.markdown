---
title: Bringing the powers of SQL to R;
wordpress_id: 91
categories:
- R and Stat
tags:
- MySQL
- R
---

One of the biggest flaw of R is the fact that the data you load and use into it are stored in the memory (on the RAM) and not on the disk. Hence as you are working along an analysis over large amount of data the processing time of simple or more complex functions can become very long. SQL enters here, it allows you to work on subsets of data and you can easily loop over these subsets, thus automatizing a task. There are many programms for doing database management, I decided to start looking at MySQL since it has an R package and is rather easy to set up. In this post I will show you step by step how to create a database in MySQL, to upload data from R into it, then to do some queries to look at the power of SQL.


## Create a data base;


First you need to download MySQL from this [website](http://dev.mysql.com/downloads/mysql/), then you need to open your shell window (type cmd for windows users, terminal for Linux), then type this:

> mysql -p -u root

this will ask you for the password of the computer (actually the password from the current user), then if you don't want to bother with different users and their rights you can directly create a database using (named data in this example);

mysql> CREATE DATABASE data;

At this point it is very important to remember that every time you are in the shell with mysql you need to use semi-colon (;) at the end of your statement, otherwise it doesn't work.

If you want to create a new user and granting him all rights you can do this like so:

>GRANT ALL ON data.* TO 'user_name'@'localhost' IDENTIFIED BY 'password';

then you create a database just as it was done before.

Once a database has been created we don't need the shell interface everything can be done from R.


## Uploading datasets from R;


We could directly create tables in the database from the shell interface but let's see of to do this from R.

Here is some codes to get an introduction into RMySQL;

install.packages("RMySQL")

library(RMySQL)

help(RMySQL)

#connect to the database

con<-dbConnect(MySQL(),user='user_name',password='password',dbname='data')

#load some data

library(ggplot2)

data(diamonds)

#have a look at them

?diamonds

summary(diamonds)

#write the table into the database

dbWriteTable(con,"diamonds",diamonds)

#remove the dataset from R

rm(diamonds)

#count the number of diamonds that are more than 2000$ expensive

dbGetQuery(con,"select count(*) from diamonds where price>2000")

#make a new data frame with diamonds of color 'D' and a depth less than 60%

subset<-dbGetQuery(con,"select * from diamonds where color='D' AND depth<60")

summary(subset$depth)

unique(subset$color)

#make a new data frame only with the column x,y,z and order them by ascending x

sub<-dbGetQuery(con,"select x,y,z from diamonds order by x")

head(sub)

#from this dataset let's create a new variable which is the mean of x,y,z

sub$Mean<-apply(sub,1,mean)

#write the results in a new table

dbWriteTable(con,"XYZMean",sub)

#check that it has been created

dbListTables(con)

As you can see it is fairly easy to work with RMySQL, the advantage is really that your huge datasets are stored outside R on the disk and they can be called piecewise from the database.

There are many helpful ressources online about this topic here are a few that I found interesting:

A working guide to MySQL:

[http://bugs.mysql.com/file.php?id=15687](http://bugs.mysql.com/file.php?id=15687)

A nice introduction into some other SQL-platform supported in R (SQLite..)

[http://code.google.com/p/sqldf/](http://code.google.com/p/sqldf/)

A blog post about the issue of big data in R:

[http://www.cerebralmastication.com/2009/11/loading-big-data-into-r/](http://www.cerebralmastication.com/2009/11/loading-big-data-into-r/)
