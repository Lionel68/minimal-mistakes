---
title: DataFrame manipulation in R from basics to dplyr
wordpress_id: 323
categories:
- R and Stat
tags:
- dplyr
- R
---



In my surroundings at work I see quite a few people managing their data in spreadsheet software like Excel or Calc, these software will do the work but I usually tend to do as little data manipulation in them as possible and to turn as soon as possible my spreadsheets into csv files and then bring the data to R where every single manipulation I do on them is recorded by default in the history (if you use RStudio) or in scripts if you are documenting your work (which should always be the way to go). The aim of this post is to show how to do some manipulations often done on data (ie subsetting, summarizing, ordering ...) in R. As always there are a thousand way to do an operation, I will go through the basic way to do these manipulation using the vector-based approach of R and then at the end show how new libraries allow you to do these manipulation on data frame using code easily understandable for those not grasping (yet) the magic of vector-based operations. (As always a nicer RPubs version of this article is available at: http://rpubs.com/Lionel/33216, if anyone around now how to transfer .Rmd files to Wordpress blog I'll be glad to hear about it)

    
    #################
    #Data management#
    #################
    
    
    #the data frame I will use
    data<-data.frame(Factor1=rep(LETTERS[1:5],each=20),Factor2=sample(letters[1:10],100,replace=TRUE),Var1=rnorm(100,2,4),Var2=rpois(100,2))
    #some simple summary
    summary(data)
    table(data$Factor1)
    table(data$Factor2)
    
    #####basic way using vectors######
    #subsetting
    #only keep observation with Factor1 equal to A
    sub1<-subset(data,Factor1=="A")
    #only keep observation with Factor1 equal to A and Var2 lower than 4
    data$Factor1=="A"
    sub2<-data[data$Factor1=="A" & data$Var2<4,]
    summary(sub2)
    #only keep every thrird rows
    head(data[seq(1,nrow(data),3),])
    #only keep row number 2,6,13,22 from column 1 and 4
    data[c(2,6,13,22),c(1,4)] #when numbers are following each other can use :, ie 1:10
    
    #summarising
    library(plyr)
    #get the mean value and standard error of Var1 for each level of Factor1
    rbind.fill(by(data,data$Factor1,function(x) return(data.frame(Factor1=unique(x$Factor1),Mean=mean(x$Var1),SE=sd(x$Var1)/sqrt(length(x$Var1))))))
    #get the 25% and 75% quantile for Var2 for each level of Factor2
    rbind.fill(by(data,data$Factor2,function(x) return(data.frame(Factor2=unique(x$Factor2),Q_25=quantile(x$Var2,prob=0.25),Q_75=quantile(x$Var2,prob=0.75)))))
    


Wow these two last calls can seem rather intimidating at first but as always you need to start by the center and then walk away from it to understand what is happening in these two lines, let's look at the first one for example. First we call an un-named function on the dataframe data and we apply this function to each level of data$Factor1 separately, we pass these chunks of data to the function and call them x, now this function will return a dataframe made of three columns, the first one named Factor1 take the unique value present in the column Factor1 of the x chunks, the second one takes the mean of the Var1 values, the third one divide the standard deviation of Var1 values by the square root of the number of observations (giving the standard error around the mean). As the by function will return a series of dataframe we can combine them together in one dataframe using rbind.fill. This is rather long lines of code, keep them in mind as at the end of the post you will see how to do this in a different way.

    
    #changing column order
    data<-data[,c(1,4,3,2)]
    head(data)
    #also work with column names
    data<-data[,c("Factor1","Var1","Factor2","Var2")]
    head(data)
    #sorting the rows first by Factor1 then by Factor2
    data<-data[do.call(order,list(data$Factor1,data$Factor2)),]
    
    ######increasing complexity, switching from long to wide format########
    library(reshape2)
    #the long format makes one column keeping the info on a grouping variable (eg Sex) instead of making a separate column for each levels
    #the object data is for example in a long format, we may want to make a separate column for each level of Factor1 and storing Var1 in the rows
    data$Observation<-rep(1:20,time=5)
    data_wide<-dcast(Observation~Factor1,data = data,value.var = "Var1") #the left-hand side of the formula is the variable that will make up the rows the right hand side the columns
    #if certain combination are missing one can use the fill argument
    data_wide<-dcast(Factor2~Factor1,data=data,fun.aggregate = length,fill=0) #here we count how many observations are for each levels of Factor2 and Factor1
    #other functions can be provided if nore then one values are present in each cells
    data_wide<-dcast(Factor2~Factor1,data=data,fun.aggregate = sum,value.var="Var2",fill=0)
    #turning back the data to a long format
    data_long<-melt(data_wide,value.name = "Sum_Var2",id.vars="Factor2",variable.name = "Factor1") #melt the data frame id.vars correspond to the column that contain the factor infos
    #long format are then pretty handy to use for plotting
    library(ggplot2)
    ggplot(data_long,aes(x=Factor2,y=Sum_Var2,colour=Factor1))+geom_point()
    #but is also the way the data should be structure for data analysis:
    lm(Sum_Var2~Factor2+Factor1,data_long)
    


[![data1](https://biologyforfun.files.wordpress.com/2014/10/data1.png)](https://biologyforfun.files.wordpress.com/2014/10/data1.png)

For more about long and wide format you can also look at the great article in the R cookbook on this: http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/.
Now let's turn to a new library that came out to my attention recently and that is extremely elegant and easy to use. More info on this library: http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html

    
    #####using the dplyr to turn all data manipulation easy######
    library(dplyr)
    #the five functions of dplyr, dplyr works with data frame instead of vectors which makes data frame manipulation much more straightforward
    filter(data,Factor1%in%c("A","D"),Var1>=0) #similar to subset
    head(select(data,contains("factor",ignore.case=TRUE))) #only return some specific columns see ?select for more possibilities
    head(arrange(data,Factor1,Var1))
    head(mutate(data,Var3=Var1+Var2,M_1=(Observation+Var2)/length(Var2)))
    summarise(data,sum(Var2))
    #summarise becomes extremely handy when use with group_by
    data_d<-summarise(group_by(data,Factor1),Mean=mean(Var1),SE=sd(Var1)/sqrt(n())) #remember the huge by function needed to get the same results
    #the n() function is built-in with dplyr and count how many element there are
    #going from the full dataset to a graph summarising mean difference between factor is swift and painless using these functions
    ggplot(data_d,aes(x=Factor1,y=Mean))+geom_point(colour="red",size=3,show_guide=FALSE)+geom_errorbar(aes(ymin=Mean-2*SE,ymax=Mean+2*SE),width=.1)
    


[![data2](https://biologyforfun.files.wordpress.com/2014/10/data2.png)](https://biologyforfun.files.wordpress.com/2014/10/data2.png)

As always as you dwell deeper in these topics you can see that the options are extremely numerous which makes R extremely enjoyable for data manipulation once the basics are understood. As R is used nowadays for most of the data analysis (in my field of work at least), I see it natural to bring the data as soon as possible into R to really play with it and grasp there structure instead of just doing linear models in R and then using other software to make plots or observe basic patterns in the data. Enjoy your data manips'!
