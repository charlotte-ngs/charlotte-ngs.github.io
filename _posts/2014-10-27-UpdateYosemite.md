---
title    : "Update Mac Os X to Yosemite"
author   : "Peter von Rohr"
job      : "Charlotte Team"
date     : "27 Oct 2014"
layout: post
status: publish
published: true
comments: True
output: 
  html_document:
     theme: united
---
 
## Summary
All those who want to stay on the safe side and hate to work around issues and new features, are best advised to wait with an upgrade to Yosemite. Also for production systems, an upgrade is probably still a bit early. Unlike with the previous upgrade to Mac Os X 10.9, no real performance boost is perceived when upgading to `Yosemite`. Although one has to admit that all the points mentioned here against the upgrade are nowhere near the nightmare of an upgrade from Windows 7 to 8. 
 
## Prerequisite
Before one upgrades a whole operating system, a complete backup of user data is an absolute must. Mac Os X has a backup utility called TimeMachine which comes for free with the system. All one has to do is connect an external hard-drive and start a backup using Time Machine by clicking on the following icon.
 
![Time Machine](http://charlotte-ngs.github.io/img/2014-10-27-UpdateYosemite/TimeMachine.png)
 
## Download
Last weekend I decided to upgrade Mac Os X on my Mac Book to version 10.10 aka `Yosemite`. The upgrade process is started from the AppStore. When you open the AppStore there is a big banner with the Yosemite Logo and a small Update button. Whenever you click on that button the download starts. 
 
![Yosemite Logo](http://charlotte-ngs.github.io/img/2014-10-27-UpdateYosemite/AppStoreYosemite.png)
 
It took more than three hours to download which is most likely caused by my very slow connection to the internet at home. In total, the upgrade to Yosemite is worth 5.16 GB of data. 
 
## Installation
Once the download was completed the installation of the upgrade can be started from the Download folder. I have not followed the installation closely, but it took quite a long time and several restarts were required. The whole installation did not require any intervention from the user side. In case somebody is interested in more details, one cat press Command-L which is supposed to show more details about the progress of the installation. The timings shown during the installation were not very accurate. For about half an hour the installation screen was showing the message `2 minutes left ...`. It seams that the upgrade utility is copying parts of the user data or installed software to a secure place and that can take a lot of time depending on how much data has to be copied.
 
## Aftermath
The whole upgrade process went very smoothly. The default desktop background changed and the dock looks different but appart from that no obvious changes. When maximizing a window using the green dot in the top-left corner, the window is shown in a full-screen mode. This full-screen mode can be terminated by pointing the cursor to the top border of the screen. 
 
![RedYellowGreenDots](http://charlotte-ngs.github.io/img/2014-10-27-UpdateYosemite/RedYellowGreenDots.png)
 
### Path Issue
In a [post on tex.stackexchange.com](http://tex.stackexchange.com/questions/208181/why-did-my-tex-related-gui-program-stop-working-in-mac-os-x-yosemite), Adam Maxwell mentioned that GUI programs using TEX tools like `pdflatex` stopped working after upgrading to Yosemite. In the background section of the post the author explains that GUI programs do no longer inherit variables from shell init files like .bash_profile, .bashrc or others.
 
For RStudio this meant that when creating a new Sweave document, RStudio would put up the message that it cannot find any TeX installation.
 
![No TeX Installation in RStudio](http://charlotte-ngs.github.io/img/2014-10-27-UpdateYosemite/NoTeXInstallationRStudio.png)
 
When trying to compile, the unsurprising error message appears in the Compile PDF console.
 
![Pdflatex Error Message](http://charlotte-ngs.github.io/img/2014-10-27-UpdateYosemite/PdflatexErrorMessage.png)
 
### Fix for RStudio
Shortly after the post by Adam Maxwell there were posts appearing on [Rbloggers](http://www.r-bloggers.com/r-and-rstudio-incompatibility-with-yosemite-mac-os-x-10-10/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+RBloggers+%28R+bloggers%29) and the [RStudio web-site](https://support.rstudio.com/hc/en-us/articles/203815576-RStudio-PATH-problems-with-OS-X-Yosemite) announcing that the latest version (Version 0.98.1083) of RStudio would fix the path problem. After installing that latest version, no more messages of missing TeX installations and compiling Sweave documents worked again. 
