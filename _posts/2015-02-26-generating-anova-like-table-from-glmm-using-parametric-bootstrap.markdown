---
title: Generating ANOVA-like table from GLMM using parametric bootstrap
wordpress_id: 418
categories:
- R and Stat
tags:
- bootstrap
- GLMM
- R
---

[UPDATE: I modified a bit the code of the function, now you do not need to pass as character the random effect terms]

[UPDATE 2: I added some lines to pass glmer.nb models to the functions, be aware that passing such models to the function will take quite some computing time]

This article may also be found on RPubs: http://rpubs.com/hughes/63269

In the list of worst to best way to test for effect in GLMM the list on http://glmm.wikidot.com/faq state that parametric bootstrapping is among the best options. PBmodcomp in the pbkrtest package implement such parametric bootstrapping by comparing a full model to a null one. The function simulate data (the response vector) from the null model then fit these data to the null and full model and derive a likelihood ratio test for each of the simulated data. Then we can compare the observed likelihood ratio test to the null distribution generated from the many simulation and derive a p-value. The advantage of using such a method over the classical p-values derived from a chi-square test on the likelihood ratio test is that in the parametric bootstrap we do not assume any null distribution (like chi-square) but instead derive our own null distribution from the model and the data at hand. We do not make the assumption then that the likelihood ratio test statistic is chi-square distributed. I have made a little function that wraps around the PBmodcomp function to compute bootstrapped p-values for each term in a model by sequentially adding them. This lead to anova-like table that are typically obtained when one use the command anova on a glm object.

[code language="r"]
#the libraries used
library(lme4)
library(arm)
library(pbkrtest)
#the function with the following arguments
#@model the merMod model fitted by lmer or glmer
#@w the weights used in a binomial fit
#@seed you can set a seed to find back the same results after bootstrapping
#@nsim the number of bootstrapped simulation, if set to 0 return the Chisq p-value from the LRT test
#@fixed should the variable be dropped based on the order given in the model (TRUE) or the the dropping goes from worst to best variable (FALSE)
anova_merMod<-function(model,w=FALSE,seed=round(runif(1,0,100),0),nsim=0,fixed=TRUE){
  require(pbkrtest)
  data<-model@frame
  if(w){
    weight<-data[,which(names(data)=="(weights)")]
    data<-data[,-which(names(data)=="(weights)")]
  }
  f<-formula(model)
  resp<-as.character(f)[2]
  rand<-lme4:::findbars(f)
  rand<-lapply(rand,function(x) as.character(x))
  rand<-lapply(rand,function(x) paste("(",x[2],x[1],x[3],")",sep=" "))
  rand<-paste(rand,collapse=" + ")
  
  #generate a list of reduced model formula
  fs<-list()
  fs[[1]]<-as.formula(paste(resp,"~ 1 +",rand))
  nb_terms<-length(attr(terms(model),"term.labels"))
  if(nb_terms>1){
    #the next two line will make that the terms in the formula will add first the most important term, and the least important one at the end 
    #going first through the interactions and then through the main effects
    mat<-data.frame(term=attr(terms(model),"term.labels"),SSQ=anova(model)[,3],stringsAsFactors = FALSE)
    mat_inter<-mat[grep(":",mat$term),]
    mat_main<-mat[!rownames(mat)%in%rownames(mat_inter),]
    if(!fixed){
      mat_main<-mat_main[do.call(order,list(-mat_main$SSQ)),]
      mat_inter<-mat_inter[do.call(order,list(-mat_inter$SSQ)),]
      mat<-rbind(mat_main,mat_inter)
    }   
    for(i in 1:nb_terms){
      tmp<-c(mat[1:i,1],rand)
      fs[[i+1]]<-reformulate(tmp,response=resp)
    }      
  }
  else{
    mat<-data.frame(term=attr(terms(model),"term.labels"),stringsAsFactors = FALSE)
  }

  #fit the reduced model to the data

  
  fam<-family(model)[1]$family
  
  if(fam=="gaussian"){
    m_fit<-lapply(fs,function(x) lmer(x,data,REML=FALSE))
  }
  else if(fam=="binomial"){
    m_fit<-lapply(fs,function(x) glmer(x,data,family=fam,weights=weight))
  }
  else if("Negative Binomial" %in% substr(fam,1,17)){
    m_fit<-lapply(fs,function(x) glmer.nb(x,data))
  }
  else{
    m_fit<-lapply(fs,function(x) glmer(x,data,family=fam))
  }

  if(nb_terms==1){
    if(fam=="gaussian"){
      m_fit[[2]]<-lmer(formula(model),data,REML=FALSE)
    }
    else if(fam=="binomial"){
      m_fit[[2]]<-glmer(formula(model),data,family=fam,weights=weight)
    }
    else if("Negative Binomial" %in% substr(fam,1,17)){
      m_fit[[2]]<-glmer.nb(formula(model),data)
    }
    else{
      m_fit[[2]]<-glmer(formula(model),data,family=fam)
    }
  }
  #compare nested model with one another and get LRT values (ie increase in the likelihood of the models as parameters are added)
  tab_out<-NULL
  
  for(i in 1:(length(m_fit)-1)){
    if(nsim>0){
      comp<-PBmodcomp(m_fit[[i+1]],m_fit[[i]],seed=seed,nsim=nsim)    
      term_added<-mat[i,1]
      #here are reported the bootstrapped p-values, ie not assuming any parametric distribution like chi-square to the LRT values generated under the null model
      #these p-values represent the number of time the simulated LRT value (under null model) are larger than the observe one
      tmp<-data.frame(term=term_added,LRT=comp$test$stat[1],p_value=comp$test$p.value[2])
      tab_out<-rbind(tab_out,tmp)
      print(paste("Variable ",term_added," tested",sep=""))
    }
    else{
      comp<-anova(m_fit[[i+1]],m_fit[[i]])
      term_added<-mat[i,1]
      tmp<-data.frame(term=term_added,LRT=comp[2,6],p_value=comp[2,8])
      tab_out<-rbind(tab_out,tmp)
    }
    
  }  
  print(paste("Seed set to:",seed))
  return(tab_out)  
}
[/code]

You pass your GLMM model to the function together with the random part as character (see example below), if you fitted a binomial GLMM you also need to provide the weights as a vector, you can then set a seed and the last argument is the number of simulation to do, it is set by default to 50 for rapid checking purpose but if you want to report these results larger values (ie 1000, 10000) should be used.

Let's look at a simple LMM example:

[code language="r"]
data(grouseticks)
m<-lmer(TICKS~cHEIGHT+YEAR+(1|BROOD),grouseticks)
summary(m)
## Linear mixed model fit by REML ['lmerMod']
## Formula: TICKS ~ cHEIGHT + YEAR + (1 | BROOD)
##    Data: grouseticks
## 
## REML criterion at convergence: 2755
## 
## Scaled residuals: 
##    Min     1Q Median     3Q    Max 
## -3.406 -0.246 -0.036  0.146  5.807 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  BROOD    (Intercept) 87.3     9.34    
##  Residual             28.1     5.30    
## Number of obs: 403, groups:  BROOD, 118
## 
## Fixed effects:
##             Estimate Std. Error t value
## (Intercept)   5.4947     1.6238    3.38
## cHEIGHT      -0.1045     0.0264   -3.95
## YEAR96        4.1910     2.2424    1.87
## YEAR97       -4.3304     2.2708   -1.91
## 
## Correlation of Fixed Effects:
##         (Intr) cHEIGH YEAR96
## cHEIGHT -0.091              
## YEAR96  -0.726  0.088       
## YEAR97  -0.714  0.052  0.518
anova_merMod(model=m,nsim=100)
## [1] "Variable cHEIGHT tested"
## [1] "Variable YEAR tested"
## [1] "Seed set to: 23"
##     term      LRT    p_value
## 1 cHEIGHT 14.55054 0.00990099
## 2    YEAR 14.40440 0.00990099
[/code]

The resulting table show for each term in the model the likelihood ratio test, which is basically the decrease in deviance when going from the null to the full model and the p value, you may look at the PBtest line in the details of ?PBmodcomp to see how it is computed.

Now let's see how to use the function with binomial GLMM:

[code language="r"]
#simulate some binomial data
x1<-runif(100,-2,2)
x2<-runif(100,-2,2)
group<-gl(n = 20,k = 5)
rnd.eff<-rnorm(20,mean=0,sd=1.5)
p<-1+0.5*x1-2*x2+rnd.eff[group]+rnorm(100,0,0.3)
y<-rbinom(n = 100,size = 10,prob = invlogit(p))
prop<-y/10
#fit a model
m<-glmer(prop~x1+x2+(1|group),family="binomial",weights = rep(10,100))
summary(m)
## Generalized linear mixed model fit by maximum likelihood (Laplace
##   Approximation) [glmerMod]
##  Family: binomial  ( logit )
## Formula: prop ~ x1 + x2 + (1 | group)
## Weights: rep(10, 100)
## 
##      AIC      BIC   logLik deviance df.resid 
##    288.6    299.1   -140.3    280.6       96 
## 
## Scaled residuals: 
##    Min     1Q Median     3Q    Max 
## -2.334 -0.503  0.181  0.580  2.466 
## 
## Random effects:
##  Groups Name        Variance Std.Dev.
##  group  (Intercept) 1.38     1.18    
## Number of obs: 100, groups:  group, 20
## 
## Fixed effects:
##             Estimate Std. Error z value Pr(&gt;|z|)    
## (Intercept)    0.748      0.287    2.61   0.0092 ** 
## x1             0.524      0.104    5.02  5.3e-07 ***
## x2            -2.083      0.143  -14.56  &lt; 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##    (Intr) x1    
## x1  0.090       
## x2 -0.205 -0.345</code></pre>
#takes some time
anova_merMod(m,w = rep(10,100),nsim=100)</pre>
## [1] "Variable x1 tested"
## [1] "Variable x2 tested"
## [1] "Seed set to: 98"
##   term      LRT p_value
## 1   x1   0.0429 0.80392
## 2   x2 502.0921 0.01961
[/code]

For binomial model, the model must be fitted with proportion data and a vector of weights (ie the number of binomial trial) must be passed to the 'w' argument. Some warning message may pop up at the end of the function, this comes from convergence failure in PBmodcomp, this do not affect the results, you may read the article from the pbkrtest package: http://www.jstatsoft.org/v59/i09/ to understand better where this comes from.

Happy modeling and as Ben Bolker say: "When all else fails, don't forget to keep p-values in perspective: http://www.phdcomics.com/comics/archive.php?comicid=905 "
