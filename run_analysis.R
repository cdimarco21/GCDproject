#Set your working directory to UCI HAR Dataset before running code.

library(dplyr)
library(tidyr)
library(reshape2)

#Read the train and test data sets, activity names, subjects, features

train <- read.table("./train/X_train.txt")
trainActivityNames <- read.table("./train/y_train.txt")
trainSubject <- read.table("./train/subject_train.txt")

test <- read.table("./test/X_test.txt")
testActivityNames <- read.table("./test/y_test.txt")
testSubject <- read.table("./test/subject_test.txt")

features <- read.table("./features.txt")


#Assign feature names to columns of train and test
colnames(train) <- features$V2
colnames(test) <- features$V2


#Transform trainActivityNames, testActivityNames, subjecttrain, and subjecttest to columns; append to train and test.

train$activity <- factor(trainActivityNames[,1])
test$activity <- factor(testActivityNames[,1])

train$subject <- factor(trainSubject[,1])
test$subject <- factor(testSubject[,1])



#### i. Merges the training and the test sets to create one data set.
alldata <- tbl_df(rbind(train, test))



#### ii. Extracts only the measurements on the mean and standard deviation 
####    for each measurement.
alldata <- alldata[, c(grep("mean|std", names(alldata)), 562:563)]
alldata <- alldata[, -grep("meanFreq", names(alldata))]



#### iii. Uses descriptive activity names to name the activities 
####    in the data set.
levels(alldata$activity) <- read.table("activity_labels.txt")$V2



#### iv. Appropriately labels the data set with descriptive variable names.
####    (The existing variable names are appropriate.)



#### v. From the data set in step 4, creates a second, independent tidy data 
####    set with the average of each variable for each activity and each subject.
alldataMelt <- melt(alldata, id = c("activity", "subject"), 
                    measure.vars = names(alldata)[1:66])
alldataMelt <- alldataMelt[c("subject", "activity", "variable", "value")]
alldataMelt <- mutate(alldataMelt, 
                      temp = paste(subject, "-", activity, "-", variable))
ans <- alldataMelt %>% 
      group_by(temp) %>% 
      summarise(average = mean(value)) %>%
      separate(temp, c("subject", "activity", "measurement"), " - ")
