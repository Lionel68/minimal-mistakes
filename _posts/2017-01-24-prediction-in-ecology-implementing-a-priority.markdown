---
title: Prediction in ecology -implementing a priority.
wordpress_id: 1615
categories:
- Biological Stuff
- Opinion Posts
tags:
- Ecolog
- ecology
- prediction
- science
---

In this post I would like to comment a bit on the recent forum paper by [Houlahan et al](http://onlinelibrary.wiley.com/doi/10.1111/oik.03726/full) on the importance of prediction to demonstrate ecological understanding. Before going through what I took from the paper I will outline a bit where I stood on prediction and understanding before reading the article.


## Explanation vs Prediction


In my master I spent some time learning and using machine learning algorithms to answer different questions.  Going through the biblio on this wide topic two papers had a large influence on my vision of statistical modeling, the first paper was by Leo Breiman on the [two cultures of statistical modeling](http://projecteuclid.org/euclid.ss/1009213726). There Breiman argue that most of the statisticians approach problems using data models that produces simple and understandable pictures of the relation between predictors and responses. The issue is that simple models do not generally generate accurate predictions especially for complex situations. Breiman therefore argue for statisticians to use a wider range of tools including algorithmic modeling which are more accurate but less interpretable. The second paper was by Galit Shmueli and titled "[To Explain or to Predict](http://projecteuclid.org/euclid.ss/1294167961)". The basic message of the author was that every step in the modelling process, such as variable selection, choice of model algorithm or model selection, will be affected by whether the study aim at explaining or predicting. Therefore if you want to explain some patterns a specific sets of methods can be used to understand the processes acting. On the other hand if the aim is to predict a response under certain conditions then different methods will allow you to make accurate predictions. An important point is that rather than seeing understanding vs prediction as a simple trade-off one should see it rather as a two-dimensional space. Every model will have some explanatory power but also some predictive accuracy. It is the researcher task to set which combination of understanding and predictive power is expected in the project at hand in order to choose appropriate methods. These are the thoughts, more or less formed, that were in the background of my head while reading the Houlahan paper.


## The priority of prediction


The main message I take form the Houlahan paper is that ecologists can claim understanding only if they are able to make quantitative predictions that are verified by data across space and time. They describe an iterative process, close to a Popperian framework, where after acquiring knowledge ecologists would demonstrate their understanding by making "correct and risky predictions". If the predictions are not verified against new data, then new understanding should be acquired. The issue is that there is currently little incentives for ecologists to demonstrate their understanding, the authors outline three reasons for this: (i) institutions by placing a high weight on novelty encourage researcher to spend most of their career on acquiring new knowledge (See [this](https://dynamicecology.wordpress.com/2012/12/10/ecological-forecasting-why-im-a-hypocrite-and-you-may-be-one-too/) post), (ii) ecology is not perceived as a critical science by the public (compared to medicine for example), there is therefore little pressure by the public to push ecologists to demonstrate their understanding of the world and (iii) ecology is complex, everything depends on everything and is potentially context-dependent, therefore if ecologists were to try to demonstrate their understanding there might be some bad surprises (the new book by [Mark Vellend](http://press.princeton.edu/titles/10914.html) address such issue by focusing on high-level processes rather than low-level ones).


## What should we do?


The authors outline 6 ways in which ecology should change if prediction was set as a priority. (i) moving away from qualitative (effect vs no effect) hypotheses towards quantitative ones.  (ii) Identify modeling technique suited for predictions. (iii) assess replicability of ecological patterns across space and time. (iv) estimate measurement errors which put an upper limit to prediction accuracy. (v) extend the concept of power beyond its use in a NullHypothesisSignificanceTesting framework (See [Ben Bolker](https://ms.mcmaster.ca/~bolker/emdbook/book.pdf) take on this, page 217). (vi) be explicit about the type of science done, for example a study might aim at presenting new and unexplained pattern, building on this a subsequent study may investigate the mechanisms driving this pattern.


## Some thoughts:


I like the concept of demonstrating understanding, this would force ecologists to go beyond chasing novelty and spend more efforts on confirming past results, re-using models set by others, testing old theories before proposing new ones ... None of this is new. Yet this paper bring it all in the light of prediction. I am however, a bit unsure as to how such studies should go. As outlined above understanding and prediction calls for different workflow (selecting variables, choice of model algorithm, mode selection ...). So how should we build models if we want to demonstrate our understanding achieved through prediction? I could not find a clear way forward in the article so I am left with speculating how it could go. The first important step for me would be to realize that maximizing absolute predictive accuracy should not be a goal in demonstrating understanding. Models with high predictive ability might be further away from the true model (the goal of understanding efforts) than models with lower predictive validity (See Shmueli paper). Rather predictive ability should be compared amongst models of similar complexity that are tractable, otherwise one might tend towards including many parameters and using more complex algorithms that are not designed to give an understandable vision on the true model. Demonstrating understanding should therefore be achieved by using some of the data modeling culture outlined by Breiman. Second, I would argue that the concept of demonstrating understanding outlined in the paper is a replicability issue using out-of-sample prediction as a metric. Basically something like [this](http://science.sciencemag.org/content/349/6251/aac4716) article but using prediction on new data rather than p-values or effect sizes as metrics. Finally, measurement errors and validity should be taken seriously. As big databases are continuously emerging providing formidable tools to test the generality of our models, one still need to keep in mind that the data should be closely linked to the object under study. Vague concepts like biodiversity have many more or less correlated features making it probable to end up using sub-optimal indicators for the processes under scrutiny (Read [this](http://andrewgelman.com/2015/04/28/whats-important-thing-statistics-thats-not-textbooks/) for more infos).

If you are captivated by this topic make sure to read the series of blog post and their comments on "[Ecologist need to do a better job of prediction](https://dynamicecology.wordpress.com/2013/03/19/ecologists-need-to-do-a-better-job-of-prediction-part-iv-quantifying-prediction-quality/)" by Brian McGill. Let's see how the ecological literature will respond to these pleas to move towards a more predictive focus.
