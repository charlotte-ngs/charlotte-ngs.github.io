---
layout: post
title:  Wanted! - Elements Out Of A Flattened Matrix
published: true
tags: [genetic relationship matrix]
---

Given the following problem. Suppose we have a large symmetric matrix of a certain dimension $n$ of which the lower triangular part is stored in a vector. We want to find all row- and column-indices of elements of the original matrix that fullfill a certain property. 

### Background
The genetic relationship matrix (GRM) between $n$ individuals is a symmetric matrix of dimension $n\times n$. Certain software programs that are used to compute the GRM store the lower triangular part of the matrix in a vector. In case we want to know pairs of individuals that have genetic relationship coefficients above a certain threshold, we need to know the row- and column-indices of the original matrix where the coefficients above a certain threshold occur in the original GRM. 

### Small example
Let us try to explain the problem based on a small example. Suppose the GRM between a small number of individuals has the following structure



{% highlight text %}
##           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
## [1,] 1.3759968 0.3467317 0.2801808 0.2441776 0.1192618 0.2616150
## [2,] 0.3467317 1.4614261 0.3586357 0.2385468 0.1402472 0.3813145
## [3,] 0.2801808 0.3586357 1.3017744 0.2064611 0.1386737 0.2711936
## [4,] 0.2441776 0.2385468 0.2064611 1.2571203 0.1146292 0.1705466
## [5,] 0.1192618 0.1402472 0.1386737 0.1146292 1.1433730 0.1460782
## [6,] 0.2616150 0.3813145 0.2711936 0.1705466 0.1460782 1.4259352
{% endhighlight %}

### First solution using two nested loops
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

