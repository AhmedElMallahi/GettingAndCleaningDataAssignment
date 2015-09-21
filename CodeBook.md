This file describes the variables, the data, and any transformations or work performed to clean up the data.

The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data:

1/ Read X_train.txt, y_train.txt and subject_train.txt from the "./UCI HAR Dataset/train" folder and store them in trainData, trainLabel and trainSubject variables respectively.

2/ Read X_test.txt, y_test.txt and subject_test.txt from the "./UCI HAR Dataset/test" folder and store them in testData, testLabel and testsubject variables respectively.

3/ Created the data frame joinData, which is the concatenation of testData and trainData
Created the data frame joinLabel, which is the concatenation of testLabel and trainLabel
Created the data frame joinSubject, which is the concatenation of testSubject and trainSubject

4/ Read the features.txt file from the "/UCI HAR Dataset" folder and store the data in a variable called features. We only extract the measurements on the mean and standard deviation. 
This results in a 66 indices list. We get a subset of joinData with the 66 corresponding columns.

5/ Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.

6/ Read the activity_labels.txt file from the "./UCI HAR Dataset"" folder and store the data in a variable called activity.

7/ Clean the activity names in the second column of activity. We first make all names to lower cases. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore.

8/ Transform the values of joinLabel according to the activity data frame.

9/ Combine the joinSubject, joinLabel and joinData by column to get a new cleaned data frame, called cleanedData. 
The first two columns are named "subject" and "activity". 
This dataset can be written to a file if needed, by uncomment line 72.

10/ Generate a second independent tidy data set with the average of each measurement for each activity and each subject. The resulting dataset is written in a file as an output, named "cleaned_data_means.txt"
