---
slug: assigning-names-to-object-within-a-loop-in-r
title: Assigning Names to object within a Loop in R
wordpress_id: 54
categories:
- R and Stat
tags:
- Advanced
- R
- Statistics
---

I just came across a great solution today to one of my recurring problems in R. When I run a for loop for example I create/modify some object and then I sometime want to save these modifications at each iteration under specific names to access them afterwards.

Let's look at an example to clarify all this, I want to create 10 matrix with increasing numbers, the first being 1 until 20, the second 21 until 42 and so on... I could create 'by hand' the 10 matrix but that is rather tedious instead I can run a for loop to create all this and save them under meaningfull names.



    
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">> count<-1</span></span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">> for (i in seq(1,181,20))</span></span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">+ {</span></span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">+     assign(paste("X",count,sep=""),matrix(i:(i+19),ncol=4,byrow=FALSE))</span></span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">+     count<-count+1</span></span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">+ }</span></span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;"><span style="color:#0000ff;">> X10</span></span></span></span>
    <span style="color:#000000;">     <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[,1] [,2] [,3] [,4]</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[1,]  181  186  191  196</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[2,]  182  187  192  197</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[3,]  183  188  193  198</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[4,]  184  189  194  199</span></span></span>
    <span style="color:#000000;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">[5,]  185  190  195  200</span></span></span>




Before running the loop I create a counter to keep track of the number of iteration. Then I assign to the object 'X' with the corresponding number of iteration a matrix made of number from 'i' to 'i+19' with four columns. What the loops do is that it take 'i' in the sequence of numbers from 1 until 181 by a step of 20, so at the first iteration our matrix will be called 'X1' and will be made of number from 1 to 20 ordered by columns.



Just for fun here is how I used this newly learned function:



    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">for (i in 1:length(unique(df3$MaxBIOME)))</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu Mono;"><span style="font-size:small;">{</span></span></span>
    <span style="color:#0000ff;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">y<-unique(df3$MaxBIOME)[i]</span></span></span>
    <span style="color:#0000ff;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">xpos<-min(subset(df3,MaxBIOME==y)$Temp_Max)</span></span></span>
    <span style="color:#0000ff;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">ypos<-quantile(subset(df3,MaxBIOME==y)$SPECNO,probs=0.9,names=FALSE)</span></span></span>
    <span style="color:#0000ff;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">assign(paste("p", i, sep = ""),ggplot(subset(df3,MaxBIOME==y),aes(x=Temp_Max,y=SPECNO))+geom_point()+stat_smooth(method="lm")+annotate("text", x = xpos+5, y = ypos, label = paste("Biome",y,sep="")))</span></span></span>
    <span style="color:#0000ff;">  <span style="font-family:Ubuntu Mono;"><span style="font-size:small;">}</span></span></span>


The point was to create one graph per Biomes in a biogeographical context, and I wanted to have these graphs as object so I could work on with them later on.
