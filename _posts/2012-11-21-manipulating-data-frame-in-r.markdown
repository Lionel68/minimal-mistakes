---
title: Manipulating data frame in R
wordpress_id: 46
categories:
- R and Stat
tags:
- Basic
- R
- Statistics
---

Here you will learn about transforming, merging, ordering a data frame, changing the column order, removing a variable, subsetting and indexing


## Transforming;


This means put the rows as columns and the columns as the rows, this is done very easily in one line:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> data(mtcars)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> mtcars<-t(mtcars)</span></span></span>




## Merging two Data Frame;


Often it happen that you have informations scattered across several dataset and sometimes you might want to bring them together in the same dataset, as example let's take again our mtcars data frame and say that we have colour informations for each model in a different data frame, we want to merge the two data frame in one by associating to each model its correct colour. Here is the code:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> data(mtcars)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df<-as.data.frame(c(rep("red",5),rep("grey",10),rep("white",10),rep("black",5),rep("chrome",2)))</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> colnames(df)<-"Color"</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df$Model<-rownames(mtcars)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> mtcars$Model<-rownames(mtcars)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_merged<-merge(mtcars,df)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> head(df_merged)</span></span></span>
    <span style="color:#000000;">             <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Model  mpg cyl disp  hp drat    wt  qsec vs am gear carb Color</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1        AMC Javelin 15.2   8  304 150 3.15 3.435 17.30  0  0    3    2 white</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">2 Cadillac Fleetwood 10.4   8  472 205 2.93 5.250 17.98  0  0    3    4  grey</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3         Camaro Z28 13.3   8  350 245 3.73 3.840 15.41  0  0    3    4 white</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4  Chrysler Imperial 14.7   8  440 230 3.23 5.345 17.42  0  0    3    4 white</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5         Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1   red</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">6   Dodge Challenger 15.5   8  318 150 2.76 3.520 16.87  0  0    3    2 white</span></span></span>


Here is a new function 'merge' that take as arguments two data frames and associate row that share a common value at a common column, so R look at the column names of the two data frame and when two of them are equivalent it merges the data frame by this column. Now let's play a bit around with this function:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> colnames(df)[2]<-"Models"</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df[33,]<-c("grey","Citroën")</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_merged<-merge(mtcars,df,by.x="Model",by.y="Models",all.x=TRUE,all.y=TRUE)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_merged[df_merged$Model=="Citroën",]</span></span></span>
    <span style="color:#000000;">    <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Model mpg cyl disp hp drat wt qsec vs am gear carb Color</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5 Citroën  NA  NA   NA NA   NA NA   NA NA NA   NA   NA  grey</span></span></span>


What I did there was to change the name of the common column, and to add a line to the second data frame, this time we need to specify to R which column to merge by, 'by.x' give the name of the column of the first data frame and 'by.y' give the name of the column of the second data frame. Since we have more line in the second data frame we need to specify 'all.y' as TRUE so that all row that didn't fit to the first data frame will be added and filled with NA were values are missing (for every column of the first data frame. In this example 'all.x' is not necessary but we still use it for example purposes. I will explain later the awful looking last line when I will speak about indexing.

So to sum up 'merge' put together two data frame by a common column, certain precautions mus be taken, if there is more than one match between rows (for example if we had two times 'Citroën' in one data frame) then multiple row will be created, inflating the size of your data frame, so usualy this function is used one there is only one match between rows.


## Sorting a data frame;


Another common operation done on data frame is ordering, so classify the rows in a certain order (from biggest to lowest..), let's use again our merged mtcars data frame and sort it in ascending order (lowest first) on the number of gears;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_order<-df_merged[do.call(order,list(df_merged$gear)),]</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_merged$gear</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1]  3  3  3  3 NA  4  3  3  5  4  4  5  4  3  3  3  5  5  4  4  4  4  4  4  3  3  3  3  5  4  3  3  4</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_order$gear</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1]  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  4  4  4  4  4  4  4  4  4  4  4  4  5  5 5  5  5 NA</span></span></span>


The formula looks quite awful, let's put it down into pieces, first we say which data frame we want to order (df_merged) then we use a similar function to 'apply' but in a data frame context (do.call), we specify which function to apply (order), and then the list of arguments to use when applying the function (here the variable 'gear' of the data frame 'df_merged' so in R language this gives us 'df_merged$gear'), finally the most important thing the last comma it say that the called function should be applied on every row. If we want to sort in a decreasing order here is an equivalent command (note the adding of the minus sign),

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_order<-df_merged[do.call(order,list(-df_merged$gear)),]</span></span></span>


Now a very handy extension of this would be if we wanted to sort the column by a ascending order of their column name (first A last Z)

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_order<-df_merged[,do.call(order,list(colnames(df_merged)))]</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> colnames(df_merged)</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] "Model" "mpg"   "cyl"   "disp"  "hp"    "drat"  "wt"    "qsec"  "vs"    "am"    "gear"  "carb"  "Color"</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> colnames(df_order)</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] "am"    "carb"  "Color" "cyl"   "disp"  "drat"  "gear"  "hp"    "Model" "mpg"   "qsec" "vs"    "wt"</span></span></span>


Here we put the comma as the first argument which R interpret as columns, then we gave as argument the list of the column names.


## Changing the column order,


We already saw just before how to order the column, but if we want to be finer for example only wanting to put the last column at the second place we need to use a different strategy;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_merged<-df_merged[,c(1,13,2:12)]</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> head(df_merged)</span></span></span>
    <span style="color:#000000;">               <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Model Color  mpg cyl disp  hp drat    wt  qsec vs am gear carb</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1        AMC Javelin white 15.2   8  304 150 3.15 3.435 17.30  0  0    3    2</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">2 Cadillac Fleetwood  grey 10.4   8  472 205 2.93 5.250 17.98  0  0    3    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3         Camaro Z28 white 13.3   8  350 245 3.73 3.840 15.41  0  0    3    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4  Chrysler Imperial white 14.7   8  440 230 3.23 5.345 17.42  0  0    3    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5            Citroën  grey   NA  NA   NA  NA   NA    NA    NA NA NA   NA   NA</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">6         Datsun 710   red 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1</span></span></span>


What R did was to take the first column in the df_merged data frame and put it in the same place, then it took the 13eth column and put it in the second place and all remaining columns were rearranged. The 'c' is necessary (as always!) because we are giving a list of more than one elements (this always true in R whenever you want to give more than one element outside a function context you have to use 'c').


## Deleting a variable;


There are numerous way to delete a variable from a data frame here is just one that I selected because you don't need to know about the position of the variable in the data frame just the name of it:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> df_merged$Color<-NULL</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> head(df_merged)</span></span></span>
    <span style="color:#000000;">               <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">Model  mpg cyl disp  hp drat    wt  qsec vs am gear carb</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">1        AMC Javelin 15.2   8  304 150 3.15 3.435 17.30  0  0    3    2</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">2 Cadillac Fleetwood 10.4   8  472 205 2.93 5.250 17.98  0  0    3    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">3         Camaro Z28 13.3   8  350 245 3.73 3.840 15.41  0  0    3    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">4  Chrysler Imperial 14.7   8  440 230 3.23 5.345 17.42  0  0    3    4</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">5         Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">6   Dodge Challenger 15.5   8  318 150 2.76 3.520 16.87  0  0    3    2</span></span></span>


Very easy we set the variable 'color' to NULL so all its content is erased.


## Subseting and indexing;


This is a very powerful tool it allows you to take subset of the data frame, there are two ways to do it the first one by using the squared bracket and the index that R automatically use (remember when we use them to select specific columns in a matrix) or to use the function 'subset', from our data frame we want to select only the cars with 4 or more gears;

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new<-df_merged[df_merged$gear>=4,]</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new2<-subset(df_merged,gear>=4)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new$gear</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] 4 5 4 4 5 4 5 5 4 4 4 4 4 4 5 4 4</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new2$gear</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] 4 5 4 4 5 4 5 5 4 4 4 4 4 4 5 4 4</span></span></span>


In both ways there is a logical expression (here '>=') the only major difference is that in the first one we have to add a comma at the end to work on every rows when the function 'subset' does this automatically. This subseting is very often used so I will show a few more example of what we can do:

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> n<-8</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new<-df_merged[df_merged$cyl%in%n,]</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new$cyl</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] 8 8 8 8 8 8 8 8 8 8 8 8 8 8</span></span></span>


Here the '%in%' mean the intersection between df_merged$cyl and n, this intersection is very useful when you have a list of names and you want to extract informations related to them in a data frame.

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new<-subset(subset(df_merged,gear==4),cyl!=8)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new$cyl</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] 4 4 4 4 6 6 4 4 6 6 4 4</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">> new$gear</span></span></span>
    <span style="color:#000000;"> <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1] 4 4 4 4 4 4 4 4 4 4 4 4</span></span></span>


Now here is a nested subsetting in this case we are only keeping the rows (car models) that have 4 gears and not 8 cylinders (the '!=' operator mean not equal to).

You can play around indefinitely with these tools, this allow you to really master your data.

In a next tuto on data frame you will learn more complex operation on data frame like going from wide to long format, splitting and applying functions on data frame...
