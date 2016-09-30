---
layout: post
title:  Reading Binary Data By Chunks In R
published: true
tags: [big data R]
---

In an earlier [posts](http://charlotte-ngs.github.io/rgrm/rgrmhelperfunctions.html) I showed some functions to work with symmetric matrices that are read from binary files using R's `readBin()` function. The approach taken in the first post was very much like the traditional way of how data analysis used to be done in the old days. Let us term it the three-step-approach. This consisted of the following three steps

1. Read in all the data into memory
2. Do some computationen and / or analyses
3. Output and / or plot the results

In the era of big data, sizes of data sets grow exponentially. At the same time your hardware is limited and maybe it grows linearly, but sooner or later, the data sets to be analysed are too large to fit into memory. At that point it is time to think over the old three-step approach of data analysis. Ideas like online algorithms which process only chunks of data at a time can be a solution.

In a companion post, I describe an idea for an improved solution to the problem of working with very large matrices. If you are still interested, please continue reading [here](https://charlotte-ngs.github.io/ReadBinFileByChunk/readbinfilebychunk.html)

