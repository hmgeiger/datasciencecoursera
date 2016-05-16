The original FitBit dataset included the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector. 
Mainly used this to know to grep for "mean" and "std" to get mean and standard deviation, 
and that there was another set of variables with "meanFreq" that I should be sure to exclude since they do not measure the mean.

- 'features.txt': List of all features. Used to add column names to the data frame.

- 'activity_labels.txt': Links the class labels with their activity name. 
This is where I learned that 1 is walking, 2 is walking upstairs, etc.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt' and 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. 
Its range is from 1 to 30. 
