---
title: 'Simulating SEMs: part 2 extensions'
categories:
- Biological Stuff
- R and Stat
tags:
- R
- SEMs
- Simulation
---

Back in May I published a [first post](https://lionel68.github.io/biological%20stuff/r%20and%20stat/simulating-sems-for-piecewisesem-part-1-the-basics/) which simulated simple Structural Equation Models (SEMs) to check the capacity of [piecewieseSEM](http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12512/abstract) to deal with noise. At that time the verdict was pretty bleak: 90% of models were accepted even if they were just fitting noise. Since then I extended the code to include model fitted via another R package for SEMs: [lavaan](https://www.jstatsoft.org/article/view/v048i02) plus three different data generations. Before plunging into the results a few words on the main difference between lavaan and piecewieseSEM.

## lavaan vs piecewieseSEM

The basic idea of lavaan is to take the modelled relations between the variables, derive the expected variance-covariance 

## About the simulations



## Results

The first result is to look at the proportion of accepted models. Typically in lavaan if the p-value for the difference between the fitted and observed variance-covariance matrix is higher than 0.05 the model is accepted. For piecewieseSEM, the Fischer C statistic is computed, if you did not miss out important relations in your model the p-value of the Fischer C statistic will be large, in general models are accepted for p-value of the C statistic larger than 0.05.

![fig1]({{ site.url }}{{ site.baseurl }}/assets/images/sem_1.png)

In this figure the colors represent the different data generation strategy (random, exact or shuffled), the linetype show the model fitting technique (lavaan or piecewieseSEM), the x-axis is the sample size, the different facets the number of variables in the model from 5 to 10 and the y-axis is the proportion of accepted models. The first intersting result is that the number of accepted models is pretty equivalent between the 

![fig1]({{ site.url }}{{ site.baseurl }}/assets/images/sem_2.png)

![fig1]({{ site.url }}{{ site.baseurl }}/assets/images/sem_3.png)

## Conclusion

Some bla bla

## The code

Below is the full code, it is rather lengthy ... Sorry for that.

```r
library(piecewiseSEM)
library(lavaan)
library(dplyr)
library(ggplot2)

# create matrix with X variables with some relations indicated as ones
relation <- function(X=5,C=0.3){
  out <- matrix(0,nrow=X,ncol=X) #fill the matrix with 0s
  lwr <- X*(X-1)/2 #number of cells in the lower triangle of the matris
  nb.edge <- C*X**2 #number of 1s to add to the matrix
  if(nb.edge>lwr){
    stop("C is set too high to create a DAG, reduce it!")
  }
  while(!all(rowSums(out)[-1]!=0)){#while loop to ensure that all variables have at least one relation
    out <- matrix(0,nrow=X,ncol=X)
    out[lower.tri(out)][sample(x=1:lwr,size=nb.edge,replace=FALSE)] <- 1
    diag(out) <- 0 #ensure that no 1s are in the diagonal
  }
  rownames(out)<-paste0("X",1:X)
  return(out)
}

#turn a matrix with 0s and 1s into a series of R formulas
#rows are ys and columns are xs
formula_list <- function(mat){
  vars <- rownames(mat)
  formL <- list()
  for(i in 2:dim(mat)[1]){
    lhs <- vars[i] #the left-hand side of the formula
    rhs <- vars[mat[i,]==1] #the right-hand side of the formula
    if(length(rhs) == 0) { next }
    else{
      formL[[(i-1)]] <- formula(paste0(lhs,"~",paste(rhs,collapse="+")))
    }
  }
  return(formL[!sapply(formL,is.null)])
}

#turn a list of formulas into a list of models
model_list <- function(formL,data,fn=NULL){
  if(is.null(fn)){
    modL <- lapply(formL,function(x) lm(x,data))
  }
  else{
    stop("Not implemented yet") #one could allow the user to give a vector of model types
  }
  return(modL)
}

#create a function to get important infos from a sem object
grab_val <- function(modL,data,lavaan=FALSE){
  if(lavaan){
    lv <- "lavaan"
    semObj <- sem.lavaan(modL,data)
    sigM <-ifelse(!semObj@optim$converged,0,ifelse(semObj@test[[1]]$pvalue>=0.05,1,0)) #get the SEM p-value, giving a value of 0 if the model did not converged
    semCoeff <- parameterestimates(semObj)[grep("^~$",parameterestimates(semObj)$op),] #get the model coefficients
    nbPaths <- nrow(semCoeff)
    nbSigPaths <- length(which(semCoeff$pvalue<=0.05)) #how many significant paths
    avgSigPaths <- mean(abs(semCoeff$est[semCoeff$pvalue<=0.05])) #the average values of significant paths
  }
  else{
    lv <- "pcSEM"
    semObj <- sem.fit(modL,data,.progressBar = FALSE,conditional = TRUE) #evaluate the independence claims
    sigM <-ifelse(semObj$Fisher.C$p.value>=0.05,1,0) #get the SEM p-value
    semCoeff <- sem.coefs(modL,data) #get the model coefficients
    nbPaths <- nrow(semCoeff)
    nbSigPaths <- length(which(semCoeff$p.value<=0.05)) #how many significant paths
    avgSigPaths <- mean(abs(semCoeff$estimate[semCoeff$p.value<=0.05])) #the average values of significant paths
  }
  out <- data.frame(N=nrow(data),X=ncol(data),C=0.3,type=lv,sigM=sigM,nbPaths=nbPaths,nbSigPaths=nbSigPaths,avgSigPaths=avgSigPaths)
  return(out)
}
 
#a function to generate data based on diverse fidelity from the simulated list of models
generate_data <- function(N,X,relL,formL,type,p_shuffle){
  if(type=="random"){
    dat <- as.data.frame(matrix(rnorm(X*N,0,1),ncol=X,dimnames = list(1:N,paste0("X",1:X))))
  }
  else if(type=="exact"){
    dat <- data.frame(X1=runif(N,-2,2))
    for(f in formL){
      allv <- all.vars(f)
      y <- allv[1]
      xs <- dat[,allv[2:length(allv)]]
      xs <- as.matrix(cbind(rep(1,N),xs))
      coeff <- rcauchy(n = ncol(xs),0,2.5)
      dat<-cbind(dat,rnorm(N,xs%*%coeff,1))
      colnames(dat)[ncol(dat)]<-y
      dat <- as.data.frame(apply(dat,2,scale))
    }
  }
  #reverse a certain proportion of the causal relation, such as X1 -> X2 becomes X2 -> X1
  else if(type=="shuffled"){
    relL_m <- relL
    #how many relation to shuffle?
    #default to 0.25
    n_s <- ifelse(ceiling(sum(relL)*p_shuffle)<1,1,ceiling(sum(relL)*p_shuffle))
    #grab cell index to shuffle
    to_s <- sample(which(relL == 1),n_s,replace=FALSE)
    #grab row and column id for these cells
    id_s <- arrayInd(to_s,dim(relL))
    #transpose the 1s up the diagonal
    relL_m[id_s] <- 0
    relL_m[id_s[,c(2,1)]] <- 1
    #add column names
    dimnames(relL_m)[[2]] <- dimnames(relL_m)[[1]]
    if(!is_dag(graph_from_adjacency_matrix(relL_m))){
      while(!is_dag(graph_from_adjacency_matrix(relL_m))){
        #grab cell index to shuffle
        to_s <- sample(which(relL_m == 1),n_s,replace=FALSE)
        #grab row and column id for these cells
        id_s <- arrayInd(to_s,dim(relL))
        #transpose the 1s up the diagonal
        relL_m[id_s] <- 0
        relL_m[id_s[,c(2,1)]] <- 1
        #add column names
        dimnames(relL_m)[[2]] <- dimnames(relL_m)[[1]]
      }
    }
    #sort back the DAG
    od <- topo_sort(graph_from_adjacency_matrix(relL_m),mode="in")
    relL_mo <- relL_m[od,od]
    formL_m <- formula_list(relL_mo)
    #a random vector for the exogenous variable(s) to start of the data creation
    exo <- which(rowSums(relL_mo) == 0)
    dat <- as.data.frame(matrix(runif(N * length(exo),-2,2),ncol=length(exo)))
    names(dat) <- names(exo)
    for(f in 1:length(formL_m)){
      allv <- all.vars(formL_m[[f]])
      y <- allv[1]
      xs <- dat[,allv[2:length(allv)]]
      xs <- as.matrix(cbind(rep(1,N),xs))
      coeff <- rcauchy(n = ncol(xs),0,2.5)
      dat<-cbind(dat,rnorm(N,xs%*%coeff,1))
      colnames(dat)[ncol(dat)]<-y
      dat <- as.data.frame(apply(dat,2,scale))
    }
  }
  else{
    stop("Not implemented yet") #one could create datasets with non-random structure, to be implemented
  }
  return(dat)
}


#put it all in one function to replicate over
sim_sem <- function(N=20,X=5,C=0.3,type="random",p_shuffle = 0.25,lv=FALSE){
  relL <- relation(X=X,C=C)
  formL <- formula_list(relL)
  dat <- generate_data(N,X,relL,formL,type,p_shuffle)
  modL <- model_list(formL,dat)
  out <- grab_val(modL,dat,lavaan=lv)
  return(out)
}


#test over different sample size (N) and number of variables (X) with random data generation
#ie there is no simulated signal in the data
sims <- expand.grid(N=seq(20,100,10),X=5:10,C=0.3,lv=FALSE)
res <- NULL
for(i in 1:54){
  x <- as.numeric(sims[i,])
  tmp <- replicate(100,sim_sem(N = x[1],X=x[2],C=x[3],lv=x[4]))
  out <- as.data.frame(matrix(unlist(tmp),nrow = 100,byrow=TRUE,dimnames=list(1:100,attr(tmp,"dimnames")[[2]])))
  out$Exp <- i
  res <- rbind(res,out)
  print(i)
}
#now same stuff for lavaan
sims$lv<-TRUE
reslv <- NULL
for(i in 1:54){
  x <- as.numeric(sims[i,])
  tmp <- replicate(100,sim_sem(N = x[1],X=x[2],C=x[3],lv=x[4]))
  out <- as.data.frame(matrix(unlist(tmp),nrow = 100,byrow=TRUE,dimnames=list(1:100,attr(tmp,"dimnames")[[2]])))
  out$Exp <- i
  reslv <- rbind(reslv,out)
  print(i)
}
res$type<-"pcsem"
reslv$type<-"lv"
resa<-rbind(res,reslv)

resa%>%
  group_by(Exp,N,X,type)%>%
  summarise(PropSigM=sum(sigM,na.rm=TRUE)/n(),NbPaths = sum(nbPaths),NbSigPaths=sum(nbSigPaths),AvgSigPaths=mean(avgSigPaths,na.rm=TRUE))%>%
  mutate(PropSigPaths=NbSigPaths/NbPaths)->res_dd

#now simulate the exact distribution for the fitted model
sims <- expand.grid(N=seq(20,100,10),X=5:10,C=0.3,lv=FALSE)
res <- NULL
for(i in 1:54){
  x <- as.numeric(sims[i,])
  tmp <- replicate(100,sim_sem(N = x[1],X=x[2],C=x[3],lv=x[4],type="exact"))
  out <- as.data.frame(matrix(unlist(tmp),nrow = 100,byrow=TRUE,dimnames=list(1:100,attr(tmp,"dimnames")[[2]])))
  out$Exp <- i
  res <- rbind(res,out)
  print(i)
}
#now same stuff for lavaan
sims$lv<-TRUE
reslv <- NULL
for(i in 1:54){
  x <- as.numeric(sims[i,])
  tmp <- replicate(100,sim_sem(N = x[1],X=x[2],C=x[3],lv=x[4],type="exact"))
  out <- as.data.frame(matrix(unlist(tmp),nrow = 100,byrow=TRUE,dimnames=list(1:100,attr(tmp,"dimnames")[[2]])))
  out$Exp <- i
  reslv <- rbind(reslv,out)
  print(i)
}
res$type<-"pcsem"
reslv$type<-"lv"
resa<-rbind(res,reslv)
resa%>%
  group_by(Exp,N,X,type)%>%
  summarise(PropSigM=sum(sigM,na.rm=TRUE)/n(),NbPaths = sum(nbPaths),NbSigPaths=sum(nbSigPaths),AvgSigPaths=mean(avgSigPaths,na.rm=TRUE))%>%
  mutate(PropSigPaths=NbSigPaths/NbPaths)->res_dd2

#now simulate with shuffling the causal directions
sims <- expand.grid(N=seq(20,100,10),X=5:10,C=0.3,lv=FALSE)
res <- NULL
for(i in 1:54){
  x <- as.numeric(sims[i,])
  tmp <- replicate(100,sim_sem(N = x[1],X=x[2],C=x[3],lv=x[4],type="shuffled",p_shuffle = 0.25))
  out <- as.data.frame(matrix(unlist(tmp),nrow = 100,byrow=TRUE,dimnames=list(1:100,attr(tmp,"dimnames")[[2]])))
  out$Exp <- i
  res <- rbind(res,out)
  print(i)
}
#now same stuff for lavaan
sims$lv<-TRUE
reslv <- NULL
for(i in 1:54){
  x <- as.numeric(sims[i,])
  tmp <- replicate(100,sim_sem(N = x[1],X=x[2],C=x[3],lv=x[4],type="shuffled",p_shuffle = 0.25))
  out <- as.data.frame(matrix(unlist(tmp),nrow = 100,byrow=TRUE,dimnames=list(1:100,attr(tmp,"dimnames")[[2]])))
  out$Exp <- i
  reslv <- rbind(reslv,out)
  print(i)
}
res$type<-"pcsem"
reslv$type<-"lv"
resa<-rbind(res,reslv)
resa%>%
  group_by(Exp,N,X,type)%>%
  summarise(PropSigM=sum(sigM,na.rm=TRUE)/n(),NbPaths = sum(nbPaths),NbSigPaths=sum(nbSigPaths),AvgSigPaths=mean(avgSigPaths,na.rm=TRUE))%>%
  mutate(PropSigPaths=NbSigPaths/NbPaths)->res_dd3

#make one graph for all
res_all <- rbind(res_dd,res_dd2,res_dd3)
res_all$Data <- rep(c("Random","Exact","Shuffled"),each=108)
res_all$type[res_all$type=="lv"] <- "lavaan"

ggplot(res_all,aes(x=N,y=PropSigM,color=Data,linetype=type))+geom_path()+
  facet_wrap(~X,labeller = label_both) +
  labs(x="Sample size",y="Proportion of accepted models (p > 0.05)",
       title="Proportion of accepted model for different data generation")

ggplot(res_all,aes(x=N,y=PropSigPaths,color=Data,linetype=type))+geom_path()+
  facet_wrap(~X,labeller = label_both) +
  labs(x="Sample size",y="Proportion of significant paths (p < 0.05)",
       title="Proportion of significant paths for different data generation")

ggplot(res_all,aes(x=N,y=AvgSigPaths,color=Data,linetype=type))+geom_path()+
  facet_wrap(~X,labeller = label_both) +
  labs(x="Sample size",y="Average coefficient of significant paths (p < 0.05)",
       title="Average coefficient value for different data generation")
```
