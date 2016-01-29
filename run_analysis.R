
# downloading file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)

# loading data into R

# loading test dataset
xtest <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
activitylabelstest <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
subjecttest <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))

# loading training dataset
xtrain <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
activitylabelstrain <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
subjecttrain <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))

# loading feature and actvity level labels
features <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
activitylabelsinwords <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))

unlink(temp)

# renaming and labeling columns

# renaming columns of xtest and xtrain with feature names
colnames(xtest) <- features[,2]
colnames(xtrain) <- features[,2]

# merging data

# adding subject and activity level columns to test and train sets

xtest["subjectid"] <- subjecttest
xtest["activitylevel"] <- activitylabelstest
xtrain["subjectid"] <- subjecttrain
xtrain["activitylevel"] <- activitylabelstrain

# merging test and train set
mergeddata <- merge(xtest,xtrain,all=TRUE)

# Extracts only the measurements on the mean and standard deviation for each measurement

mergeddata1 <- mergeddata %>% select(subjectid, activitylevel, contains("mean()"), contains("std()"))

# lowercasing columns and removing special characters 
colnames(mergeddata1) <- tolower(colnames(mergeddata1))
colnames(mergeddata1) <- gsub("[(][)]","",colnames(mergeddata1))
colnames(mergeddata1) <- gsub("-","",colnames(mergeddata1))

# replacing f and t with freq and time
colnames(mergeddata1) <- gsub("^t","time",colnames(mergeddata1))
colnames(mergeddata1) <- gsub("^f","freq",colnames(mergeddata1))

# descriptive activity names to name the activity levels in the data set
mergeddata1$activitylevel <- gsub("1","walking",mergeddata1$activitylevel)
mergeddata1$activitylevel <- gsub("2","walkingupstairs",mergeddata1$activitylevel)
mergeddata1$activitylevel <- gsub("3","walkingdownstairs",mergeddata1$activitylevel)
mergeddata1$activitylevel <- gsub("4","sitting",mergeddata1$activitylevel)
mergeddata1$activitylevel <- gsub("5","standing",mergeddata1$activitylevel)
mergeddata1$activitylevel <- gsub("6","laying",mergeddata1$activitylevel)

#  independent tidy data set with the average of each variable for each activity and each subject
by_act_subj <- group_by(mergeddata1,subjectid,activitylevel)
output_tidy_data <- summarise_each(by_act_subj, funs(mean))
dim(output_tidy_data)
head(output_tidy_data)

