
#Loading dplyr package for future use.
library(dplyr)
#Read all the data files that must be in the working directory.
testFeatures <- read.table("X_test.txt", header = FALSE)
trainFeatures <- read.table("X_train.txt", header = FALSE)
testSubjects <- read.table("subject_test.txt", header = FALSE)
trainSubjects <- read.table("subject_train.txt", header = FALSE)
trainActivities <- read.table("y_train.txt", header = FALSE)
testActivities <- read.table("y_test.txt", header = FALSE)
featureNames <- read.table("features.txt", header = FALSE)

 #Merging the training and test datasets by row
features <- rbind(trainFeatures, testFeatures)
subjects <- rbind(trainSubjects, testSubjects)
activities <- rbind(trainActivities, testActivities)

#Labeling the data with descriptive variable names.
names(subjects) <- c("subject")
names(activities) <- c("activity")
names(features) <- featureNames$V2

#Labeling the activties with descriptive names
activities$activity[activities$activity == 1] <- "WALKING"
activities$activity[activities$activity == 2] <- "WALKING_UPSTAIRS"
activities$activity[activities$activity == 3] <- "WALKING_DOWNSTAIRS"
activities$activity[activities$activity == 4] <- "SITTING"
activities$activity[activities$activity == 5] <- "STANDING"
activities$activity[activities$activity == 6] <- "LAYING"

#Merging by columns all the datasets
subjectActivityData <- cbind(subjects, activities)
finalData <- cbind(features, subjectActivityData)

#Extracting means and standard deviations for each measurement using grep function along with activity and subjects
finalData2 <- finalData[,grep("mean()|std()|activity|subject", names(finalData), value = TRUE)]

#Labeling the variables with descriptive names using gsub
names(finalData2) <- gsub("Acc", "Accelerometer", names(finalData2))
names(finalData2) <- gsub("Freq", "Frequency", names(finalData2))
names(finalData2) <- gsub("Mag", "Magnitude", names(finalData2))
names(finalData2) <- gsub("Gyro", "Gyroscope", names(finalData2))
names(finalData2) <- gsub("^t", "Time", names(finalData2))
names(finalData2) <- gsub("^f", "Frequency", names(finalData2))

#Changing activity and subjects variable from type character to factor
finalData2$activity <- as.factor(finalData2$activity)
finalData2$subject <- as.factor(finalData2$subject)

#Finding average of each variable and subject
data <- tbl_df(finalData2)
#First group the activity and subject using dplyr group_by function
groupedData <- group_by(data, activity, subject)
#Taking average of each variable based on the group
summaryData <- summarise_each(groupedData, funs(mean))

#Creating a text file to write the data in tidydata.txt
write.table(summaryData, file = "tidydata.txt",row.name=FALSE)

