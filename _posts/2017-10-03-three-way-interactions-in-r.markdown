---
title: Interpreting three-way interactions in R
wordpress_id: 2630
categories:
- R and Stat
tags:
- interaction
- LM
- R
---

A reader asked in a comment to my post on [interpreting two-way interactions](https://biologyforfun.wordpress.com/2014/04/08/interpreting-interaction-coefficient-in-r-part1-lm/) if I could also explain interaction between two categorical variables and one continuous variable. Rather than just dwelling on this particular case, here is a full blog post with all possible combination of categorical and continuous variables and how to interprete standard model outputs. Do note that three-way interactions can be (relatively) easy to understand conceptually but when it comes down to interpreting the meaning of individual coefficients it will get pretty tricky.


## Three categorical variables


The first case is when all three interacting variables are categorical, something like: country, sex, education level.

The key insight to understand three-way interactions involving categorical variables is to realize that each model coefficient can be switched on or off depending on the level of the factors. It is worth considering the equation for such a model:

y = Intercept + F12 * (F1 == 2) + F22 * (F2 == 2) + F23 * (F2 == 3) + F24 * (F2 == 4) + \\ F32 * (F3 == 2) + F12:F22 * (F1 == 2) * (F2 == 2) + F12:F23 * (F1 ==2) * (F2 == 3) + \\ F12:F24 * (F1 == 2) * (F2 == 4) + F12:F32 * (F1 == 2) * (F3 == 2) + F22:F32 * (F2 == 2) * (F3 == 2) + \\ F23:F32 * (F2 == 3) * (F3 == 2) + F24:F32 * (F2 == 4) * (F3 == 2) + F12:F22:F32 * (F1 == 2) * (F2 == 2) * (F3 == 2) + \\ F12:F23:F32 * (F1 == 2) * (F2 == 3) * (F3 == 2) + F12:F24:F32 * (F1 == 2) * (F2 == 4) * (F3 == 2)

This might seem overwhelming at first but bear with me a little while longer. In this equation the (FX == Y) are so-called indicator functions, for instance (F1 == 2) returns a 1 when the level of the factor F1 is equal to 2 and return 0 in all other cases. These indicator function will switch on or off the regression coefficient depending on the particular combination of factor levels.

Got it? No? Then let's simulate some data to see how an example can help us get a better understanding:

    
    set.seed(20170925) #to get stable results for nicer plotting
    #three categorical variables
    dat <- data.frame(F1=gl(n = 2,k = 50),
                      F2=factor(rep(rep(1:4,times=c(12,12,13,13)),2)),
                      F3=factor(rep(c(1,2),times=50)))
    #the model matrix
    modmat <- model.matrix(~F1*F2*F3,dat)
    #effects
    betas <- runif(16,-2,2)
    #simulate some response
    dat$y <- rnorm(100,modmat%*%betas,1)
    #check the design
    xtabs(~F1+F2+F3,dat)
    #model
    m <- lm(y~F1*F2*F3,dat) 
    summary(m) 
    Call: lm(formula = y ~ F1 * F2 * F3, data = dat)  
     Residuals: Min 1Q Median 3Q Max   
    -2.23583 -0.49807 0.01231 0.60524 2.31008 
    
      Coefficients: Estimate Std. Error t value Pr
    (Intercept)   1.2987     0.3908   3.323  0.00132 **
    F12           1.1204     0.5526   2.027  0.04579 *
    F22          -0.7929     0.5526  -1.435  0.15507
    F23          -1.6522     0.5325  -3.103  0.00261 **
    F24           1.4206     0.5526   2.571  0.01191 *
    F32           0.2779     0.5526   0.503  0.61637
    F12:F22      -1.5760     0.7815  -2.017  0.04694 *
    F12:F23      -0.9997     0.7531  -1.327  0.18797
    F12:F24      -0.2002     0.7815  -0.256  0.79846
    F12:F32      -0.5022     0.7815  -0.643  0.52224
    F22:F32      -0.3491     0.7815  -0.447  0.65627
    F23:F32      -2.2512     0.7674  -2.933  0.00432 **
    F24:F32      -0.5596     0.7674  -0.729  0.46791
    F12:F22:F32   0.9872     1.1052   0.893  0.37430
    F12:F23:F32   1.6078     1.0853   1.481  0.14224
    F12:F24:F32   1.8631     1.0853   1.717  0.08972 .
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    Residual standard error: 0.9572 on 84 degrees of freedom
    Multiple R-squared: 0.8051, Adjusted R-squared: 0.7703
    F-statistic: 23.13 on 15 and 84 DF, p-value: < 2.2e-16
    


Understanding raw model outcome is made easier by going through specific cases by setting the different variables to different levels.

For instance say we have an observation where F1 == 1, F2 == 1 and F3 == 1, in this case we have:

y_i = Intercept + F12 * 0 + F22 * 0 + F23 * 0 + F24 * 0 + F32 * 0 and so on ...

So in this case our model predicted a value of:

```r
coef(m)[1]

(Intercept)
1.298662
```

Now if we have F1 == 2, F2 == 1 and F3 == 1 we have:

y_i = Intercept + F12 * 1 + F22 * 0 + F23 * 0 + F24 * 0 + F32 * 0 and so on ...

Model prediction in this case is:

```r
coef(m)[1] + coef(m)[2]

(Intercept)
2.419048
```

Let's get a bit more complicated, for cases where: F1 == 2, F2 == 3 and F3 == 2:

y_i = Intercept + F12 * 1 + F22 * 0 + F23 * 1 + F24 * 0 + F32 * 1 + F12:F22 * 0 + F12:F23 * 1 + F12:F32 * 1 + F22:F32 * 0 + F23:F32 * 1 + F24:F32 * 0 + F12:F22:F32 * 0 + F12:F23:F32 * 1 + F12:F24:F32 * 0

Model prediction in this case is:

```r
coef(m)[1] + coef(m)[2] + coef(m)[4] + coef(m)[6] + coef(m)[8] + coef(m)[10] + coef(m)[12] + coef(m)[16]

(Intercept)
-0.8451774
```

The key message from all this tedious writing is that the interpretation of model coefficient involving interactions cannot be easily done when considering coefficient in isolation. One needs to add coefficients together to get predicted values in different cases and then one can compare how going from one level to the next affect the response variable.

When plotting interactions you have to decide which variables you want to focus on, as depending on how you specify the plot certain comparison will be easier than others. Here I want to focus on the effect of F1 on my response:

```r
#model prediction
pred <- expand.grid(F1=factor(1:2),F2=factor(1:4),F3=factor(1:2))
pred$y <- predict(m,pred)
#plot
ggplot(dat,aes(x=F2,y=y,fill=F1))+geom_boxplot(outlier.size = 0,color=NA)+
facet_grid(~F3,labeller="label_both")+
geom_linerange(data = pred[1:2,],aes(ymin=y[1],ymax=y[2]),color="orange",size=2) +
geom_text(data = pred[1,],aes(label="F12",hjust=0.4,vjust=4))+
geom_linerange(data=pred[3:4,],aes(ymin=y[1],ymax=y[2]),color="orange",size=2)+
geom_text(data = pred[3,],aes(label="F12+\nF12:F22",hjust=0.35,vjust=2))+
geom_linerange(data=pred[5:6,],aes(ymin=y[1],ymax=y[2]),color="orange",size=4)+
geom_text(data = pred[5,],aes(label="F12+\nF12:F23",hjust=0.35,vjust=-0.5))+
geom_linerange(data=pred[7:8,],aes(ymin=y[1],ymax=y[2]),color="orange",size=2)+
geom_text(data = pred[7,],aes(label="F12+\nF12:F24",hjust=0.35,vjust=2))+
geom_linerange(data = pred[9:10,],aes(ymin=y[1],ymax=y[2]),color="orange",size=2) +
geom_text(data = pred[9,],aes(label="F12",hjust=0.4,vjust=-3))+
geom_linerange(data = pred[11:12,],aes(ymin=y[1],ymax=y[2]),color="orange",size=2) +
geom_text(data = pred[11,],aes(label="F12+F12:F22+\nF12:F32\n+F12:F22:F32",hjust=0.4,vjust=0))+
geom_linerange(data = pred[13:14,],aes(ymin=y[1],ymax=y[2]),color="orange",size=2) +
geom_text(data = pred[13,],aes(label="F12+F12:F23+\nF12:F32\n+F12:F23:F32",hjust=0.4,vjust=1.2))+
geom_linerange(data = pred[15:16,],aes(ymin=y[1],ymax=y[2]),color="orange",size=2) +
geom_text(data = pred[15,],aes(label="F12+F12:F24+\nF12:F32\n+F12:F24:F32",hjust=0.7,vjust=1))+
geom_point(data=pred)
```



