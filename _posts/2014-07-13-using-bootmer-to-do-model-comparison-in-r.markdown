---
title: Using bootMer to do model comparison in R
wordpress_id: 295
categories:
- R and Stat
tags:
- GLMM
- LRT
- R
---

Setting the right random effect part in mixed effect models can be tricky in many applied situation. I will not talk here about choosing whether a grouping variable (sites, individuals …) should be included as a fixed term or as a random term, please see Gelman and Hill (2006) and Zuur et al (2009) for informations. Here I will present the use of the bootMer function in the package lme4 to compare two models with different random effect terms specification and decide whether one model do a (significantly) better job at fitting the data. The standard way to compare two model is to derive the likelihood ratio test (LRT) value and since these should follow a chi-square distribution derive a p-value corresponding to the probability to observe such an extreme LRT under the null hypothesis that both model perform equally well. This approach works relatively fine for GLM but for (G)LMM several problem arises due mainly to boundary effects (the null hypothesis being in this case that the variance of the random effects is 0) see Bolker et al (2009). One way to do model comparison in (G)LMM is to derive bootstrapped likelihood values from the two competing models and to draw confidence intervals around the observed values to decide if one model perform better than the other. Below are some code with simulated data (a cleaner version with more graphs can be found here: [http://rpubs.com/hughes/22059](http://rpubs.com/hughes/22059)):

`
    
    
    library(lme4)
    library(arm)
    library(RColorBrewer)
    
    ##### work on model comparison using bootMer ##### simulate some data and fit a
    ##### random intercept model to them
    x <- runif(100, 0, 10)
    # the grouping variable
    site <- gl(n = 10, k = 10)
    # the random intercept effect, the simulated standard deviation around the
    # intercept is 1
    rnd <- rnorm(10, 0, 1)
    # the simulated resposne variable, note that the fixed effect coefficient
    # are 1 for the intercept and 3 for the slope. Also the simulated residuals
    # will have a standard deviation of one
    y <- rep(1 + rnd, each = 10) + 3 * x + rnorm(100, 0, 1)
    # fit the model using Maximum Likelihood to be able to use the LRT
    m1 <- lmer(y ~ x + (1 | site), REML = FALSE)
    
    # simulate to generate credible intervals
    simu <- sim(m1, n.sims = 1000)
    # a new model matrix with ordered and equally spaced predictor values
    new.x <- model.matrix(~x, data = data.frame(x = seq(0, 10, length.out = 100)))
    new.y <- matrix(ncol = 1000, nrow = 100)
    # get the predicted response values for each 1000 simulations of the fixed
    # effect model parameters
    new.y <- apply(simu@fixef, 1, function(x) new.x %*% x)
    # compute the lower/upper quantile
    lower <- apply(new.y, 1, function(x) quantile(x, prob = 0.025))
    upper <- apply(new.y, 1, function(x) quantile(x, prob = 0.975))
    median <- apply(new.y, 1, function(x) quantile(x, prob = 0.5))
    
    # nice plot
    pal <- brewer.pal(10, "RdYlBu")
    plot(y ~ x, col = rep(pal, each = 10), pch = 16)
    lines(new.x[, 2], median, col = "blue", lwd = 2)
    lines(new.x[, 2], lower, col = "red", lwd = 2, lty = 2)
    lines(new.x[, 2], upper, col = "red", lwd = 2, lty = 2)
    
    <a href="https://biologyforfun.files.wordpress.com/2014/07/fig11.png"><img src="http://biologyforfun.files.wordpress.com/2014/07/fig11.png" alt="fig1" height="326" class="aligncenter size-full wp-image-298" width="497"></img></a>
    
    # fit a second model with a random slope effect
    m2 <- lmer(y ~ x + (x | site), REML = FALSE)
    
    # using bootMer to compute 100 bootstrapped log-likelihood
    b1 <- bootMer(m1, FUN = function(x) as.numeric(logLik(x)), nsim = 100)
    b2 <- bootMer(m2, FUN = function(x) as.numeric(logLik(x)), nsim = 100)
    
    # the observed LRT value
    lrt <- as.numeric(-2 * logLik(m1) + 2 * logLik(m2))
    # the 100 bootstrapped LRT
    lrt.b <- -2 * b1$t + 2 * b2$t
    # plot
    quant <- quantile(lrt.b, probs = c(0.025, 0.975))
    plot(1, lrt, xlab = "", ylab = "Likelihood ratio test", xaxt = "n", ylim = c(quant[1] + 
        1, quant[2] + 1))
    abline(h = 0, lty = 2, lwd = 2, col = "red")
    segments(1, quant[1], 1, quant[2], lend = 1)
    
    </code>



In the above example the 95% CI of the bootstrapped LRT cross the 0 line which means that one model do not fit the data better than the other. In this case the rule use would be to use the most simple model (the one with the lower number of parameters) which is the random-intercept model.

Let's make another example:

`
    
    
    # now simulate data from random intercept/ slope
    rnd.slope <- rnorm(10, 0, 0.5)
    y <- rep(1 + rnd, each = 10) + rep(3 + rnd.slope, each = 10) * x + rnorm(100, 
        0, 1)
    
    # the new models
    m3 <- lmer(y ~ x + (x | site), REML = FALSE)
    m4 <- lmer(y ~ x + (1 | site), REML = FALSE)
    
    # LRT the observed values
    lrt <- -2 * logLik(m4) + 2 * logLik(m3)
    # the bootstrap
    b3 <- bootMer(m3, FUN = function(x) as.numeric(logLik(x)), nsim = 100)
    b4 <- bootMer(m4, FUN = function(x) as.numeric(logLik(x)), nsim = 100)
    
    # the 100 bootstrapped LRT
    lrt.b <- -2 * b4$t + 2 * b3$t
    
    # the nice plot
    quant <- quantile(lrt.b, probs = c(0.025, 0.975))
    plot(1, lrt, xlab = "", ylab = "Likelihood ratio test", xaxt = "n", ylim = c(0, 
        quant[2] + 1))
    abline(h = 0, lty = 2, lwd = 2, col = "red")
    segments(1, quant[1], 1, quant[2], lend = 1)
    </code>



In this second example the random intercept/slope model fits much better to the data than the random intercept. This random effect structure should be kept. As mentioned in Bolker et al (2009) the LRT will be relevant depending on the design and the interest that is put on the random terms. In the case were random terms are due to the particular design of the study (site, blocks …) and when there are considered as a “nuisance” they may be included in the models without testing for the increase in fitness that their inclusion provide. In the case where the random term effects is of interest (individual sampling units …) then using LRT is a sensible way to detect and interpret the effect of the random terms. The function PBmodcomp in the package pbkrtest allows one to do all the preceding code in just one line with various ways to test for the significance of the likelihood ratio (thanks to Ben Bolker for his comment).

Biblio: 
Bolker, B. M., Brooks, M. E., Clark, C. J., Geange, S. W., Poulsen, J. R., Stevens, M. H. H., & White, J. S. S. (2009). Generalized linear mixed models: a practical guide for ecology and evolution. Trends in ecology & evolution, 24(3), 127-135. 
Gelman, A., & Hill, J. (2006). Data analysis using regression and multilevel/hierarchical models. Cambridge University Press. 
Zuur, A., Ieno, E. N., Walker, N., Saveliev, A. A., & Smith, G. M. (2009). Mixed effects models and extensions in ecology with R. Springer.
