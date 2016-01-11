---
title: "Create Excel Spreadsheets Using R"
author: "Peter von Rohr"
date: "3 January 2016"
layout: post
comments: True
output: 
  html_document:
     theme: united
---

In the era of big data, people are more and more looking beyond the scope of what can be done with MS Excel. __Love__ it or __hate__ it, fact is that most data is still gathered, processed, analyzed and visualized using MS Excel. R provides a flexible framework that offers functionality that goes far beyond the possibilities that are available in Excel. 

### The need for good interfaces
The fact that most data are still stored in Excel combined with the desire to use a flexible framework for analyzing the available data creates the need for good interfaces between R and Excel. A [post](http://www.r-bloggers.com/r-the-excel-connection/) on [Rbloggers](http://www.r-bloggers.com) has compared four packages that are available to interface between Excel and R. 

### Why on earth would you want to bother
For most people who do not have a computational background and do not what to overcome that initial learning curve of getting into the framework of R, use Excel as their only tool to work with data. We have a project in which one of our clients wants to further process and analyze the results of a statistical analysis. The statistical analysis is partly done in R and as a consequence all results are available as dataframes in R.

### The old days
A few years back, the only way to transfer results from R to Excel would be to write the results into a csv-file and then read that file into Excel. While this is possible and worked for most cases, there are some nasty pitfalls with default assignment of cell formats in Excel. Nowadays we are lucky to have R-packages that provide more robust interfaces that take care of transering data from R into Excel. 

### This post
This post has a closer look of two of the four packages that were used in the above mentioned comparison. Those packages are 

1. `xlsx`
2. `openxlsx`

The focus of this post is clearly on the very specific task of having some results available in R as a dataframe and wanting to transfer these results into an Excel spreadsheet. Once the results are transfered, some formatting of rows and columns should be applied. We do not look at how well the inverse transfer of reading data from Excel into R works with the mentioned packages. Readers who are interestined in that type of data transfer will certainly find many useful sources by doing the obvious search on the web. 

## Summary
The above two packages are both great when it comes to transfering data from R into Excel. The first package `xlsx` depends on the R-package `rJava` which is not a problem, at least on Win 7/64. I am still having troubles to get the whole story to fly on my Mac (OS X El Capitan, version 10.11.2).  

If you are still interested to see in who the mentioned packages solve our particular problem, please [read on](http://charlotte-ngs.github.io/RPackageXLSXHowTo/HowToForRPackageXLSX.html) ...

