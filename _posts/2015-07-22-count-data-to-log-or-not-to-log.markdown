---
title: 'Count data: To Log or Not To Log'
wordpress_id: 459
categories:
- Biological Stuff
- R and Stat
tags:
- ecology
- GLM
- LM
- R
- Statistics
---

Count data are widely collected in ecology, for example when one count the number of birds or the number of flowers. These data follow naturally a Poisson or negative binomial distribution and are therefore sometime tricky to fit with standard LMs. A traditional approach has been to log-transform such data and then fit LMs to the transformed data. Recently a [paper](http://onlinelibrary.wiley.com/doi/10.1111/j.2041-210X.2010.00021.x/full) advocated against the use of such transformation since it led to high bias in the estimated coefficients. More recently another [paper](http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12386/abstract?userIsAuthenticated=false&deniedAccessCustomisedMessage=) argued that log-transformation of count data followed by LM led to lower type I error rate (ie saying that an effect is significant when it is not) than GLMs. What should we do then?

Using a slightly changed version of the code published in the Ives 2015 paper let’s explore the impact of using these different modelling strategies on the rejection of the null hypothesis and the bias of the estimated coefficients.

[code language="r"]

#load the libraries
library(MASS)
library(lme4)
library(ggplot2)
library(RCurl)
library(plyr)

#download and load the functions that will be used
URL<-"https://raw.githubusercontent.com/Lionel68/Jena_Exp/master/stats/ToLog_function.R"
download.file(URL,destfile=paste0(getwd(),"/ToLog_function.R"),method="curl")
source("ToLog_function.R")

[/code]

Following the paper from Ives and code therein I simulated some predictor (x) and a response (y) that follow a negative binomial distribution and is linearly related to x.
In the first case I look at the impact of varying the sample size on the rejection of the null hypothesis and the bias in the estimated coefficient between y and x.

[code language="r"]

######univariate NB case############
base_theme<-theme(title=element_text(size=20),text=element_text(size=18))
#range over n
output<-compute.stats(NRep=500,n.range = c(10,20,40,80,160,320,640,1280))
ggplot(output,aes(x=n,y=Reject,color=Model))+geom_path(size=2)+scale_x_log10()+labs(x="Sample Size (log-scale)",y="Proportion of Rejected H0")+base_theme
ggplot(output,aes(x=n,y=Bias,color=Model))+geom_path(size=2)+scale_x_log10()+labs(x="Sample Size (log-scale)",y="Bias in the slope coefficient")+base_theme

[/code]

[![Figure 1](https://biologyforfun.files.wordpress.com/2015/07/tolog1f.png)](https://biologyforfun.files.wordpress.com/2015/07/tolog1f.png)

For this simulation round the coefficient of the slope (b1) was set to 0 (no effect of x on y), and only the sample size varied. The top panel show the average proportion of time that the p-value of the slope coefficient was lower than 0.05 (H0:b1=0 rejected). We see that for low sample size (<40) the Negative Binomial model has higher proportion of rejected H0 (type I error rate) but this difference between the model disappear as we reached sample size bigger than 100. The bottom panel show the bias (estimated value - true value) in the estimated coefficient. For very low sample size (n=10), Log001, Negative Binomial and Quasipoisson have higher bias than Log1 and LogHalf. For larger sample size the difference between the GLM team (NB and QuasiP) and the LM one (Log1 and LogHalf) gradually decrease and both teams converged to a bias around 0 for larger sample size. Only Log0001 is behaved very badly. From what we saw here it seems that Log1 and LogHalf are good choices for count data, they have low Type I error and Bias along the whole sample size gradient.

The issue is that an effect of exactly 0 never exist in real life where most of the effect are small (but non-zero) thus [the Null Hypothesis will never be true](http://andrewgelman.com/2015/03/02/what-hypothesis-testing-is-all-about-hint-its-not-what-you-think/). Let’s look know how the different models behaved when we vary b1 alone in a first time and crossed with sample size variation.

[code language="r"]

#range over b1
outpu<-compute.stats(NRep=500,b1.range = seq(-2,2,length=17))
ggplot(outpu,aes(x=b1,y=Reject,color=Model))+geom_path(size=2)+base_theme+labs(y="Proportion of Rejected H0")
ggplot(outpu,aes(x=b1,y=Bias,color=Model))+geom_path(size=2)+base_theme+labs(y="Bias in the slope coefficient")

[/code]

[![Figure2](https://biologyforfun.files.wordpress.com/2015/07/tolog3f.png)](https://biologyforfun.files.wordpress.com/2015/07/tolog3f.png)

Here the sample size was set to 100, what we see in the top graph is that for a slope of exactly 0 all model have a similar average proportion of rejection of the null hypothesis. As b1 become smaller or bigger the average proportion of rejection show very similar increase for all model expect for Log0001 which has a slower increase. This curves basically represent the power of the model to detect an effect and is very similar to the Fig2 in the Ives 2015 paper. Now the bottom panel show that all the LM models have bad behaviour concerning their bias, they have only small bias for very small (close to 0) coefficient, has the coefficient gets bigger the absolute bias increase. This means that even if the LM models are able to detect an effect with similar power the estimated coefficient is wrong. This is due to the value added to the untransformed count data in order to avoid -Inf for 0s. I have no idea on how one may take into account arithmetically these added values and then remove its effects …

Next let’s cross variation in the coefficient with sample size variation:

[code language="r"]
#range over n and b1
output3<-compute.stats(NRep=500,b1.range=seq(-1.5,1.5,length=9),n.range=c(10,20,40,80,160,320,640,1280))
ggplot(output3,aes(x=n,y=Reject,color=Model))+geom_path(size=2)+scale_x_log10()+facet_wrap(~b1)+base_theme+labs(x="Sample size (log-scale)",y="Proportion of rejected H0")
ggplot(output3,aes(x=n,y=Bias,color=Model))+geom_path(size=2)+scale_x_log10()+facet_wrap(~b1)+base_theme+labs(x="Sample size (log-scale)",y="Bias in the slope coefficient")

[/code]

[![Figure 3](https://biologyforfun.files.wordpress.com/2015/07/tolog5f.png)](https://biologyforfun.files.wordpress.com/2015/07/tolog5f.png)

The tope panel show one big issue of focussing only on the significance level: rejection of H0 depend not only on the size of the effect but also on the sample size. For example for b1=0.75 (a rather large value since we work on the exponential scale) less than 50% of all models rejected the null hypothesis for a sample size of 10. Of course as the effect sizes gets larger the impact of the sample size on the rejection of the null hypothesis is reduced. However most effect around the world are small so that we need big sample size to be able to “detect” them using null hypothesis testing. The top graph also shows that NB is slightly better than the other models and that Log0001 is again having the worst performance. The bottom graphs show something interesting, the bias is quasi-constant over the sample size gradient (maybe if we would look closer we would see some variation). Irrespective of how many data point you will collect the LMs will always have bigger bias than the GLMs (expect for the artificial case of b1=0)

To finish with in Ives 2015 the big surprise was the explosion of type I error with the increase in the variation in individual-level random error (adding a random normally distributed value to the linear predictor of each data point and varying the standard deviation of these random values) as can be seen in the Fig3 of the paper.

[code language="r"]

#range over b1 and sd.eps
output4<-compute.statsGLMM(NRep=500,b1.range=seq(-1.5,1.5,length=9),sd.eps.range=seq(0.01,2,length=10))
ggplot(output4,aes(x=sd.eps,y=Reject,color=Model))+geom_path(size=2)+facet_wrap(~b1)+base_theme+labs(x="",y="Proportion of rejected H0")
ggplot(output4,aes(x=sd.eps,y=Bias,color=Model))+geom_path(size=2)+facet_wrap(~b1)+base_theme+labs(x="Standard Deviation of the random error",y="Bias of the slope coefficient")
[/code]

[![Figure 4](https://biologyforfun.files.wordpress.com/2015/07/tolog7f.png)](https://biologyforfun.files.wordpress.com/2015/07/tolog7f.png)

Before looking at the figure in detail please note that a standard deviation of 2 in this context is very high, remember that these values will be added to the linear predictor which will be exponentiated so that we will end up with very large deviation. In the top panel there are two surprising results, the sign of the coefficient affect the pattern of null hypothesis rejection and I do not see the explosion of rejection rates for NB or QuasiP that are presented in Ives 2015. In his paper Ives reported the LRT test for the NB models when I am reporting the p-values from the model summary directly (Wald test). If some people around have computing power it would be interesting to see if changing the seed and/or increasing the number of replication lead to different patterns … The bottom panel show again that the LMs bias are big, the NB and QuasiP models have an increase in the bias with the standard deviation but only if the coefficient is negative (I suspect some issue with the exponentiating of large random positive error), as expected the GLMM perform the best in this context.

Pre-conclusion, in real life of course we would rarely have a model with only one predictor, most of the time we will build larger models with complex interaction structure between the predictors. This will of course affect both H0 rejection and Bias, but this is material for a next post :)

Let’s wrap it up; we’ve seen that even if LM transformation seem to be a good choice for having a lower type I error rate than GLMs this advantage will be rather minimal when using empirical data (no effect are equal to 0) and potentially dangerous (large bias). Ecologists have sometime the bad habits to turn their analysis into a star hunt (R standard model output gives stars to significant effects) and focusing only on using models that have the best behavior towards significance (but large bias) does not seem to be a good strategy to me. [More](https://dynamicecology.wordpress.com/2012/11/27/ecologists-need-to-do-a-better-job-of-prediction-part-i-the-insidious-evils-of-anova/) and [more](http://jabberwocky.weecology.org/2014/01/28/why-i-like-this-testing-the-roles-of-competition-facilitation-and-stochasticity-on-community-structure-in-a-species-rich-assemblage/) people call for increasing the predictive power of ecological model, we need then modelling techniques that are able to precisely (low bias) estimate the effects. In this context transforming the data to make them somehow fit normal assumption is sub-optimal, it is much more natural to think about what type of processes generated the data (normal, poisson, negative binomial, with or without hierarchical structure) and then model it accordingly. There are extensive discussion nowadays about the use and abuse of p-values in science and I think that in our analysis we should slowly but surely shifts our focus from "significance/p-values<0.05/star hunting" only to a more balanced mix of effect-sizes (or standardized slopes), p-values and R-square.
