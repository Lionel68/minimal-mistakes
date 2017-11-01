---
title: Simulating dice throws in R
wordpress_id: 202
categories:
- R and Stat
tags:
- Probability
- R
---

I am currently following a course on probability theory in coursera ([https://www.coursera.org/course/probas](https://www.coursera.org/course/probas)) and I've seen some graphs concerning the outcome of some dice throws. Being an R-nerd I wrote a little function to do this in R. This is nothing fancy just I find it interesting the process of thoughts going from a real-world problem (100 throws of two dice) to some code and graphs (histogramms of the empirical and theoretical results of the sum of the two dice).

Here is the problem: We throw two six-faced fair dice a certain number of times and we compute the sum of their values, we want to compare the theoretical expectations with empirical ones as we are varying the number of times dice are thrown.

The code can be found here: [http://rpubs.com/Lionel/11497](http://rpubs.com/Lionel/11497)

And just as a teaser here is one of the figure we can get from it

[![dice](http://biologyforfun.files.wordpress.com/2013/12/dice.png?w=300)](http://biologyforfun.files.wordpress.com/2013/12/dice.png)
