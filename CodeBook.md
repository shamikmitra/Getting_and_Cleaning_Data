# Code Book
This code book describes the method in which the input raw data was transformed into the tidy data as part of the assignment for the Coursera Getting and Cleaning Data course.

###Input
The data in the following files were used as input to the script.

1.	**X_test.txt**: Contains the individual observations for the test group. There are 561 columns in this data, containing each accelerometer and gyroscope reading. The descriptive name of these columns are in features.txt
2.	**X_train.txt**: Same as above, but for the training group.
3.	**subject_test.txt**: Contains one column for the subject for the test, identified as a number between 1 and 30
4.	**subject_train.txt**: Same as above, but for the training group.
5.	**y_test.txt**: Contains one column for the type of activity being performed when the data was gathered. This is also a number, between 1 and 6. The description of the activity is in the activity_labels.txt file
6.	**y_train.txt**: Same as above, but for the training group.
7.	**activity_labels.txt**: The list of 6 activity codes in the y_ fields and their corresponding descriptions
8.	**features.txt**: Contains the description of the 561 accelerometer and gyroscope readings in the X_ files

###Processing
1.	Read all the files above
2.	Assign meaningful column names for each of the tables. For the x_test and the x_train data, use the values in the features.txt file to assign column names
3.	Create a subset of the features data with the list of columns that have the text "mean()" or "std()" in them. There should be 66 such variables
4.	Add a column to the y_ data frames to include descriptive labels from the activity_labels data frame
5.	Merge the individual test data frames by column. Do the same for the train data frames. Finally combine the test and train data frames into one big data frame. There should be one column for the subject, one for the activity description and 66 columns for each of the gyroscope and accelerometer readings. 
6.	There will also be an Activity code column. Remove that as we already have the description column
7.	Melt the data frame to move all the gyroscope and accelerometer data from columns to rows. This would make a data frame with 4 columns - subject, activity, variable name (which is the name of the reading) and the variable value
8.	Group the data by the Subject, Activity and the Variable type, and summarize by the average value
9.	Write the tidy data into a text file
10.	Remove all the variables created and release the memory

###Output
There is only one output file with the following columns

1.	**Subject (Factor)**: A number between 1 and 30 identifying the subject participating in the data gathering exercise
2.	**Activity Description (Factor)**: One of 6 values identifying the activity that was being performed by the subject at the time of taking the readings
3.	**Variable**: One of the 66 values that has the name of the accelerometer or gyroscope measurement point
4.	**AverageValue**: The average value of the specific measurement for the subject and activity
