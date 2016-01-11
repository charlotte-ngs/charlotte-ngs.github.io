---
title: "Computation Meets The Cloud"
author: "Peter von Rohr"
date: "7 May 2015"
layout: post
comments: True
output: 
  html_document:
     theme: united
---

This post introduces the potential synergies of computer algebra and cloud computing for data analysis. Recently, there has been a debate on some [blogs](http://www.r-bloggers.com/choosing-r-or-python-for-data-analysis-an-infographic) whether one should choose `R` or `python` for data analysis. Also `Julia` is among the systems that has been advocated by some data analysts. 

In what follows, I might argue to consider the following points:

* In case, data analysis involves the derivation of symbolic formula, it is worth while considering a computer algebra system (CAS). This allows to integrate the formula derivation into a literate programming framework.
* Systems that are available via the cloud such as [SageMathCloud](http://cloud.sagemath.com) (SMC) have the great advantage that they can be used without installing any program. Furthermore, SMC provides additional features such as creating LaTeX documents.


## Terminology
`Computer algebra systems` (CAS) are software programs that are able to manipulate symbolic mathematical formulas. CAS clearly specialize in symbolic computation which sets them apart from the systems that are mainly used for numeric computation such as `Matlab`, `R`, `Julia` and others. 

## History
The development of CAS started in the 1960s. Currently [`Maple`](http://www.maplesoft.com) and [`Mathematica`](http://www.wolfram.com/mathematica/) are the most widely known CAS. The were first released in the 1980s. [Wikipedia](http://en.wikipedia.org/wiki/Computer_algebra_system) gives a nice overview of CAS and their history. 

## Technical Aspects
Traditionally CAS like many other tools are installed as standalone applications on local computers. This imposes high costs of resources on development teams to ensure portability across all different computer platforms.

With the advent of cloud computing where applications do not have to be installed on local computers, but applications can be used through a web interface, this has changed dramatically. Google with their email, calendar and office applications was certainly a driving force in this development. 

[`SageMath`](http://www.sagemath.org) which is a relatively young CAS is going the same route as Google with their office applications. Instead of porting the system to all platforms, the SageMath team came up with a web front end which is called [SageMathCloud](http://cloud.sagemath.com). SMC is like SageMath completely free. All it requires is to sign up for an account. 

## Getting Started With SMC
As soon as one has signed up for an account on SMC, one is ready to sign in and SMC presents the starting page which is initially empty. The screen shot below shows a starting page with already existing projects. 

![SMC start screen](http://charlotte-ngs.github.io/img/2015-05-07-ComputationMeetsTheCloud/smc_start_screen.png) 

When logging in for the first time, the only thing that can be done is creating a new project by hitting the `Create New Project...` button in the middle of the page (see screen shot below). 

![Create New Project Button](http://charlotte-ngs.github.io/img/2015-05-07-ComputationMeetsTheCloud/CreateNewProjectButton.png) 


After clicking the `Create New Project...` button, a popup appears where the user has to specify the name of the new project and its description.

![Create New Project Popup](http://charlotte-ngs.github.io/img/2015-05-07-ComputationMeetsTheCloud/CreateNewProjectPopUp.png) 


Inside a project, one can either create or upload files or one can add collaborators to the project. SMC allows you to create very different types of files. Those types can be a

* Sage worksheet
* Terminal
* Jupyter notebook
* LaTeX document
* Markdown document
* Task List
* Course
* Sage program file
* Phython program
* Folder

Appearently, SMC holds up the old unix tradition that really everything is a file. The above choice of file types are listed when clicking on the `New` button. When clicking on the link in the middle of the project page, an even larger choice of different file types is listed. 


## Worksheets, Notebooks, Program Files and Documents
In the above list of files that can be created inside of a project, there is a group of items which are traditionally understood as files. Those can contain program code and/or text. The format of the content is determined by the type of document that they can be associated to, i.e. a LaTeX document contains text and LaTeX commands or a Python program contains Python code, etc. 

### LaTeX Documents
When creating a LaTeX document the window is devided into two halves where on the left side, one sees the LaTeX code and on the right side, a preview of the document is automatically shown. With that convenient feature, it is easy to verify the resulting document. Whenever there is a problem with compiling the LaTeX code, it is shown when clicking on the `Issues` tab. 

### Sage Worksheets
The Sage worksheets and the Jupyter notebooks are built up by cells where each cell can either contain text or programming statements. These notebooks or worksheets are also known from other systems such as Maple or Mathematica.


## Special Case Files
Terminals and folders are special cases of files. But really on a linux system they are also just files. Behind the scene of SMC, a project is just an account on a linux system. Hence when creating a new file of type `terminal` a shell on a linux system is opened. 


## Teaching With SMC
One of the above file types that can be created on SMC is a `Course`. This creates specialized infrastructure within a project which is helpful when teaching a course to students. In a companion post, these special features of SMC for teaching are going to be described.

