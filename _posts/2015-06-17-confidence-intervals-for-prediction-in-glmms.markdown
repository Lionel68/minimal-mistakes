---
title: Confidence Intervals for prediction in GLMMs
wordpress_id: 449
categories:
- R and Stat
tags:
- GLMM
- R
---

With LM and GLM the predict function can return the standard error for the predicted values on either the observed data or on new data. This is then used to draw confidence or prediction intervals around the fitted regression lines. The confidence intervals (CI) focus on the regression lines and can be interpreted as (assuming that we draw 95% CI): "If we would repeat our sampling X times the regression line would fall between this interval 95% of the time". On the other hand the prediction interval focus on single data point and could be interpreted as (again assuming that we draw 95% CI): "If we would sample X times at these particular value for the explanatory variables, the response value would fall between this interval 95% of the time". The [wikipedia page](https://en.wikipedia.org/wiki/Confidence_interval#Meaning_and_interpretation) has some nice explanation about the meaning of confidence intervals.
For GLMM the predict function does not allow one to derive standard error, the reason being (from the help page of predict.merMod): "There is no option for computing standard errors of predictions because it is difficult to define an efficient method that incorporates uncertainty in the variance parameters". This means there is for now no way to include in the computation of the standard error for predicted values the fact that the fitted random effect standard deviation are just estimates and may be more or less well estimated. We can however still derive confidence or prediction intervals keeping in mind that we might underestimate the uncertainty around the estimates.

[code language="r"]

library(lme4)

#first case simple lmer, simulate 100 data points from 10 groups with one continuous fixed effect variable
x<-runif(100,0,10)
f<-gl(n = 10,k = 10)
data<-data.frame(x=x,f=f)
modmat<-model.matrix(~x,data)
#the fixed effect coefficient
fixed<-c(1,0.5)
#the random effect
rnd<-rnorm(10,0,0.7)
#the simulated response values
data$y<-rnorm(100,modmat%*%fixed+rnd[f],0.3)

#model
m<-lmer(y~x+(1|f),data)

#first CI and PI using predict-like method, using code posted here: http://glmm.wikidot.com/faq
newdat<-data.frame(x=seq(0,10,length=20))
mm<-model.matrix(~x,newdat)
newdat$y<-mm%*%fixef(m) 
#predict(m,newdat,re.form=NA) would give the same results
pvar1 <- diag(mm %*% tcrossprod(vcov(m),mm))
tvar1 <- pvar1+VarCorr(m)$f[1] # must be adapted for more complex models
newdat <- data.frame(
  newdat
  , plo = newdat$y-1.96*sqrt(pvar1)
  , phi = newdat$y+1.96*sqrt(pvar1)
  , tlo = newdat$y-1.96*sqrt(tvar1)
  , thi = newdat$y+1.96*sqrt(tvar1)
)

#second version with bootMer
#we have to define a function that will be applied to the nsim simulations
#here we basically get a merMod object and return the fitted values
predFun<-function(.) mm%*%fixef(.) 
bb<-bootMer(m,FUN=predFun,nsim=200) #do this 200 times
#as we did this 200 times the 95% CI will be bordered by the 5th and 195th value
bb_se<-apply(bb$t,2,function(x) x[order(x)][c(5,195)])
newdat$blo<-bb_se[1,]
newdat$bhi<-bb_se[2,]

plot(y~x,data)
lines(newdat$x,newdat$y,col="red",lty=2,lwd=3)
lines(newdat$x,newdat$plo,col="blue",lty=2,lwd=2)
lines(newdat$x,newdat$phi,col="blue",lty=2,lwd=2)
lines(newdat$x,newdat$tlo,col="orange",lty=2,lwd=2)
lines(newdat$x,newdat$thi,col="orange",lty=2,lwd=2)
lines(newdat$x,newdat$bhi,col="darkgreen",lty=2,lwd=2)
lines(newdat$x,newdat$blo,col="darkgreen",lty=2,lwd=2)
legend("topleft",legend=c("Fitted line","Confidence interval","Prediction interval","Bootstrapped CI"),col=c("red","blue","orange","darkgreen"),lty=2,lwd=2,bty="n")

[/code]

[![bootGLMM1](https://biologyforfun.files.wordpress.com/2015/06/bootglmm1.png)](https://biologyforfun.files.wordpress.com/2015/06/bootglmm1.png)

This looks pretty familiar, the prediction interval being always bigger than the confidence interval.
Now in the help page for the predict.merMod function the authors of the lme4 package wrote that bootMer should be the prefered method to derive confidence intervals from GLMM. The idea there is to simulate N times new data from the model and get some statistic of interest. In our case we are interested in deriving the bootstrapped fitted values to get confidence interval for the regression line. bb$t is a matrix with the observation in the column and the different bootstrapped samples in the rows. To get the 95% CI for the fitted line we then need to get the [0.025*N,0.975*N] values of the sorted bootstrapped values.

The bootstrapped CI falls pretty close to the "normal" CI, even if for each bootstrapped sample new random effect values were calculated (because use.u=FALSE per default in bootMer)

Now let's turn to a more complex example, a Poisson GLMM with two crossed random effects:

[code language="r"]

#second case more complex design with two crossed RE and a poisson response
x<-runif(100,0,10)
f1<-gl(n = 10,k = 10)
f2<-as.factor(rep(1:10,10))
data<-data.frame(x=x,f1=f1,f2=f2)
modmat<-model.matrix(~x,data)

fixed<-c(-0.12,0.35)
rnd1<-rnorm(10,0,0.7)
rnd2<-rnorm(10,0,0.2)

mus<-modmat%*%fixed+rnd1[f1]+rnd2[f2]
data$y<-rpois(100,exp(mus))

m<-glmer(y~x+(1|f1)+(1|f2),data,family="poisson")

#for GLMMs we have to back-transform the prediction after adding/removing the SE
newdat<-data.frame(x=seq(0,10,length=20))
mm<-model.matrix(~x,newdat)
y<-mm%*%fixef(m)
pvar1 <- diag(mm %*% tcrossprod(vcov(m),mm))
tvar1 <- pvar1+VarCorr(m)$f1[1]+VarCorr(m)$f2[1]  ## must be adapted for more complex models
newdat <- data.frame(
  x=newdat$x,
  y=exp(y),
   plo = exp(y-1.96*sqrt(pvar1))
  , phi = exp(y+1.96*sqrt(pvar1))
  , tlo = exp(y-1.96*sqrt(tvar1))
  , thi = exp(y+1.96*sqrt(tvar1))
)

#second version with bootMer
predFun<-function(.) exp(mm%*%fixef(.)) 
bb<-bootMer(m,FUN=predFun,nsim=200)
bb_se<-apply(bb$t,2,function(x) x[order(x)][c(5,195)])
newdat$blo<-bb_se[1,]
newdat$bhi<-bb_se[2,]

#plot
plot(y~x,data)
lines(newdat$x,newdat$y,col="red",lty=2,lwd=3)
lines(newdat$x,newdat$plo,col="blue",lty=2,lwd=2)
lines(newdat$x,newdat$phi,col="blue",lty=2,lwd=2)
lines(newdat$x,newdat$tlo,col="orange",lty=2,lwd=2)
lines(newdat$x,newdat$thi,col="orange",lty=2,lwd=2)
lines(newdat$x,newdat$bhi,col="darkgreen",lty=2,lwd=2)
lines(newdat$x,newdat$blo,col="darkgreen",lty=2,lwd=2)
legend("topleft",legend=c("Fitted line","Confidence interval","Prediction interval","Bootstrapped CI"),col=c("red","blue","orange","darkgreen"),lty=2,lwd=2,bty="n")

[/code]

[![bootGLMM2](https://biologyforfun.files.wordpress.com/2015/06/bootglmm2.png)](https://biologyforfun.files.wordpress.com/2015/06/bootglmm2.png)

Again in this case the bootstrapped CI falled pretty close to the "normal" CI. We have here seen three different way to derive intervals representing the uncertainty around the regression lines (CI) and the response points (PI). Choosing among them would depend on what you want to see (what is the level of uncertainty around my fitted line vs if I sample new observations which value will they take), but also for complex model on computing power, as bootMer can take some time to run for GLMM with many observations and complex model structure.
