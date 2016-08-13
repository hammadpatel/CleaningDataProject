README

First the dplyr package was loaded using library function. This package is used in the future manipulation of data.
library(dplyr)

Data was zip was downloaded from the link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Package was unzipped. All the necessary files that are needed for the analysis were moved together in a single folder. The folder was made
the working directory in RStudio. These datasets include test and train subjects, activites and features.


In the second step all the necessary data files were loaded using read.table()
testFeatures <- read.table("X_test.txt", header = FALSE)
trainFeatures <- read.table("X_train.txt", header = FALSE)
testSubjects <- read.table("subject_test.txt", header = FALSE)
trainSubjects <- read.table("subject_train.txt", header = FALSE)
trainActivities <- read.table("y_train.txt", header = FALSE)
testActivities <- read.table("y_test.txt", header = FALSE)

This file is not used for analysis. But it will be used later for assigning variable names.
featureNames <- read.table("features.txt", header = FALSE)

Subject,features and activities datasets of training and tests subjects were merged together row wise using rbind. 
features <- rbind(trainFeatures, testFeatures)
subjects <- rbind(trainSubjects, testSubjects)
activities <- rbind(trainActivities, testActivities)

Initially the combined datasets didn't contain any variable names. So each of these datasets were given variables names using the function names()
The subjects and activites datasets were given varaible names manually while features datasets was given the variable names using features.txt file.
names(subjects) <- c("subject")
names(activities) <- c("activity")
names(features) <- featureNames$V2

In the third step all the values in activity datasets were replaced by descriptive names.
             1 for WALKING
             2 for WALKING_UPSTAIRS
			 3 for WALKING_DOWNSTAIRS
			 4 for SITTING
			 5 for STANDING
			 6 for LAYING

activities$activity[activities$activity == 1] <- "WALKING"
activities$activity[activities$activity == 2] <- "WALKING_UPSTAIRS"
activities$activity[activities$activity == 3] <- "WALKING_DOWNSTAIRS"
activities$activity[activities$activity == 4] <- "SITTING"
activities$activity[activities$activity == 5] <- "STANDING"
activities$activity[activities$activity == 6] <- "LAYING"


In the fourth step all the datasets were combined column wise creating a single unified dataset using the function cbind()
subjectActivityData <- cbind(subjects, activities)
finalData <- cbind(features, subjectActivityData)

In the fifth step all the mean and standard deviation variables were extracted with the subject and activity variable. This extracted/reduced data is
stored in a variable named finalData2. grep() function in R was used for this purpose.
finalData2 <- finalData[,grep("mean()|std()|activity|subject", names(finalData), value = TRUE)]

In the sixth step all the extracted variable names were replaced with descriptve variable names to remove ambiguities in the data. gsub() function was used to perform this task.
names(finalData2) <- gsub("Acc", "Accelerometer", names(finalData2))
names(finalData2) <- gsub("Freq", "Frequency", names(finalData2))
names(finalData2) <- gsub("Mag", "Magnitude", names(finalData2))
names(finalData2) <- gsub("Gyro", "Gyroscope", names(finalData2))
names(finalData2) <- gsub("^t", "Time", names(finalData2))
names(finalData2) <- gsub("^f", "Frequency", names(finalData2))

In the seventh step activity and subject variables were converted for datatype character and integer to factors using the R function as.factor().
finalData2$activity <- as.factor(finalData2$activity)
finalData2$subject <- as.factor(finalData2$subject) 

In the eigth step , dplyr library was used that was loaded above initially to perform data manipulation tasks.
First the data was loaded using dplyr function tbl_df()
data <- tbl_df(finalData2)

Second the data was group together according to subject and activities using dplyr function grouped_by()
groupedData <- group_by(data, activity, subject)

Third summary statistics was performed on the group to find average of all the columns of each subject and activity using dplyr function summarise_each().
summaryData <- summarise_each(groupedData, funs(mean))

In the final step analysed and manipulated data is written in a text file named tidydata.txt using write.table() function.
write.table(summaryData, file = "tidydata.txt",row.name=FALSE)

This text file can be read again into R using the code.
data <- read.table(file_path, header = TRUE)
















