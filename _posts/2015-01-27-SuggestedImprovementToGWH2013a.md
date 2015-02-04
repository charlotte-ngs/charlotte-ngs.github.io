---
title: "Suggested Improvements to Genome-Wide Association Studies and Genomic Prediction"
author: "Peter von Rohr"
date: "Tuesday, January 27, 2015"
layout: post
comments: True
output: 
  html_document:
     theme: united
references:
- URL: http://www.springer.com/life+sciences/systems+biology+and+bioinformatics/book/978-1-62703-446-3
  author:
  - family: Gondro
    given: Cedric
  - family: van der Werf
    given: Julius
  - family: Hayes
    given: Ben
  id: GWH2013a
  issued:
    year: 2013
  title: Genome-Wide Association Studies and Genomic Prediction
---

In Chapter 1 of ([@GWH2013a]; yet another green book) the authors Gondro, Porto-Neto and Lee very nicely outline the potential use of R for Genome Wide Association Studies (GWAS). In eight sections they cover topics from "Reading Data Into R" over "Loops and Vectorization", "Byte-Code Compilation", "Memory Management", "Parallel Computation" to "Running Software from R"which explains how to run stand-alone software programs which are independent of R from inside the R interpreter. This first book chapter starts with an "Introduction" and closes with a "Notes" section.

The introduction describes some aspects of R and gives pointers to resources which are valuable to users. Readers who are new to R are advised to first read an introductory text on R. Neither the system nor the language are introduced in this first chapter of the book. All the material presented in Chapter 1 of [@GWH2013a] requires an intermediate to advanced level of R-programming. 

Personally I believe the authors of this first chapter of [@GWH2013a] are missing on some important properties of R which to me and probably also to some other users seam to be very important. Let me just mention two of these properties which make me use R over any other system.

1. Fast protoyping
Fast prototyping means that one can turn ideas very quickly into results. Hence the overhead between having an idea and coming up with a prototype program that produces the first results is very short in R. 

2. Reproducible research
In principle, the term reproducible research is almost a pleonasm like a round circle, because research should always be reproducible. But the term as it stands here has a more specific meaning. Reproducible research in the context of computational sciences means that algorithms and programs are explained in a natural language which is interspersed with statements from a programming language implementing the described algorithm. This approach is implemented using a technique called "literate programming". 

In a [companion post](http://charlotte-ngs.github.io/ImpGWH2013a/notes/ImpGWH2013a.html), I am trying to summarize the first chapter of GWH2013a using a literate programming approach. 


## References
[@GWH2013a] Gondro C, van der Werf J and Hayes B (2013). Genome-Wide Association Studies and Genomic Prediction. [Springer](http://www.springer.com/life+sciences/systems+biology+and+bioinformatics/book/978-1-62703-446-3)