---
title: "Introduction To Dplyr"
author: "Peter von Rohr"
date: "22 Oct 2014"
layout: post
comments: True
output: 
  html_document:
     theme: united
---

## Before dplyr
The R-package `dplyr` represents an important milestone in the history of R. Before `dplyr` existed, data manipulation was not considered to be a strong point of the R system. I even remember very vaguely that even John Chambers was advocating in one of his talks many years ago, that data preparation is better done by some scripting language, like python or perl.

## What is it all about
`dplyr` can be understood as a language of data manipulation. The language consists only of a small number of verbs each designed to perform a well defined task. Each of the verbs is implemented in an R function. Data manipulation processes can be constructed by chaining together sequences of verbs to a pipeline.

## Getting started
[Introductory slides](http://charlotte-ngs.github.io/dplyrIntro) show the basic usage of `dplyr` using Andersons Iris data set.

The `dplyr` package is available through CRAN, hence `dplyr` can be installed via

```r
install.packages("dplyr")
```

The introductory vignette to `dplyr` available through


```r
browseVignettes(package = "dplyr")
```

demonstrates the application of `dplyr` to the New York City airport flights dataset.

