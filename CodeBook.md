This is a description of the tbl MyData.csv and the script that creates it (run_analysis.R).


I. 	MyData.csv has 4 variables.  The following variable descriptions also describe the data.

		1. subject: 	 integer between 1 and 30 assigned to the individual who performed the activity 
		2. activity: 	 activity performed by the individual (activity names are self-explanatory)
		3. measurement:	 name of measurement that was taken in experiment
		4. average:	 mean of associated measurement for specified subject and activity in that row


II. 	Description of run_analysis.R. The script takes the following actions:
		1. Load package dplyr.
		2. Read the train and test data sets, activity names, subjects, features (all txt files from original folder).
		3. Assign feature names to columns of train and test data.
		4. Transform training activity names, test activity names, training subject numbers, and test subject numbers to columns; 
		   append to train and test data.
		5. Merge the training and test data sets to create one data set (resulting tbl is called alldata).
		6. Extracts only the measurements on the mean and standard deviation for each measurement.
		7. Uses descriptive activity names (by reading activity_labels.txt) to name the activities in the data set (by renaming the factor levels).
		8. Appropriately labels the data set with descriptive variable names (the existing variable names are appropriate).
		9. Creates a second, independent tidy data set with the average of each variable for each activity and each subject:
			a. Melt feature variables into single column (yields alldataMelt).
			b. Rearrange columns of alldataMelt: subject, acitivity, variable, value
			c. Create alldataMelt$temp column to facilitate future application of summarise.
			d. Group alldataMelt by "temp"
			e. Summarise "value" (take mean) in alldataMelt (which removes "subject" and "activity" columns)
			f. Separate "temp" to recover lost columns and yield tidy data set (ans)