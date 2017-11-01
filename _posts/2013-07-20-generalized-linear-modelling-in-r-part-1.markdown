---
title: Generalized Linear Modelling in R (part 1)
wordpress_id: 147
categories:
- R and Stat
tags:
- GLM
- R
---

In classical linear modelling we are assuming that the response variable (Y) is normally distributed, however for certain type of data like count data or presence/absence data this is not the case.

There is in statistic an ensemble of technique called Generalized Linear Modelling (GLM in short) where the reponse variable follow one known distribution, these are for example: gaussian, poisson, Bernoulli or binomial.

A GLM is made of three parts: the assumptions of the distribution of the response variable, the predictors used to build the model (the X part) and the link between the predictors and the response variable.

Let's first see an exmple of GLM with a gaussian distribution (which is basically a linear model)

    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">#load the dataset airquality measuring various climatic variables</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">data(airquality)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">m_glm1<-glm(Temp~Wind,airquality,family="gaussian")</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">m_lm<-lm(Temp~Wind,airquality)
    
    #you can compare the two output which gives similar estimates of the slope and intercept</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">summary(lm)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">summary(glm)
    
    #model validation plot, residuals vs fitted values, residuals vs predictors and histogramm of #residuals</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">r<-residuals(m_glm1)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">f<-fitted.values(m_glm1)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">par(mfrow=c(2,2))</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">plot(r~f)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">plot(r~airquality$Wind)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">hist(r)
    
    #add a plot with the estimated intercept and slope (which are both significantly different from #0)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">plot(Temp~Wind,airquality)</span></span></span>
     <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">abline(a=90.1349,b=-1.2305,col="red")</span></span></span>


[![Model Validation Plots](http://biologyforfun.files.wordpress.com/2013/07/glm1.png?w=300)](http://biologyforfun.files.wordpress.com/2013/07/glm1.png)

From this example we see that linear models are GLM with a gaussian distribution. The model validation plot show that there is no pattern in the residuals which could violate the assumption of the homogeneity of the variance and the residuals are normally distributed. The conclusion that we can draw from this are: the wind values significantly affect the temperature value in a negative way.


Know let's look at some data which are not normally distributed, count data which follow a poisson distribution:




    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">#a poisson example with the count of Amphibians road kills (Zuur, 2009)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">rk<-data.frame(death=c(22,14,65,55,88,104,49, 66, 26, 47, 35, 55, 44, 30, 33, 29, 34, 64, 76, 32, 34, 32, 35, 22, 34, 25, 18,14, 14, 7, 7, 17, 10, 3, 6, 5, 2, 3, 2, 2, 7, 3, 5, 4, 7, 12, 7, 14, 10, 4, 11, 3)
    ,distance=250.214 , 741.179, 1240.080, 1739.885, 2232.130, 2724.089, 3215.511, 3709.401, 4206.477, 4704.176,5202.328, 5700.669, 6199.342, 6698.151, 7187.762, 7668.833, 8152.155, 8633.224, 
    9101.411, 9573.578,10047.630, 10523.939, 11002.496, 11482.896, 11976.232, 12470.968, 12968.285, 13465.914, 13961.321, 14432.954,14904.995, 15377.983, 15854.389, 16335.936, 16810.109, 
    17235.045, 17673.064, 18167.269, 18656.949, 19149.507,19645.717, 20141.987, 20640.729, 21138.903, 21631.542, 22119.102 ,22613.647, 23113.450, 23606.088, 24046.886,24444.874, 24884.803)</span></span></span>
    
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">#do a poisson model</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">m_glm2<-glm(death~distance,rk,family="poisson")</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">summary(m_glm2)
    </span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">#model validation plot with the fitted data</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">r<-resid(m_glm2)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">f<-fitted.values(m_glm2)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">par(mfrow=c(2,2))</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">plot(r~f,ylab="Residuals",xlab="Fitted values")</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">plot(r~rk$distance,xlab="Distance",ylab="Residuals")</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">hist(r,main="",xlab="Residuals")</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">plot(death~distance,rk)
    </span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">#add the predicted values with the 95% confidence interval</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">pred<-predict(m_glm2,type="response",se.fit=TRUE)</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">lines(rk$distance,pred$fit,lty=1,col="blue")</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">lines(rk$distance,pred$fit+1.96*pred$se.fit,lty=2,col="blue")</span></span></span>
    <span style="color:#0000ff;"><span style="font-family:Ubuntu;"><span style="font-size:small;">lines(rk$distance,pred$fit-1.96*pred$se.fit,lty=2,col="blue")</span></span></span>


[![Model Validation Plots](http://biologyforfun.files.wordpress.com/2013/07/glm2.png?w=300)](http://biologyforfun.files.wordpress.com/2013/07/glm2.png)

The summary command on a glm object give similar information as in a lm object. We have the formula call, informations about the distribution of the residuals, the estimated coefficiants; in this case they are on a logarithmic scale since the default link between the predictors and the response variable for a poisson distribution is the log function (see ?family). Then information on the total and residuals sum of squares, and an AIC coefficient which can be usefull when comparing different models.

Litterature:

Zuur et al books, [http://highstat.com/books.htm](http://highstat.com/books.htm)

Zeilis et al, [http://cran.r-project.org/web/packages/pscl/vignettes/countreg.pdf](http://cran.r-project.org/web/packages/pscl/vignettes/countreg.pdf)


