---
title: Exploration of Functional Diversity indices using Shiny
wordpress_id: 438
categories:
- Biological Stuff
- R and Stat
tags:
- ecology
- FD
- R
---

Biological diversity (or biodiversity) is a complex concept with many different aspects in it, like species richness, evenness or functional redundancy. My field of research focus on understanding the effect of changing plant diversity on higher trophic levels communities but also ecosystem function. Even if the founding papers of this area of research already hypothesized that all components of biodiversity could influence ecosystem function (See [Fig1 in Chapin et al 2000](http://www.nature.com/nature/journal/v405/n6783/fig_tab/405234a0_F1.html)), the first experimental results were focusing on taxonomic diversity (ie species richness, shannon diversity, shannon evenness ...). More recently the importance of functional diversity as the main driver of changes in ecosystem function has been emphasized by several authors (ie [Reiss et al 2009](http://www.sciencedirect.com/science/article/pii/S0169534709001803)). The idea behind functional diversity is basically to measure a characteristic (the traits) of the organisms under study, for example the height of a plant or the body mass of an insect, and then derive an index of how diverse these traits values are in a particular sites. A nice introduction into the topic is the [Chapter from Evan Weiher in Biological Diversity](http://ukcatalogue.oup.com/product/9780199580675.do). 

Now as taxonomic diversity has many different indices so do functional diversity, recent developments of [a new multidimensional framework](http://www.esajournals.org/doi/full/10.1890/07-1206.1) and of an [R package](http://cran.r-project.org/web/packages/FD/index.html) allow researchers to easily derive functional diversity index from their dataset. But finding the right index for his system can be rather daunting and as several studies showed there is not a single best index (See Weiher Ch.13 in Biological Diversity) but rather a set of different index each showing a different facet of the functional diversity like functional richness, functional evenness or functional divergence. 

Here I show a little Shiny App to graphically explore in a 2D trait dimension the meaning of a set of functional diversity indices. The App is still in its infancy and many things could be added (ie variation in trait distribution ...) but here it is:


    
    
    #load libraries
    library(shiny)
    library(MASS)
    library(geometry)
    library(plotrix)
    library(FD)
    
    #launch App
    runGitHub("JenaExp",username = "Lionel68",subdir = "FD/Shiny_20150426")
    



All codes are available here: https://github.com/Lionel68/JenaExp/tree/master/FD

Literature:

Chapin III, F. Stuart, et al. "Consequences of changing biodiversity." Nature 405.6783 (2000): 234-242.

Reiss, Julia, et al. "Emerging horizons in biodiversity and ecosystem functioning research." Trends in ecology & evolution 24.9 (2009): 505-514.

Weiher, E. "A primer of trait and functional diversity." Biological diversity, frontiers in measurement and assessment (2011): 175-193.

Villéger, Sébastien, Norman WH Mason, and David Mouillot. "New multidimensional functional diversity indices for a multifaceted framework in functional ecology." Ecology 89.8 (2008): 2290-2301.









