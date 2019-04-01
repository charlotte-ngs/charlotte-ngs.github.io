---
layout: post
title:  High-Volume Scatterplots
published: true
tags: [graphics R ggplot2]
---

High-volume scatterplot are scatterplot created from large datasets where large means more than $10^6$ points. Such plots can be used for monitoring outliers and for comparing shapes of data clouds created from different datasets. These high-volume scatterplots are best viewed via raster-based devices. In R the devices `png()` and `jpeg()` are raster-based. Both devices require R to be compiled against `X11`-support. On machines without the required `X11`-libraries, R can only be compiled without `X11`-support (using `--without-x11`). Using vector-based devices (such as `pdf`) for high volume-scatterplots leads to very large files when saving the plots to files.

The aim of this post is to investigate different alternatives to `png()` and `jpeg()` for creating high-volume scatter plot. See [here](https://charlotte-ngs.github.io/high_volume_scatterplot/20190115_high_volume_scatterplots.nb.html) for some preliminary results.

