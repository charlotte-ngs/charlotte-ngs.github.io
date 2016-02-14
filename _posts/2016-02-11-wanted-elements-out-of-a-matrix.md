---
layout: post
title:  Wanted! - Elements Out Of A Flattened Matrix
published: true
tags: [genetic relationship matrix]
mathjax: "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
---

Given the following problem. Suppose we have a large symmetric matrix of a certain dimension $n$ of which the lower triangular part is stored in a vector. We want to find all row- and column-indices of elements of the original matrix that fullfill a certain property. 

### Background
The genetic relationship matrix (GRM) between $n$ individuals is a symmetric matrix of dimension $n\times n$. Certain software programs that are used to compute the GRM store the lower triangular part of the matrix in a vector. In case we want to know pairs of individuals that have genetic relationship coefficients above a certain threshold, we need to know the row- and column-indices of the original matrix where the coefficients above a certain threshold occur in the original GRM. 

### Small example
Let us try to explain the problem based on a small example. Suppose the GRM between a small number of individuals has the following structure. For the purpose of this blog-post, we create a matrix based on random uniform numbers. Since the diagonals of a GRM are all larger than 1, we add 1 to the diagonal.



{% highlight r %}
set.seed(4321)
nNrInd <- 6
mGrmP <- matrix(runif(n = nNrInd * nNrInd), ncol = nNrInd)
mGrm <- crossprod(mGrmP)/nNrInd
diag(mGrm) <- 1+diag(mGrm)
print(mGrm)
{% endhighlight %}



{% highlight text %}
##           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
## [1,] 1.3759968 0.3467317 0.2801808 0.2441776 0.1192618 0.2616150
## [2,] 0.3467317 1.4614261 0.3586357 0.2385468 0.1402472 0.3813145
## [3,] 0.2801808 0.3586357 1.3017744 0.2064611 0.1386737 0.2711936
## [4,] 0.2441776 0.2385468 0.2064611 1.2571203 0.1146292 0.1705466
## [5,] 0.1192618 0.1402472 0.1386737 0.1146292 1.1433730 0.1460782
## [6,] 0.2616150 0.3813145 0.2711936 0.1705466 0.1460782 1.4259352
{% endhighlight %}

### First flattening the matrix into a vector
The lower triangular part of the above matrix can be stored in a vector as follows. 


{% highlight r %}
vGrmLowTri <- vector(mode = "numeric", length = sum(1:nNrInd))
nVecIdx <- 1
for (nRowIdx in 1:nrow(mGrm)){
  for (nColIdx in 1:nRowIdx){
    vGrmLowTri[nVecIdx] <- mGrm[nRowIdx, nColIdx]
    nVecIdx <- nVecIdx + 1
  }
}
print(vGrmLowTri)
{% endhighlight %}



{% highlight text %}
##  [1] 1.3759968 0.3467317 1.4614261 0.2801808 0.3586357 1.3017744
##  [7] 0.2441776 0.2385468 0.2064611 1.2571203 0.1192618 0.1402472
## [13] 0.1386737 0.1146292 1.1433730 0.2616150 0.3813145 0.2711936
## [19] 0.1705466 0.1460782 1.4259352
{% endhighlight %}

From the above, we can see that the order of the elements is to be taken row-wise, that means, in the outer loop we step through each row of the matrix and inside of each row, the inner loop runs from the first element up until the diagonal element. 

### Alternative to loops
R has internal functions to extract lower and upper triangular elements of a matrix. Those functions are `lower.tri()` and `upper.tri()` as arguments they take the matrix and a boolean flag which indicates whether the diagonal elements should be included or not. 

Since we are interested in the lower triangular of our matrix, it would seam obvious to use the function `lower.tri()`. 


{% highlight r %}
lower.tri(mGrm, diag = TRUE)
{% endhighlight %}



{% highlight text %}
##      [,1]  [,2]  [,3]  [,4]  [,5]  [,6]
## [1,] TRUE FALSE FALSE FALSE FALSE FALSE
## [2,] TRUE  TRUE FALSE FALSE FALSE FALSE
## [3,] TRUE  TRUE  TRUE FALSE FALSE FALSE
## [4,] TRUE  TRUE  TRUE  TRUE FALSE FALSE
## [5,] TRUE  TRUE  TRUE  TRUE  TRUE FALSE
## [6,] TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
{% endhighlight %}

The result of applying the function `lower.tri()` to our matrix is a boolean matrix of the same dimension as the input matrix where all elements of the lower triangular including the diagnal elements are TRUE and all other elements are FALSE. 

Using the boolean matrix as index selector for our original number matrix, flattens the lower triangular elements into a vector but the order is taken row-wise and not column-wise, as what we need for our task.



{% highlight r %}
mGrm[lower.tri(mGrm, diag = TRUE)]
{% endhighlight %}



{% highlight text %}
##  [1] 1.3759968 0.3467317 0.2801808 0.2441776 0.1192618 0.2616150
##  [7] 1.4614261 0.3586357 0.2385468 0.1402472 0.3813145 1.3017744
## [13] 0.2064611 0.1386737 0.2711936 1.2571203 0.1146292 0.1705466
## [19] 1.1433730 0.1460782 1.4259352
{% endhighlight %}

### Saving our idea
Our original numeric matrix is symmetric and hence the elements above the diagonal are the same as below the diagonal. Further more the order of the elements is the same when running through the matrix row-wise below the diagonal as when running through the matrix column-wise above the diagonal. Hence, instead of using `lower.tri()`, we have to use `upper.tri()`. 


{% highlight r %}
mGrm[upper.tri(mGrm, diag = TRUE)]
{% endhighlight %}



{% highlight text %}
##  [1] 1.3759968 0.3467317 1.4614261 0.2801808 0.3586357 1.3017744
##  [7] 0.2441776 0.2385468 0.2064611 1.2571203 0.1192618 0.1402472
## [13] 0.1386737 0.1146292 1.1433730 0.2616150 0.3813145 0.2711936
## [19] 0.1705466 0.1460782 1.4259352
{% endhighlight %}

## Finding a given element in the matrix
Let us assume, we are given the vector produced by the above described flattening of the lower triangular part of our matrix. Furthermore, we want to select some special components in the vector and want to trace back where they occured in the original matrix. That means we want to know the row and the column indices of the special component in the original matrix.

### Diagonal elements
One group of special elements are the diagonal elements of the original matrix. From our process of flattening the lower triangular part of our original matrix into a vector, we can observe that on a given row i, there are exactly i elements from column 1 until the diagonal element of row i. Based on that observation, the number of elements that are stored in the flattened vector up to the diagonal element of row i corresponds to the sum of all natural numbers from 1 up and including i. 

$$ \sum_{j=i}^i j$$

Computing that number for all rows in the matrix we can store all indices of the flattened vector corresponding to diagonal elements as follows. 


{% highlight r %}
vFlatMatElem <- mGrm[upper.tri(mGrm, diag = TRUE)]
vFlatDiagIdx <- cumsum(1:nrow(mGrm))
print(vFlatDiagIdx)
{% endhighlight %}



{% highlight text %}
## [1]  1  3  6 10 15 21
{% endhighlight %}

From that index vector, all diagonal elements can be extracted by 


{% highlight r %}
vFlatMatElem[vFlatDiagIdx]
{% endhighlight %}



{% highlight text %}
## [1] 1.375997 1.461426 1.301774 1.257120 1.143373 1.425935
{% endhighlight %}

Now it is easy to also get all the off-diagonal elements by


{% highlight r %}
vFlatMatElem[-c(vFlatDiagIdx)]
{% endhighlight %}



{% highlight text %}
##  [1] 0.3467317 0.2801808 0.3586357 0.2441776 0.2385468 0.2064611
##  [7] 0.1192618 0.1402472 0.1386737 0.1146292 0.2616150 0.3813145
## [13] 0.2711936 0.1705466 0.1460782
{% endhighlight %}

### A particular element
Let us assume, we are interested in element 12 of the flattened vector. 


{% highlight r %}
vFlatMatElem[12]
{% endhighlight %}



{% highlight text %}
## [1] 0.1402472
{% endhighlight %}

Our goal is on which row and which column did it occur in the original matrix. Our index vector of the diagonal elements already tells us that element 10 is the last element of the fourth row and element 15 is the last element of the fifth row. Element 12 must then be somewhere on the fifth row. We now want to compute where exactly that element occurs in the matrix. First we start with the row index


{% highlight r %}
nElemIdx <- 12
nElementRow <- which(vFlatDiagIdx > nElemIdx)[1]
nElementCol <- nElemIdx-vFlatDiagIdx[nElementRow-1]
cat(" * Row: ", nElementRow, "\n * Col: ", nElementCol, "\n")
{% endhighlight %}



{% highlight text %}
##  * Row:  5 
##  * Col:  2
{% endhighlight %}

Checking our result


{% highlight r %}
identical(vFlatMatElem[12], mGrm[nElementRow,nElementCol])
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}

