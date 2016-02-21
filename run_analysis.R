#Read the train and test data sets, names, subjects, features
#Set the working directory to UCI HAR Dataset 

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


#Merge train and test into alldata
alldata <- tbl_df(rbind(train, test))

