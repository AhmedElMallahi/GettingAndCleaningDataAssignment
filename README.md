This file describes how run_analysis.R script works.

First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Make sure the folder "UCI HAR Dataset" and the run_analysis.R script are both in the current working directory.

Second, use source("run_analysis.R") command in RStudio.

Third, you will find an output file generated in the current working directory: cleaned_data_means.txt.

This file contains a data frame called cleanedDataMeans. This file contains the average of each variable for each activity and each subject.

Finally, use data <- read.table("cleaned_data_means.txt") command in RStudio to read the file. 

Ps: In the code, another file can be generated if needed, by uncomment line 72 (cleaned_data.txt) : it contains a data frame called cleanedData.
