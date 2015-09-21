#Coursera : Getting and Cleaning Data
#Assignement Project

# Step1. Merges the training and the test sets to create one data set.

#Train data
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
#dim(trainData) 
#head(trainData)

trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
#table(trainLabel)

trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Test data

testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
#dim(testData) 

testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt") 
#table(testLabel) 

testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Join Train and Test data

joinData <- rbind(trainData, testData)
#dim(joinData) 

joinLabel <- rbind(trainLabel, testLabel)
#dim(joinLabel) 

joinSubject <- rbind(trainSubject, testSubject)
#dim(joinSubject) 

# Step2. Extracts only the measurements on the mean and standard 
# deviation for each measurement. 

features <- read.table("./UCI HAR Dataset/features.txt")
#dim(features) 

meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])

length(meanStdIndices) 
joinData <- joinData[, meanStdIndices]

#dim(joinData) 
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

# Step3. Uses descriptive activity names to name the activities in 
# the data set

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step4. Appropriately labels the data set with descriptive activity 
# names. 

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData) #CleanedData set created
dim(cleanedData) 
#write.table(cleanedData, "cleaned_data.txt") # write out the 1st dataset if needed

# Step5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 

subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]

cleanedDataMeans <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
cleanedDataMeans <- as.data.frame(cleanedDataMeans)
colnames(cleanedDataMeans) <- colnames(cleanedData)

row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        cleanedDataMeans[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        cleanedDataMeans[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        cleanedDataMeans[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}

head(cleanedDataMeans)
write.table(cleanedDataMeans, "cleaned_data_means.txt") # write out the output dataset
