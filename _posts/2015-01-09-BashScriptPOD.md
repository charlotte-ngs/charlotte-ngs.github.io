---
title: "Bash Script Documentation Using POD"
author: "Peter von Rohr"
date: "Tuesday, January 09, 2015"
layout: post
comments: True
output: 
  html_document:
     theme: united
---

## Summary
`POD` stands for [plain old documentation](http://en.wikipedia.org/wiki/Plain_Old_Documentation) which is a simple markup format definition. Documentation on the scripting language [`perl`](http://www.perl.org) is written in POD. The POD viewer that comes with perl is called [`perldoc`](http://perldoc.perl.org), hence any document in POD format can be viewed using perldoc which shows it as a man-page. In what follows, it is shown how documentation in POD format can be included in a bash script and how perldoc is used to show the script documentation as a man-page.


## Divergence Dilemma
Traditionally bash scripts are documented in separate manual files called `man-pages`. While man-pages are well established among users and developers, they are showing a problem that is termed here the `divergence dilemma`. With the term divergence I am referring to the danger that the source code and the documentation of a certain software program can get out of sync. That means the documentation is not exactly reflecting the features implemented in the source code. 

### How can this happen?
Typically source code and documentation are not written in parallel but sequentially. First the source code is developed and later some documentation is added. Whenever bugs in the source code must be fixed or additional features are added, very often the documentation is not updated. Hence the documentation is no longer describing the current version of the source code, but still reflects the initial version of the software program. 


## How To Fight The Divergence Dilemma - Literate Programming
Initiatives such as [`Literate Programming`](http://en.wikipedia.org/wiki/Literate_programming) started by [Donald Knuth](http://en.wikipedia.org/wiki/Donald_Knuth) the author of `TeX` which became the basis of `LaTeX` address the equivalent of the divergence dilemma in computational research. 

In Literate Programming the software program is given by an explanation of the algorithm or the program logic in a natural language like English, interspersed by macros and snippets of source code. It is important to note here that the documentation of the program and the source code are in the same file which helps avoiding the divergence dilemma. 

### Tools implementing Literate Programming
The following table shows some of the tools that implement Literate Programming.

| Tool     | Link                                            | Description                         |
|----------|-------------------------------------------------|-------------------------------------|
| NoWeb    | https://www.cs.tufts.edu/~nr/noweb/             | Implementation of original approach | 
| Sweave   | http://www.stat.uni-muenchen.de/~leisch/Sweave  | R/S-version of noweb                |
| Doxygen  | http://www.doxygen.org                          | CplusPlus, Fortran, Java documenter |
| perldoc  | http://www.perl.com                             | Perl type of manpages               |
| ...      | ...                                             | ...                                 |


### Porting ideas of Literate Programming into a bash script
While it is not possible to follow all premises of Literate Programming when documenting bash scripts, we can implement an improved strategy compared to the man-pages approach that helps avoiding the divergence dilemma. 

The approach proposed here is to combine documentation and source code of the same bash script in one file. Documentation and source code are in separate sections of the file and not interspersed as would be required by Literate Programming.


## An Example Script
An example bash script together with its documentation is shown below. The two parts source code and documentation would be saved in the same file.

```
#!/bin/sh
###
###
###
###   Purpose:   Create Plots for given Trait
###   started:   2015/01/05 (pvr)
###
### ######################################### ###

#Set Script Name variable
SCRIPT=`basename ${BASH_SOURCE[0]}`

### # R-program and R-script
RPROG=`which R`
RSCRIPT='R/plotLbeExportGrade.R'

### # functions
usage () {
  local l_MSG=$1
  echo "Usage Error: $l_MSG"
  echo "Usage: $SCRIPT -t <string>"
  echo "  where <string> specifies the trait name"
  echo "Recognized optional command line arguments"
  echo "-f <string>  -- Set name of input file with expert names"
  echo "-d <string>  -- Set name of input file with dates"
  exit 1
}


### # starting main
echo  job starts
RIGHT_NOW=$(date +"%x %r %Z")
echo $RIGHT_NOW


### check number of command line arguments
NUMARGS=$#
echo "Number of arguments: $NUMARGS"
if [ $NUMARGS -eq 0 ]; then
  usage 'No command line arguments specified'
fi

### Start getopts code ###
#Parse command line flags
#If an option should be followed by an argument, it should be followed by a ":".
#Notice there is no ":" after "h". The leading ":" suppresses error messages from
#getopts. This is required to get my unrecognized option code to work.
while getopts :f:t:d: FLAG; do
  case $FLAG in
    t) # set option "t"
    TRAIT=$OPTARG
	  ;;
	f) # set option "f"
	  EXPERTNAMESFILE=$OPTARG
	  [ -f "${EXPERTNAMESFILE}" ] || usage "Expert name file: ${EXPERTNAMESFILE} NOT FOUND"
	  ;;
	d) # set option "d"
	  DATESFILE=$OPTARG
	  [ -f "${DATESFILE}" ] || usage "Dates period file: ${DATESFILE} NOT FOUND"
	  ;;
	*) # invalid command line arguments
	  usage "Invalid command line argument $OPTARG"
	  ;;
  esac
done  

shift $((OPTIND-1))  #This tells getopts to move on to the next argument.

### # check that TRAIT is not empty
if [ -z "${TRAIT}" ]
then
  usage 'Trait name must be specified using option -t <string>'
fi

### # put together assignment of R-variables required for R-script
RVARS="Trait <- '${TRAIT}'"
if [ ! -z "${EXPERTNAMESFILE}" ]
then
  RVARS="${RVARS};sExpertNamesFile <- '${EXPERTNAMESFILE}'"
fi
if [ ! -z "${DATESFILE}" ]
then
  RVARS="${RVARS};sDatesFile <- '${DATESFILE}'"
fi

### # pass command line arguments and R-script to R program
(echo $RVARS;cat $RSCRIPT) | $RPROG --vanilla --no-save


RIGHT_NOW=$(date +"%x %r %Z")
echo $RIGHT_NOW

echo end of job

: <<=cut
=pod

=head1 NAME

   erzeugePlotsV2.sh - Shell script generating LBE Plots

=head1 SYNOPSIS

   erzeugePlotsV2.sh -t <trait_name>
   
      where: <trait_name> sets the name of the trait

   Recognized optional command line arguments
      -f <string>  -- Set name of input file with expert names
      -d <string>  -- Set name of input file with dates


=head1 DESCRIPTION

The above call generates LBE plots for the trait specified 
after option -t.

=head2 Requirements

Files specified after options -f and -d must exist, otherwise 
a usage message will be shown. 


=head1 LICENSE

Artistic License 2.0 http://opensource.org/licenses/artistic-license-2.0


=head1 AUTHOR

Peter von Rohr <peter.vonrohr@qualitasag.ch>


=cut
```

Once the source code and the script are saved in a file, we can use `perldoc` with the name of the script file which then shows the documentation as a manpage. Since the documentation is written in `POD` format, we can use all available converters of POD such as `pod2html`, `pod2man` or `pod2text`. The output of running `perldoc` on the above script looks as follows.

```
ERZEUGEPLOTSV2.SH(1)  User Contributed Perl Documentation ERZEUGEPLOTSV2.SH(1)



NAME
          erzeugePlotsV2.sh - Shell script generating LBE Plots

SYNOPSIS
          erzeugePlotsV2.sh -t <trait_name>

             where: <trait_name> sets the name of the trait

          Recognized optional command line arguments
             -f <string>  -- Set name of input file with expert names
             -d <string>  -- Set name of input file with dates

DESCRIPTION
       The above call generates LBE plots for the trait specified after option
       -t.

   Requirements
       Files specified after options -f and -d must exist, otherwise a usage
       message will be shown.

LICENSE
       Artistic License 2.0
       http://opensource.org/licenses/artistic-license-2.0

AUTHOR
       Peter von Rohr <peter.vonrohr@qualitasag.ch>



perl v5.14.4                      2015-01-13              ERZEUGEPLOTSV2.SH(1)

```