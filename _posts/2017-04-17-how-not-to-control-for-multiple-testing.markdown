---
title: How not to control for multiple testing
wordpress_id: 2172
categories:
- Biological Stuff
- R and Stat
tags:
- ecology
- multiple testing
- Statistics
---

While reading the method section of a recent article by [Solivares et al](https://www.nature.com/nature/journal/v536/n7617/full/nature19092.html), I came upon the following paragraph:

"The inclusion of many predictors in statistical models increases the chance of type I error (false positives). To account for this we used a Bernoulli process to detect false discovery rates, where the probability (_P_) of finding a given number of significant predictors (K) just by chance is a proportion of the total number of predictors tested (_N_ = 16 in our case: the abundance and richness of 7 and 9 trophic groups, respectively) and the _P_ value considered significant (_α_ = 0.05 in our case)[39](http://www.nature.com/nature/journal/v536/n7617/full/nature19092.html#ref39), [40](http://www.nature.com/nature/journal/v536/n7617/full/nature19092.html#ref40). The probability of finding three significant predictors on average, as we did, is therefore, _P_ = [16!/(16 − 3)!3!] × 0.053(1 − 0.05)(16 − 3) = 0.0359 [added note from me: 0.053 should actually be: 0.053], indicating that the effects we found are very unlikely to be spurious. The probability of false discovery rates when considering all models and predictors fit (14 ecosystem services × 16 richness and abundance metrics) and the ones that were significant amongst them (52: 25 significant abundance predictors and 27 significant richness predictors) was even lower (_P_ < 0.0001)."

I have never read such an argument before. I am no statistician but I think that the arguments presented by the authors do not account for multiple testing issues. This paragraph is in no way comforting me that the authors took steps to prevent such issues to affect their conclusions. Do note that this post is not a critic of the article in general (even if I would have a couple of things to say) or of the conclusions drawn by the authors.


## What is a Bernoulli process?


A Bernoulli process is when you make a series of trials where each single one of them can have only two outcomes (like success and failures) and you can attribute a probability to each outcome. Flipping a coin is a Bernoulli process, only two outcomes are possible, either the coin lands on heads, either it lands on tails. If the coin is fair the probability of getting a head is 0.5. If you flip the coin n times and assume that the throws are independent between them, we can get the probability of getting k heads (k being an integer between 0 and 10) by using the binomial distribution:

P(X=k) = (n! / (n-k)!k!) * pk * (1-p)n-k

The probability of obtaining 10 heads from 10 flips of a fair coin is:

P(X=10) = (10! / (10-10)!10!) * 0.510 * 0.510-10 = 0.0009, so P < 0.001


## Is multiple testing a Bernoulli process?


It might seem tempting to do so, people often assume that if the p-value is larger than 0.05 then there is no effect (failure) and if the p-value is smaller 0.05 then there is an effect (success). From this rationale we could somehow assume that everything is random, that there are no effects, use the 0.05 threshold as the probability to have a success and see how likely it is to obtain k successes from multiple tests assuming that all p-values are independent. This is wrong. If you feel unsure what exactly are p-values, a nice [starting place is the 2014 forum in Ecology](http://esajournals.onlinelibrary.wiley.com/hub/issue/10.1002/ecy.2014.95.issue-3/).

The core of the arguments from the publication is: “To account for this we used a Bernoulli process to detect false discovery rates, where the probability (_P_) of finding a given number of significant predictors (K) just by chance is a proportion of the total number of predictors tested [...] and the _P_ value considered significant”. No need to invoke a Bernoulli process to detect false discovery, on average 5% of all effects reported significant are wrongly classified. The authors tested (16*14) 224 effects, so at least 11 of the reported significant effect are wrongly classified. In addition, I am unsure what the authors meant with “just by chance”, fitting a specific statistical model does not happen just by chance. I hope that we are doing a bit better in ecology than just assembling random predictors and seeing what affect what. When fitting a series of models, we have developed a rationale for doing so, limiting the amount of tested relationships to the one that fits to our ideas of the world. There is no “just by chance” in detecting a significant effect or not, there are effects that fits with the data at hand and others that do not. So the probabilities reported by the authors are, to my mind, meaningless, they do not account for multiple testing in any way. If I were to test 1 billion relationship and I found 1 million to be significant, what would be the meaning of: P(X=1'000'000) ?


## What could the authors have done?


The issue of multiple testing is not new, there are many ways to try to account for this issue. Simple correction to the threshold used to class effects into significant or non-significant, like the Bonferroni correction or other methods like the Hochberg procedure can be applied. Other methods that try to control the false discovery rates exist and have been advocated by ecologists like in [Verhoven et al](http://onlinelibrary.wiley.com/doi/10.1111/j.0030-1299.2005.13727.x/full) or [Pike et al](http://onlinelibrary.wiley.com/doi/10.1111/j.2041-210X.2010.00061.x/full). So there are plenty of methods out there, no need to invent new ones in a paper like this which is primarily interested in reporting ecological patterns.


## Conclusion


I guess that the authors got asked by one of the reviewers if they were taking into account the issue of multiple testing, and they added this paragraph as a response. I am a bit baffled that the editor and/or the reviewers accepted such argumentation. Anyhow I sincerely hope that it is the first and only time that I will read such argumentation in an ecological paper. To finish, let me re-emphasize that this post is in no way intended to discredit the work of the authors, it is just expressing my concerns over this paragraph that may appeal to others and flourish in the literature.
