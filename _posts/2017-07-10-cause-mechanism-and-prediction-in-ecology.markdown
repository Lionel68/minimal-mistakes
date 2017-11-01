---
title: Cause, mechanism and prediction in ecology
wordpress_id: 2455
categories:
- Biological Stuff
- Opinion Posts
tags:
- causality
- ecology
- prediction
- SEMs
---

This is a theme that bugged me for the past few months, through reading ([Peters' critique for ecology](http://www.cambridge.org/be/academic/subjects/life-sciences/ecology-and-conservation/critique-ecology?format=PB&isbn=9780521395885#xY81DjjF3wmcduGW.97), [Shipley's path analysis book](http://www.cambridge.org/gb/academic/subjects/life-sciences/ecology-and-conservation/cause-and-correlation-biology-users-guide-path-analysis-structural-equations-and-causal-inference-r-2nd-edition?format=PB#EjvYwaiKvmuy31uo.97)), meetings and discussions ([IK computation ecology](https://akcomputationalecology.wordpress.com/2017/07/03/report-from-the-first-ik-computational-ecology-meeting/)). So it is time to actually sit down, think this through and organize my thoughts. What better way to achieve this than to write a post?


## What are causes?


Rather than providing a lengthy definition (which is pretty arduous given that even philosopher do not seem to agree on this), I will follow Shipley's approach to define causal relations using the properties associated to them. So a causal relation implies:

- transitivity: if light cause photosynthesis and photosynthesis cause biomass production then light cause biomass production.

- markov condition: following the example above, if you block photosynthesis from operating and varying, light will not cause biomass production anymore

- irreflexibility: biomass production cannot cause biomass production

- asymmetry: if light cause photosynthesis, photosynthesis cannot cause light.


## What are mechanisms?


Ecologists often justify their research as a quest to unravel the mechanistic relationship between variable X and Y, whether this emphasis is warranted will be discussed later on, for now let's try to understand what we mean usually by "mechanism".

The clearest definition I could come up with is: a mechanism is a set of causal relations that produce from some starting condition(s) one or more effects. Basically every time you try to answer "How?" questions you are going for mechanisms. A mechanistic understanding would be achieved by proving that some data are more likely to emerge following mechanism M than following some other mechanism N. Other definitions abund in the literature for instance in [Cabral et al (2016)](http://onlinelibrary.wiley.com/doi/10.1111/ecog.02480/abstract): "Mechanism - A causal explanation linking two ecological variables" or [Dunham and Beaupre 1998](https://www.researchgate.net/publication/201997244_Ecological_experiments_scale_phenomenology_mechanism_and_the_illusion_of_generality): "an appropriate level of reductionism that provides a causal explanation of the functional relationship among a set of variables". So a research agenda aiming at improving mechanistic understanding will have to deal with causes and how to identify them. On a side note, it is intersting to realize that mechanisms are often developed as narratives (Cabral and Dunham definition use the term "explanation"), this can become an issue if terms are vaguely defined so that multiple causal chains can be built from a single mechanism.

An important point to make here is the potential pitfall of infinite regress when exploring mechanisms. Infinite regress is basically aiming at decomposing a mechanism into a large (infinite) number of causal relations. Taking again the example from above of light causing biomass production: light -> photosynthesis -> biomass production, one can decompose this mechanism further: light -> excitation of photosystem I and II -> ATP production -> calvin cycle -> biomass production and so on. As Shipley nicely puts it: "the trick is always to choose a level of causal complexity that is sufficiently detailed that it meets the goals of the study while remaining applicable in practice", learning this trick may take a whole career time in ecology.


## Why should we care about mechanisms?


Understanding the mechanism (set of causal links) between two variables is assumed to be one step towards generalization and the discovery of the laws of ecology. Many (virtual) ink has been used on whether such generality or laws exist in ecology, I won't go into this here, the interested reader can head to [the paper](http://www.jstor.org/stable/3546712?seq=1#page_scan_tab_contents) that started it all (at least for community ecology), and [some response](http://www.sciencedirect.com/science/article/pii/S0169534706000334) and [ways](https://dynamicecology.wordpress.com/2015/06/17/the-five-roads-to-generality-in-ecology/) to reach generality. The point is, one of the often stated aim of ecology as a science is to unravel general laws and theories to help us better understand the object under scrutiny (see the preface of MacArthur's book [Geographical ecology](http://press.princeton.edu/titles/1502.html)). So if you followed my argumentation, to achieve this broad goal one need to unravel the mechanisms at play and so one will have to work with causality.

Another reason, a bit more applied and coming from the modelling side, is the belief that models based on mechanisms will be better at extrapolating than mechanism-free models. For example if you want to know if a species of tree will be able to grow in a certain area under climatic change with new conditions, models including some physiological or growth mechanisms are assumed to provide better predictions than models based on relations with no explicit mechanistic underlying (see [this](http://onlinelibrary.wiley.com/doi/10.1111/j.1461-0248.2008.01277.x/full) paper).


## How do we identify cause and mechanism in empirical data?


Here I will emphasize three approaches that are used in ecology to derive mechanistic understanding: (i) experiments, (ii) structural equation models and (iii) mechanistic models.

The classical route is to use a reductionist approach and to fragment complex chains of causality into simple components and do manipulative experiments on them. For example say that you want to know if plant growth is caused by light through photosynthesis, and you know that photosynthesis use CO2 and release O2. A simple experiment would be to monitor plant growth under light condition with or without provision of CO2. From your hypothesized mechanism you expect that plant will not grow, despite the light, without CO2 provision. Finding experimental results fitting to particular mechanisms is only the beginning of the road, as one will have to see how it fits back in more complex chains, how it depends on factors that were controlled in the experiment (what about nutrient or water availability in the toy example above), how it depends on species identity (are some plant species not using photosynthesis to grow?) and so on. Again lots of ink has been used to advocate the use of reductionist approach in ecology as appropriate tests of mechanisms and theories, but also on the need to combine detailed and controlled experimental results with broad scale observational data (see the [forum section](https://www.jstor.org/stable/i283128) in this Oikos 1988 volume).

Another, more recent way (in ecology), to explore causal relations is through the use of structural equation models (SEMs). SEMs are a general statistical framework that derive from hypothetical causal networks sets of equations that are fitted to data. Comparing amongst different models allow the researcher to provide evidence towards specific mechanisms and theories. It is still a bit obscure to me how one goes from a set of equations and some variance-covariance to causal understanding but apparently [it works](http://bayes.cs.ucla.edu/BOOK-2K/jw.html).

A final way that I can see is to fit mechanistic models (some call them process-based models) to data. What exactly qualifies as a mechanistic model is a hard [if not irrelevant question](https://theartofmodelling.wordpress.com/2012/02/19/mechanistic-models-what-is-the-value-of-understanding/), the point is that such models are usually parametrize having in mind specific causal relations and are more tightly linked to specific theory than other models. Some example involve: distribution models based on physiological constraints, dynamic vegetation models based on plant growth and respiration. [Some](https://dynamicecology.wordpress.com/2016/01/25/trying-to-understand-ecological-data-without-mechanistic-models-is-a-waste-of-time/) have argued that one cannot achieve understanding (causal relations) without the use of mechanistic models: , [some](https://www.zoology.ubc.ca/~krebs/ecological_rants/hypothesis-testing-using-field-data-and-experiments-is-definitely-not-a-waste-of-time/) have argued otherwise.

The point that one could make is that of a shift of techniques as the understanding on a particular question ("how is light influencing biomass production") is evolving. Experiments backed up with some theory/prediction/expectation are useful pioneers. Structural equation models are a cool way to translate these causal links unraveled by experiments into more complex settings using for instance observational data. Mechanistic models come at a later stage putting down the relations into (dynamic/nonlinear) equations with specific links to the developing theories. The trick is to be able to realize what are the missing information and what would be the most appropriate technique to do so in one's field of research, doing this is tricky as we usually specialize on one set of tools whereas the continuing shift of relevant techniques require some intense cooperation among people. In this regard I particularly like the section "We should clearly identify what kind of science we are doing" in the [Houlahan paper](http://onlinelibrary.wiley.com/doi/10.1111/oik.03726/full) published recently.


## How much emphasis should we put on improving our mechanistic understanding?


As mentioned above one should be wary of infinite regress, trying to explain relationship using more and more detailed informations. At some point one has to realize that for the question at hand enough information about the causes are available, for instance if I want to explore how changes in cloud cover under climate change will affect plant biomass production, do I need to know how the calvin cycle works? These types of questions are pretty hard because they will always be relative on the specific question at hand. Only our scientific common sense, logistic limitations and funding scarcity prevent us from this pitfall.

For me there is a tension in every model that we develop (be it statistical or process-based) between the ability to understand the machinery of causal links leading to some pattern and the predictive ability. Developing models with specific mechanisms will come at the cost of being poorer in terms of predictive abilities than models aimed solely at having high predictive power (see: ti understand or to predict or two culture in statistic). My opinion on this topic is very much affected by my brief incursion into the field of species distribution modeling where the models that perform (currently) the best are complex black-box algorithm massaging hundreds of variables and providing seemingly accurate predictions (but see [this paper on ways](http://onlinelibrary.wiley.com/doi/10.1111/j.1365-2699.2011.02659.x/full) to bridge this gap).

There have been recent calls to make ecology more of a predictive science (see), arguing that for ecology to be taken up by society and policy-maker we should make relevant and accurate predictions. Actually some have argued along these lines for quite some time now (See eg Peters' book).
As argued above and [in a previous post](https://biologyforfun.wordpress.com/2017/01/24/prediction-in-ecology-implementing-a-priority/), there will be some tension when developing models aimed at having high predictive power between understanding (derived from mechanisms, cause and experiment) and prediction. It might well be that the best model in terms of predictive power might not be a super-complex meta-SEM derived from careful experimental work unraveling the mechanisms at play, it might be that a machine learning algorithm fed with millions of data will perfom better. The question for me is what is the niche for causality in a science turned towards prediction?

I'll be happy to hear from you, dear reader, if you have some ideas or some critics regarding this important topic.
