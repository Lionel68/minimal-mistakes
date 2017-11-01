---
title: Computing R square for Generalized Linear Mixed Models in R
wordpress_id: 218
categories:
- R and Stat
tags:
- GLMM
- R
---

R square is a widely used measure of model fitness, in General Linear Models (GLM) it can be interpreted as the percent of variance in the response variable explained by the model. This measure is unitless which makes it useful to compare model between studies in meta-analysis analysis.
Generalized Linear Mixed models (GLMM) are extending GLM by including an hierarchical structure in the model, indeed GLMs assume that every observation are independent from each other. In biological studies this assumption is often violated under certain experimental design, for example in repeated measurement scheme (several sample of a similar unit over time), or in field studies with Block design to account for some natural variation in soil gradient. Therefore GLMM are becoming a popular technique among biologist to account for the multilevel structure in their dataset, see Bolker et al (2009) Trends in Ecology and Evolution. However these models due to their various variance terms (ie variance at the block level, variance at the observation level) make the computation of R square problematic. A recent article by Nakagawa and Schielzeth (2013, Methods in Ecology and Evolution) present a new technique to derive R square for these model.

Below is some R-code to derive these values for gaussian, binomial and poisson GLMM, the R-code for the computation of the R square was taken from the appendix of the article.
To help the comprehension let us imagine that the data correspond to some field study where was recorded in 8 plots: plant biomass (gaussian), presence of Oak species (binary/binomial), number of caught coleopterans (poisson), we think that these variables are dependent to the temperature and the vegetation type in the plot. In this exemple we have one random factor: the plots, two explanatory variable: one continuous, the temperature and one factor, the vegetation type.


#code for computing marginal and conditional R-square for gaussian, binomial and poisson GLMM
#the code for computing the R-square is taken from Nakagawa and Schielzeth 2013 MEE
library(lme4)
library(arm)
#making some simulation for gaussian data (plant biomass) depending on one continuous variable, one factor and one random intercept effect
temp<-runif(200,0,10)
veg_type<-gl(n=4,k=50,labels=c("A","B","C","D"))
#shuffle the factor
veg_type<-veg_type[sample(1:200,size=200,replace=FALSE)]
plot<-gl(n=8,k=25,labels=paste("A",1:8,sep=""))
modmat<-model.matrix(~i+plot+temp+veg_type-1,data.frame(i=rep(1,200),plot=plot,temp=temp,veg_type=veg_type))

#the plot effect
intercept.eff<-rnorm(8,mean=3,sd=2)
#put together all the effects
eff<-c(8,intercept.eff,3,0.3,1.5,-4)

#compute the repsonse variable, the plant biomass
mus<-modmat%*%eff
y<-rnorm(200,mean=mus,sd=1)
#put all in one data frame
data<-data.frame(y=y,temp=temp,veg_type=veg_type,plot=plot)

#the null model with only the plot term
mod0<-lmer(y~1+(1|plot),data)
#the full model
mod1<-lmer(y~temp+veg_type+(1|plot),data)
#model summary
summary(mod0)
summary(mod1)

#compute the marginal R-square
#compute the variance in the fitted values
VarF # VarCorr() extracts variance components
# attr(VarCorr(lmer.model),'sc')^2 extracts the residual variance, VarCorr()$plot extract the variance of the plot effect
VarF/(VarF + VarCorr(mod1)$plot[1] + attr(VarCorr(mod1), "sc")^2)

#compute the conditionnal R-square
(VarF + VarCorr(mod1)$plot[1])/(VarF + VarCorr(mod1)$plot[1] + (attr(VarCorr(mod1), "sc")^2))

# AIC and BIC needs to be calcualted with ML not REML in body size models
mod0ML<-lmer(y~1+(1|plot),data,REML=FALSE)
mod1ML<-lmer(y~temp+veg_type+(1|plot),data,REML=FALSE)

# View model fits for both models fitted by ML
summary(mod0ML)
summary(mod1ML)

#computing the percent of explained variance
#for the plot slope
1-(VarCorr(mod1)$plot[1]^2/VarCorr(mod0)$plot[1]^2)
#for the residuals
1-(var(residuals(mod1))/var(residuals(mod0)))

There is two Rsquare computed: the marginal R square which is the variance of the fitted values divided by the total variance, and the conditional variance which is the variance of the fitted values plus the variance of the random effect divided by the total variance. In their article Nakagawa and Schielzeth adviced to report these Rsquare along with AIC and Proportion of Change in Variance (PCV) which is computing the change of variance of specific components when adding some fixed effect, ie how much better is our explained variance at the plot level by adding two fixed effects.

Below is the code for computing the same index for Binomial (the presence of Oaks) and Poisson model (the number of caught coleopterans):

#simulating binomial response data
plot.eff<-rnorm(8,0,2)
all.eff<-c(-0.3,plot.eff,0.02,0.5,-0.8,0.8)
ps<-invlogit(modmat%*%all.eff)
ys<-rbinom(200,1,ps)

data<-data.frame(y=ys,temp=temp,veg_type=veg_type,plot=plot)

mod0<-glmer(y~1+(1|plot),data,family="binomial")
mod1<-glmer(y~temp+veg_type+(1|plot),data,family="binomial")

VarF <- var(as.vector(fixef(mod1) %*% t(mod1@pp$X)))
# VarCorr() extracts variance components
# attr(VarCorr(lmer.model),'sc')^2 extracts the residual variance, VarCorr()$plot extract the variance of the plot effect
VarF/(VarF + VarCorr(mod1)$plot[1] + attr(VarCorr(mod1), "sc")^2 + (pi^2)/3)

#compute the conditionnal R-square
(VarF + VarCorr(mod1)$plot[1])/(VarF + VarCorr(mod1)$plot[1] + (attr(VarCorr(mod1), "sc")^2) + (pi^2)/3)


#computing the percent of explained variance 
#for the plot slope 
1-(VarCorr(mod1)$plot[1]^2/VarCorr(mod0)$plot[1]^2)
#for the residuals
1-(var(residuals(mod1))/var(residuals(mod0)))


#poisson data
plot.eff<-rnorm(8,0,2)
all.eff<-c(-0.3,plot.eff,0.2,0.5,-0.8,0.8)
lambdas<-exp(modmat%*%all.eff)
ys<-rpois(200,lambdas)

data<-data.frame(y=ys,temp=temp,veg_type=veg_type,plot=plot)

mod0<-glmer(y~1+(1|plot),data,family="poisson")
mod1<-glmer(y~temp+veg_type+(1|plot),data,family="poisson")

VarF <- var(as.vector(fixef(mod1) %*% t(mod1@pp$X)))
# VarCorr() extracts variance components
# attr(VarCorr(lmer.model),'sc')^2 extracts the residual variance, VarCorr()$plot extract the variance of the plot effect
VarF/(VarF + VarCorr(mod1)$plot[1] + attr(VarCorr(mod1), "sc")^2 + log(1 + 1/exp(as.numeric(fixef(mod0)))))

#compute the conditionnal R-square
(VarF + VarCorr(mod1)$plot[1])/(VarF + VarCorr(mod1)$plot[1] + (attr(VarCorr(mod1), "sc")^2) + log(1 + 1/exp(as.numeric(fixef(mod0)))))

#computing the percent of explained variance 
#for the plot slope 
1-(VarCorr(mod1)$plot[1]^2/VarCorr(mod0)$plot[1]^2)
#for the residuals
1-(var(residuals(mod1))/var(residuals(mod0)))



If you run the code you may notice that some PCVs are negative, this means that the variance at that particular level has increased after the inclusion of the fixed effects. Have a look at the Nakagawa article and compare his values with the one obtained by running the code above, the authors also provide the R code they used for their analysis, have a look. And you may also go and look at the Rpubs version of this article (much nicer to read!): [ http://rpubs.com/hughes/13853](http://rpubs.com/hughes/13853)






