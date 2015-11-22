## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# packages

install.packages("data.table")
install.packages("reshape2")
install.packages("dplyr")
library(dplyr)
library(data.table)  
library(reshape2)  

# set working directory
setwd("C:/coursera/temp")

# reading principal files
featureNames <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
activity_labels

# read training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

# read test data

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

# ------------- PART 1 -----------------------
# merge training and test sets to create one dataset
subject <- rbind(subject_train,subject_test)
activity <- rbind(y_train,y_test)
features <- rbind(X_train,X_test)

# give a name to the columns
colnames(features) <- t(featureNames[2])

# merging the data
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeSet <- cbind(features,activity,subject)

# --------------------- Part 2 --------------------

# extract only the measurements of the mean and standar deviation
columnsMeanSTDV <- grep(".*Mean.*|.*Std.*", names(completeSet), ignore.case=TRUE)

# add activity and subject to the list and look the dimention
requiredColumns <- c(columnsMeanSTDV,562,563)
dim(completeSet)

# create DataExtracted variable
DataExtracted <- completeSet[,requiredColumns]
dim(DataExtracted)


# -------------------- Part 3 --------------

# name the activities of the dataset
DataExtracted$Activity <- as.character(DataExtracted$Activity)
for(i in 1:6)
{
  DataExtracted$Activity[DataExtracted$Activity == i] <- as.character(activity_labels[i,2])
}

# factor the activity name
DataExtracted$Activity <- as.factor(DataExtracted$Activity)


# ----------- Part 4 ---------------------

names(DataExtracted)

names(DataExtracted)<-gsub("Acc","Accelerometer",names(DataExtracted))
names(DataExtracted)<-gsub("Gyro", "Gyroscope", names(DataExtracted))
names(DataExtracted)<-gsub("BodyBody", "Body", names(DataExtracted))
names(DataExtracted)<-gsub("Mag", "Magnitude", names(DataExtracted))
names(DataExtracted)<-gsub("^t", "Time", names(DataExtracted))
names(DataExtracted)<-gsub("^f", "Frequency", names(DataExtracted))
names(DataExtracted)<-gsub("tBody", "TimeBody", names(DataExtracted))
names(DataExtracted)<-gsub("-mean()", "Mean", names(DataExtracted), ignore.case = TRUE)
names(DataExtracted)<-gsub("-std()", "STD", names(DataExtracted), ignore.case = TRUE)
names(DataExtracted)<-gsub("-freq()", "Frequency", names(DataExtracted), ignore.case = TRUE)
names(DataExtracted)<-gsub("angle", "Angle", names(DataExtracted))
names(DataExtracted)<-gsub("gravity", "Gravity", names(DataExtracted))

names(DataExtracted)


# --------------- PART 5 ------------------------
# create a second independent tidy data set with the average of each variable
# for each activity and each subject

#get subject as a factor
DataExtracted$Subject <- as.factor(DataExtracted$Subject)
DataExtracted <- data.table(DataExtracted)
class(DataExtracted)

#creation of the tidy data
tidy_data <- aggregate(. ~Subject + Activity, DataExtracted, mean)
# creating the tidy data file
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)



