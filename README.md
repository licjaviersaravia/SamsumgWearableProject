# CLEANING DATA COURSE - COURSERA DATA SCIENCE SPECIALIZATION

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

PREVIOUS STEPS: packages and reading files

- install "data.table", "reshape2" and "dplyr" packages. Algo set the work directory

- read the principal files (features names, activity labels), read training data files and read test data files

PART 1: merging files, creating dataset

- merge train and test files to create one dataset
- give a name to the columns using "colnames"
- create a complete set by merging features, subjets and activities

PART 2: extract mean and stdv

- extract only the measurements of the mean and standard deviation using grip function
- add activity and subject to the list 

PART 3: name the activities

- convert the activities subset into a character subset by using "as.character"
- factor the activity name

PART 4: change the abreviatures for obtain more comprensible variable names

- use the "gsub" function to change some abbreviatures such as "Acc" by "Accelerometer"

PART 5: create a .txt with the tidy dataset which contanis mean by subject and activity

- convert the $subject subset into a factor subset
- create a data.table variable with all the dataset
- use the aggregate function to obtain the mean by subject per activity (tapply is another option to use)
- create the .txt by "write.table()" setting row.names = FALSE








