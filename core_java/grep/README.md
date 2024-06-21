# Introduction

My Core Java Grep app is made to filter and display lines with a certain regular expression pattern from a text.
I created this app with Java from the JetBrains IntelliJ IDE and Maven framework, and it is deployed using Docker. Some of the methods had been implemented using lambda and stream API (functional programming).

# Quick Start

This app is already deployed in docker in king `https://hub.docker.com/u/kingbach310`, from here it can be pulled from your computer using `docker pull kingbach310/grep` .
To use the app you have to run this command:

kingbach310/grep *Regular expression*  *root/path/of/origin/file*  *root/path/for/new/file*

## Pseudocode

matchedLines = []
for file in listFilesRecursively(rootDir)

for line in readLines(file)

if containsPattern(line)

matchedLines.add(line)

writeToFile(matchedLines)

## Performance Issue

The performance can be insufficient when the size of the input file reach a certain amount because of the memory in speed limits.
To mitigate it we could use functional programming to improve the speed and don't work with lists but directly with stream to economize memory.


# Test

I test the app first of using debugging Intelli J IDE to make sure there's no mistakes in every single steps.
For test, it has been run using different samples of input file (.txt) and making sure the output is what is expected.

# Deployment

The app have been deployed using these simple steps:

-Building a new docker image locally

-Verifying the image

-Running docker container (you must understand all options)

-Pushing your image to Docker Hub


# Improvement

The app can be improved :
-by using entirely Streams instead of Lists
-by creating a Human-Machine interface and be hosted in internet for more global usage as it is launched using JVM
-Offer the option to add some particular grep options
-Other Linux command could be added to the app so users can have all in one even if they don't use Linux.

