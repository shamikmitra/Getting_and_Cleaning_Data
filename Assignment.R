##      This script is used to combined the test and training data set for the accelerometer
##      and gyroscope readings and to create a tidy data set
##      
##      Data source:
##          Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
##          Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
##          Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
##          Vitoria-Gasteiz, Spain. Dec 2012
##
##      Date            Developer           Comments
##      2015 Nov 19     Shamik Mitra        Initial Version

library(reshape2)
library(dplyr)

## Read the data from all the files. It is expected that the working directory has a folder
## called UCI HAR Dataset containing all the data files
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityCode", "ActivityDescription"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("FeatureColumn", "FeatureDescription"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "ActivityCode")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "ActivityCode")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")

## Set the column names for the accelerometer and gyroscope readings to meaningful names from the features dataframe
colnames(x_test) <- features$FeatureDescription
colnames(x_train) <- features$FeatureDescription

## Create a subset of the features dataframe with the list of columns that have the text "mean()" or "std()" in them
## Use this to create a subset version of the x_ data with only the mean and std columns
required_features <- filter(features, grepl("mean\\(\\)|std\\(\\)",FeatureDescription))
x_test_required <- x_test[, required_features$FeatureColumn]
x_train_required <- x_train[, required_features$FeatureColumn]

## Add a column to the y_ dataframes to include descriptive labels from the activity_labels dataframe
y_test_descriptive <- merge(y_test, activity_labels)
y_train_descriptive <- merge(y_train, activity_labels)

## Merge the test and train dataframes by column and then merge these 2 by rows
test_data <- cbind(subject_test, y_test_descriptive, x_test_required)
train_data <- cbind(subject_train, y_train_descriptive, x_train_required)
combined_data <- rbind(train_data, test_data)

## Remove the ActivityCode from this dataframe. We already have the Description
combined_data <- select(combined_data, -ActivityCode)

## Melt the dataframe to move all the gyroscope and accelerometer data from columns to rows
melted_data <- melt(combined_data, id=1:2, measure.vars=3:68)

## Group the data by the Subject, Activity and the Variable type, and summarize by the average value
tidy_data <- melted_data %>% group_by(Subject, ActivityDescription, variable) %>% summarize(AverageValue = mean(value))

## Write the tidy data into a text file
write.table(tidy_data, "TidyData.txt", row.names = FALSE, col.names = FALSE)

## Remove all the variables created and release the memory
rm(activity_labels)
rm(features)
rm(required_features)
rm(subject_test)
rm(y_test)
rm(y_test_descriptive)
rm(x_test)
rm(x_test_required)
rm(test_data)
rm(subject_train)
rm(y_train)
rm(y_train_descriptive)
rm(x_train)
rm(x_train_required)
rm(train_data)
rm(combined_data)
rm(melted_data)
rm(tidy_data)

######################## End of script ##############################