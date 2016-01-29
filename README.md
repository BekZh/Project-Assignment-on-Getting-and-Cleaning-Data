# Project-Assignment-on-Getting-and-Cleaning-Data

Assignment: Getting and Cleaning Data Course Project

The original data set was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the original data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

We used the following data set for this project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Using R script called run_analysis.R (the script code is uploaded to this repo), we performed the following:

1. We downloaded the dataset file.
2. The dataset was loaded from the file into R.
3. We merged the training and the test sets to create one data set.
4. We extracted only the measurements on the mean and standard deviation for each measurement.
5. We used descriptive activity names to name the activities in the data set.
6. We appropriately labeled the data set with descriptive variable names.
7. From the data set in step 6, we created a second, independent tidy data set with the average of each variable for each activity and each subject. 


