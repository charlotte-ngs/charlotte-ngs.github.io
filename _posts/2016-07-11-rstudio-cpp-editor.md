---
layout: post
title:  RStudio As Cpp IDE
published: true
tags: [c++ IDE RStudio]
---

One of the reasons why R is so popular is that it inferaces seamlessly with other languages. R is very good at rapid prototyping. This quality comes at a price of reduced performance. For applications where performance is important, the parts that are critical with respect to resource usage can be out-sourced to other languages such as C++. 

## Interfaces
The process of out-sourcing parts of a program to a different language works only, if there are good interfaces. One example of a very good interface between R and C++ is the package [Rcpp](http://www.rcpp.org/) which consists of a whole set of application specific sub-interfaces. 


## IDE
Outsourcing parts of a programm to a different language also means to develop in different languages. Different tools have been developed for developing in different languages. There are a number of different tools - so called `Integrated Development Environments` (IDE) which can be used for developing programs in different languages. 

One such IDE is [RStudio](https://www.rstudio.com/) which has gained a lot of popularity in the R community. The following post looks at how easily RStudio can be used to develop in R and in C++. 
Please continue reading [here](http://charlotte-ngs.github.io/RStudioAsCppEditor/RStudioAsCppEditorDevDoc.html)

