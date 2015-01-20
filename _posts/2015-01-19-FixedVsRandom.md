---
title: "Fixed Vs Random Effects In Statistical Modelling"
author: "Peter von Rohr"
date: "19 Jan 2015"
layout: post
comments: True
output: 
  html_document:
     theme: united
---

## What is the point?
Statistical modelling in a frequentist setting usually implies the distinction of the effects included in a certain model into either fixed effects or random effects. Naturally the question arises on how effects are separated into fixed and random, i.e., what are the definitions of fixed and random effects and based on that what are the criteria for assigning the labels fixed or random to any given effect.

## My naïve answer
When getting asked the question on what are fixed or random effects, I ususally anser very naïvely in the following way. I learned that whenever a grouping factor is repeatable and all levels of a factor that are present in a population can be observed, the factor is determined to be a fixed effect. Examples are drug dosage in medical trials or gender effects in surveys. For random effects one typically only observes some samples out of a population like in incomplete block designs or split-plot experiments or in some models random effects are completely unobservable such as genetic effects in animal breeding models. 

With respect to parameter estimation, levels of fixed effects are typically estimated using least squares and for random effects some unbiased prediction methods are used. 

## Surprise, surprise
What I did not realize so far and what makes my above answer very naïve is the fact that the statistical community has not agreed on a unified definition on what fixed and random effects are, yet. A nice outline of the conceptual discrepancies of fixed and random effects is given on [Andrew Gelman's blog](http://andrewgelman.com/2005/01/25/why_i_dont_use/) and in a paper that is referenced on the blog post. Here are the five definitions of fixed and random effects given on Gelman's blog. 

> 1. Fixed effects are constant accross individuals and random effects vary. 

> 2. Effects are fixed if they are interesting in themselves or random if there is interest in the underlying population

> 3. When a sample exhausts the population, the corresponding variable is fixed; when the sample is a small part of the population the corresponding variable is random

> 4. If an effect is assumed to be a realized value of a random variable, it is called a random effect. 

> 5. Fixed effects are estimated using least squares or more generally maximum likelihood. Random effects are estimated using shrinkage ("linear unbiased prediction"). This definition is standard in multilevel modelling and econometrics.

### Definitions are different
Gelman also comments on the differences of the above definitions. The first definition stands apart from the other four. Under the second definition,  the assignment of fixed and random effects can change depending on what is of interest in a study. The third definition relates fixed and random effects to a finite population while the fourth makes not reference to any population at all. The second definition allows fixed effects to come from a distribution, as long as that distribution is not of any interest. The fourth and fifth definitions do not use and distribution for inference about fixed effects. The fifth definition has the virue of mathematical precision, but it does not determine when an effect is fixed and when it is random.


## Want Some More Definitions ...
... here they come. What I have learned from researchers applying statistical models is yet another definition. 

> I have this huge data set with these many effects and my statistics program cannot handle this many effects and levels so I have to treat them as random effects. 

With the advent of big data and with genomics in particular, researchers are often forced to the following 

> I have more parameters than observations, hence I cannot treat them as fixed effects, but I am forced to model them as random.


## Summary and Side Note
The above shows that none of the definitions clearly determine when a modelling effect should be treated as fixed and when as random. Furthermore a given effect would be assigned to be fixed under certain definitions and random based on other definitions. 

Classification of modelling effects into fixed and random is clearly a frequentist concept. The above outline and the absence of clear-cut and unified definitions gives raise to a lot of critisism of frequentist modelling concepts. 

From a Bayesian perspective, the only relevant distinction is that between observable and non-observable quantities. Inferences on non-observable quantities are always based on posterior distributions of non-observables given observables. The definition of what is observable and not observable seams to leave much less room for interpretation of what we have just seen for the definition of fixed and random effects.  