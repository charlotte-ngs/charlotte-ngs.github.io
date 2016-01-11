---
title: "Problem With rJava On Mac OS X El Capitan"
author: "Peter von Rohr"
date: "5 January 2016  "
layout: post
comments: True
output: 
  html_document:
     theme: united
---

Since I upgraded my Mac to OS X El Capitan (version 10.11.2) I am having problems with the R-package [`rJava`](https://www.rforge.net/rJava). From what I understood, eventually, it is not a problem of `rJava` or R or RStudio in the first place, but newer versions of Mac OS X do not play well with the latest versions of Oracle's Java (jdk). Furthermore, some new security features in Mac OS X prevent that environment path settings are passed along to applications like RStudio. 

In what follows, I listed the steps that solved for me the problem that the package `rJava` could not be loaded from within RStudio under Mac OS X El Capitan (version 10.11.2). 

### Problem statement
Unfortunately, the package `rJava` does not just fail to load, but the R GUI for Mac terminates instantly and in RStudio the R-session gets closed. Both effects are pretty annoying! See the screen shot below on how that might look like.

![R session abort](http://charlotte-ngs.github.io/img/2016-01-05-MacOsXrJavaProblem/RSessionAbort.png)

### Some research
After searching the web, the details of the problem are still not clear to me. But it appears that OS X has problems recognizing newer versions Oracle's Java. OS X seams to be looking for a legacy version 6 of Apple's own build of Java. As shown in the next section one solution seams to be the installation of Apple's legacy version 6 of Java and a newer version (e.g. 1.8.0_66) of Oracle's Java at the same time. 

### The solution
The post available at https://github.com/snowflakedb/dplyr-snowflakedb/wiki/Configuring-R-rJava-RJDBC-on-Mac-OS-X solved my problem with `rJava` on Mac OS X 10.11.2. 

### Java 6
I already had XCode command line tools installed, so I started at section `Java 6`. I downloaded the legacy Java 6 runtime from https://support.apple.com/kb/DL1572?locale=de_DE and installed the downloaded `.dmg` file.

### Java 8
Since I had already installed the latest version of Oracle's jdk from http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html, I skipped the step.

The output of `java_home` on my machine looks as follows

```
YARLI:Downloads peter$ /usr/libexec/java_home -V
Matching Java Virtual Machines (5):
    1.8.0_66, x86_64:	"Java SE 8"	/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
    1.7.0_67, x86_64:	"Java SE 7"	/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home
    1.7.0_25, x86_64:	"Java SE 7"	/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home
    1.6.0_65-b14-468, x86_64:	"Java SE 6"	/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
    1.6.0_65-b14-468, i386:	"Java SE 6"	/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
```

Please note the 1.7 version are really not needed here.

### R for OS X
The latest version of R was already running, so I skipped this step. The check with `javareconf` gave the following result.

```
YARLI:Downloads peter$ R CMD javareconf
Java interpreter : /usr/bin/java
Java version     : 1.8.0_66
Java home path   : /Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/jre
Java compiler    : /usr/bin/javac
Java headers gen.: /usr/bin/javah
Java archive tool: /usr/bin/jar
Non-system Java on OS X

trying to compile and link a JNI program 
detected JNI cpp flags    : -I$(JAVA_HOME)/../include -I$(JAVA_HOME)/../include/darwin
detected JNI linker flags : -L$(JAVA_HOME)/lib/server -ljvm
clang -I/Library/Frameworks/R.framework/Resources/include -DNDEBUG -I/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/jre/../include -I/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/jre/../include/darwin -I/usr/local/include -I/usr/local/include/freetype2 -I/opt/X11/include    -fPIC  -Wall -mtune=core2 -g -O2  -c conftest.c -o conftest.o
clang -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o conftest.so conftest.o -L/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/jre/lib/server -ljvm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation


JAVA_HOME        : /Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/jre
Java library path: $(JAVA_HOME)/lib/server
JNI cpp flags    : -I$(JAVA_HOME)/../include -I$(JAVA_HOME)/../include/darwin
JNI linker flags : -L$(JAVA_HOME)/lib/server -ljvm
Updating Java configuration in /Library/Frameworks/R.framework/Resources
Done.
```

### rJava
As the version of `rJava` from CRAN did not work, I took the latest version from `rforge` and installed that one.

```
curl -#ROL https://www.rforge.net/rJava/snapshot/rJava_0.9-8.tar.gz
R CMD INSTALL rJava_0.9-8.tar.gz
```

A quick check whether `rJava` can be loaded, is done as follows

```
R --quiet -e 'library("rJava"); .jinit(); .jcall("java/lang/System", "S", "getProperty", "java.runtime.version")'
> library("rJava"); .jinit(); .jcall("java/lang/System", "S", "getProperty", "java.runtime.version")
[1] "1.8.0_66-b17"
```

### RStudio
Running the above check on the RStudio console still gives the following error

```
library("rJava"); .jinit(); .jcall("java/lang/System", "S", "getProperty", "java.runtime.version")
Error : .onLoad failed in loadNamespace() for 'rJava', details:
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rJava/libs/rJava.so':
  dlopen(/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rJava/libs/rJava.so, 6): Library not loaded: @rpath/libjvm.dylib
  Referenced from: /Library/Frameworks/R.framework/Versions/3.2/Resources/library/rJava/libs/rJava.so
  Reason: image not found
Error: package or namespace load failed for ‘rJava’
```

For some reason which might be connected to a new security feature of Mac OS X, the file `libjvm.dylib` cannot be found. Loading this library explicitly, as was described in http://stackoverflow.com/questions/30738974/rjava-load-error-in-rstudio-r-after-upgrading-to-osx-yosemite, finally solves the problem. 


```r
dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/jre/lib/server/libjvm.dylib')
require(rJava)
```

```
## Loading required package: rJava
```

```r
.jinit()
.jcall("java/lang/System", "S", "getProperty", "java.runtime.version")
```

```
## [1] "1.8.0_66-b17"
```


```r
sessionInfo()
```

```
## R version 3.2.3 (2015-12-10)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: OS X 10.11.2 (El Capitan)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] rJava_0.9-8
## 
## loaded via a namespace (and not attached):
##  [1] magrittr_1.5    formatR_1.2     tools_3.2.3     htmltools_0.2.6
##  [5] yaml_2.1.13     stringi_0.5-5   rmarkdown_0.8   knitr_1.11     
##  [9] stringr_1.0.0   digest_0.6.8    evaluate_0.8
```



