---
title: "Command Line Options For Bash Scripts"
author: "Peter von Rohr"
date: "Tuesday, January 06, 2015"
layout: post
output: 
  html_document:
     theme: united
---


## The Ugly Past
Until recently when I wanted to pass command line arguments to a bash script, I included some ugly if statements checking the number of arguments pass and assigning the arguments in a fixed order. Every bash script had at the beginning something that looked as follows

```
...
### # functions
usage () {
  local l_MSG=$1
  echo "Usage Error: $l_MSG"
  echo "Usage: $0 Logfile-stem"
  exit 1
}

...
### # command line args
if [ $#1 -lt 1 ];then
  usage "WRONG number of command line arguments"
fi
LOGFILESTEM=$1

if [ $#1 -gt 1 ];then
  SLEEPSEC=$2
fi
...
```

Apart from being not very good coding style it is also extremely error prone, because the what values from the command line are assigned to the internal variables is entirely dependent on the order of the command line arguments. Furthermore all command line arguments but the last are absolutely mandatory.

Hence there is a need for an improved solution to the problem of parsing commandline arguments in a shell script.


## The Bright New World with bash getopts
Searching the web for a little while quickly showed two possible solutions. 

1. `getopt` which seams to be a `C` library
2. `getopts` which is a bash builtin function

Without comparing the two options and without any argument, I found the second option to be easier. In what follows I am using an example script shown at http://tuxtweaks.com/2014/05/bash-getopts for a script I am using to start an R-script.


## Own Example
Before using `getopts` the script was parsing command line arguments in a very tedious way. 

### The Old Way

```
#!/bin/sh
###
###
###
###   Purpose:   Create Plots for given Trait
###   started:   2015/01/05 (pvr)
###
### ######################################### ###

RPROG=`which R`
RSCRIPT='R/plotLbeExportGrade.R'

### # functions
usage () {
  local l_MSG=$1
  echo "Usage Error: $l_MSG"
  echo "Usage: $0 TraitName"
  exit 1
}

### # starting main
echo  job starts
RIGHT_NOW=$(date +"%x %r %Z")
echo $RIGHT_NOW

### check number of command line arguments
if [ $# -lt 1 ]
then
  usage "Incorrect number of commandline arguments"
fi

### # assume trait is first command line argument
TRAIT=$1

### # more command line parameters
if [ $# -gt 1 ]
then
  EXPERTNAMESFILE=$2
  (echo "sExpertNamesFile <- '${EXPERTNAMESFILE}';Trait <- '${TRAIT}'";cat $RSCRIPT) | $RPROG --vanilla --no-save
else
  (echo "Trait <- '${TRAIT}'";cat $RSCRIPT) | $RPROG --vanilla --no-save
fi

RIGHT_NOW=$(date +"%x %r %Z")
echo $RIGHT_NOW

echo end of job
```

### Using getopts
The same script using `getopts` for command line parsing is shown below. The `usage` function was extended to point to the changed format of how to specifiy command line arguments. 

The whole command line parsing happens in the `while`-loop. After `getopts` the list of recognized flags is listed. A colon after a flag indicates that the flag requires a value to be specified. The first colon tells `getopts` to not show any error messages. 


The `while`-loop calls `getopts` for each command line argument and for each argument it stores the flag in variable `FLAG` and the value behind each flag in variable `OPTARG`. The `FLAG` is then differentiated by the `case` switches where values are assigned into different variables.

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
	  ;;
	d) # set option "d"
	  DATESFILE=$OPTARG
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
```

### Example calls
Calling the script without any command line arguments shows the usage message. 

```
$ ./bash/erzeugePlotsV2.sh
job starts
06.01.2015 04:31:46 CET
Number of arguments: 0
Usage Error: No command line arguments specified
Usage: erzeugePlotsV2.sh -t <string>
  where <string> specifies the trait name
Recognized optional command line arguments
-f <string>  -- Set name of input file with expert names
-d <string>  -- Set name of input file with dates
```

A call with the minimum number of command line arguments is shown below. 

```
./bash/erzeugePlotsV2.sh -t DLC_FO8
```

Specifying all command line arguments looks as follows

```
./bash/erzeugePlotsV2.sh -t DLC_FO8 -f input/experts.csv -d input/dates.csv
```

