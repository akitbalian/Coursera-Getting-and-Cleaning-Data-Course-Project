write.table(desFeatures.names, "featureNames.txt", row.names = FALSE)#Load Required Libraries
library(plyr)
#I had issues dowloading the .zip file wihout this.
library(RCurl)

#R will need write right to the current directory
filename <- "getdata_dataset.zip"
#Check if file exists, if not download it and unzip it
if (!file.exists(filename)){
    download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile=filename,method="libcurl")
}  
if (!file.exists("UCI HAR Dataset")) {unzip(filename)}

#Get Labels and Features
activLabels            <- read.table("UCI HAR Dataset/activity_labels.txt")
activLabels[,2]        <- as.character(activLabels[,2])
features               <- read.table("UCI HAR Dataset/features.txt")
features[,2]           <- as.character(features[,2])

#Pick only mean and std (desiredFeatures)
desFeatures            <- grep(".*mean.*|.*std.*", features[,2])
desFeatures.names      <- features[desFeatures,2]

#Load actual activity tain data
activityTrainX         <- read.table("UCI HAR Dataset/train/X_train.txt")[desFeatures]
activityTrainY         <- read.table("UCI HAR Dataset/train/Y_train.txt")
activityTrainSubj      <- read.table("UCI HAR Dataset/train/subject_train.txt")
activityTrain          <- cbind(activityTrainSubj, activityTrainY, activityTrainX)

#Similarly load actual activity test data
activityTestX          <- read.table("UCI HAR Dataset/test/X_test.txt")[desFeatures]
activityTestY          <- read.table("UCI HAR Dataset/test/Y_test.txt")
activityTestSubj       <- read.table("UCI HAR Dataset/test/subject_test.txt")
activityTest           <- cbind(activityTestSubj, activityTestY, activityTestX)

#Merge Test and train data
trainAndTest           <- rbind(activityTrain, activityTest)
colnames(trainAndTest) <- c("subject", "activity", desFeatures.names)

#Turn Data into factors
trainAndTest$activity  <- factor(trainAndTest$activity, levels = activLabels[,1], labels = activLabels[,2])
trainAndTest$subject   <- as.factor(trainAndTest$subject)
trainAndTest.melted    <- melt(trainAndTest, id = c("subject", "activity"))
trainAndTest.mean      <- dcast(trainAndTest.melted, subject + activity ~ variable, mean)

#Write out the output file with means only
write.table(trainAndTest.mean, "tidyActivityData.txt", row.names = FALSE)
write.table(desFeatures.names, "featureNames.txt", row.names = FALSE)
