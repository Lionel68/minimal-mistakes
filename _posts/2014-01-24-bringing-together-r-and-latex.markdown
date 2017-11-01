---
title: Bringing together R and LaTex
wordpress_id: 205
categories:
- LaTex
- R and Stat
tags:
- Introduction
- Sweave
---

So as some of you may have noticed I am particularly enthusiast about R. For some time now  I have also being using LaTex for my reports and presentation. This week I discover during the lab group meeting that we can actually bring the two together using Sweave, now I was extremely excited and after some time tuning some settings I would like to share with you a short introduction into Sweave. If you have Rstudio (if you do not have it you should consider using it) you just have to click on file-> New-> R sweave and here you go you can start having fun.

If you do not know anything about LaTex it may seem daunting at first be I can assure you that it is really worth the effort, this software offer you great control and readability over your professional documents. A good place to start learning about LaTex is here: [https://en.wikibooks.org/wiki/LaTeX](https://en.wikibooks.org/wiki/LaTeX) .

Below is some code that created this file: [https://www.dropbox.com/s/kvyinyur15e6iol/sweave_tuto.pdf](https://www.dropbox.com/s/kvyinyur15e6iol/sweave_tuto.pdf)

Have fun:

%To comment in LaTex you use this symbol %

    
    \documentclass{article} %this is defining the page layout
    \usepackage{graphics} %this is use forplotting graphics
    \usepackage[usenames,dvipsnames]{color} %this is used to define new colors
    \usepackage{framed}  %This is to use the shaded environment
    \usepackage{hyperref} %To use URL
    
    
    
    \begin{document} %this start the proper document
    \definecolor{shadecolor}{gray}{0.90} %this is defining the color of the background in the shaded environment
    \SweaveOpts{concordance=TRUE, keep.source=TRUE} %to keep the R-code as it is
    
    
    \title{A short and gentle introduction into Sweave} %the title
    \author{Lionel} %me
    
    \maketitle %create the title
    
    \tableofcontents %add a table of contents
    
    \section{Doing R analysis} %start a new section
    
    <<echo=FALSE>>=
    options(continue=" ")
    options(width=60)
    @
    
    Sweave allows you to put R code into a LaTex file using chunks that are defined by two \textless  followed by some option stuff and two \textgreater  and an = then you can put the R code and at the end you have to put an arobas. Here is an example:
    
    <<example1, echo=TRUE>>=
    #some basic linear regression
    x<-rnorm(100,0,1)
    y<-2*x+1+rnorm(100,0,1)
    m1<-lm(y~x)
    summary(m1)
    @
    
    You can also had some formating parameters:
    
    \begin{shaded}
    \scriptsize
    <<example2>>=
    library(ggplot2)
    data(mtcars)
    xtabs(mpg~cyl,mtcars)
    @
    \end{shaded}
    
    Now if we want to plot figures there are two basic options:
    \begin{enumerate}
    \item Directly plotting from the R code
    \item Saving the pictures and using a LaTex command to control where to insert the plot
    \end{enumerate}
    
    Here is the first option:
    
    <<fig=TRUE>>=
    plot(y~x)
    @
    
    Using this option we can control the size parameters when we define the chunck using the height and width argument, the fig argument allows you to control if you want the plot to be made or not.
    But if we are deeply in love with the way LaTex handle graphics we can first compile the code, giving it a name using the label command and then by using include=FALSE we tell Sweave not to include the resulting figure.
    
    
    <<label=fig1, include=FALSE, fig=TRUE>>=
    plot(y~x)
    abline(m1,lty=2,col="red")
    @
    
    And now the figure is saved under: filename\-figure\_name, in our case this is sweave\_tuto\-fig1.pdf. Now we can call it using includegraphics and all the features going with it, like the captions or label settings
    
    
    \begin{figure}
    \includegraphics{sweave_tuto-fig1.pdf}
    \caption{Simple linear regression example}
    \end{figure}
    
    Now the best place to look for answers for basics question on LaTex is \url{<https://en.wikibooks.org/wiki/LaTeX>} and a nice introduction into customizing sweave can be found \url{<https://www.stat.auckland.ac.nz/~stat782/downloads/Sweave-customisation.pdf>}
    
    \begin{center}
    \huge
    {\color{Apricot} \textbf{Have fun with LaTex}}
    \end{center}
    
    \end{document}
