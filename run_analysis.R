#Read in the files with the activity labels (1-6), 
#the actual raw measurement numbers, 
#and the subject IDs per measurement for test and training data.

test_activity_labels <- as.vector(read.table("test/y_test.txt")$V1)
test_features <- read.table("test/X_test.txt")
test_subjects <- as.vector(read.table("test/subject_test.txt")$V1)
train_activity_labels <- as.vector(read.table("train/y_train.txt")$V1)
train_features <- read.table("train/X_train.txt")
train_subjects <- as.vector(read.table("train/subject_train.txt")$V1)

#Use simple concatenation to combine the two data sets.

total_activity_labels <- c(test_activity_labels,train_activity_labels)
total_features <- rbind(test_features,train_features)
total_subjects <- c(test_subjects,train_subjects)

#Read in the column names for the measurement matrix. Add them to the data frame here in R.

feature_list <- as.vector(read.table("features.txt")$V2)

colnames(total_features) <- feature_list

#Choose only features corresponding to mean or standard deviation. 
#These may be found by grepping out "mean" and "std", 
#minus removing any "meanFreq" that gets grepped this way since that is actually a different measurement.

features_involving_mean <- feature_list[grep('mean',feature_list)]
features_involving_mean <- features_involving_mean[grep('meanFreq',features_involving_mean,invert=TRUE)]
features_involving_sd <- feature_list[grep('std',feature_list)]

total_features <- total_features[,c(features_involving_mean,features_involving_sd)]

#Change the activity numbers to strings.

activity_labels_as_strings <- c()

for(activity in total_activity_labels)
{
if(activity == 1){activity_labels_as_strings <- append(activity_labels_as_strings,"WALKING")}
if(activity == 2){activity_labels_as_strings <- append(activity_labels_as_strings,"WALKING_DOWNSTAIRS")}
if(activity == 3){activity_labels_as_strings <- append(activity_labels_as_strings,"WALKING_UPSTAIRS")}
if(activity == 4){activity_labels_as_strings <- append(activity_labels_as_strings,"SITTING")}
if(activity == 5){activity_labels_as_strings <- append(activity_labels_as_strings,"STANDING")}
if(activity == 6){activity_labels_as_strings <- append(activity_labels_as_strings,"LAYING")}
}

#Make a matrix with the activity name, subject ID, and then the numbers for each row.
#Output this somewhat tidied but not yet averaged file to a text file in case we need that later as well.

measurements_with_activity_and_subject <- cbind(activity_labels_as_strings,total_subjects,total_features)
colnames(measurements_with_activity_and_subject) <- c("Activity_name","SubjectID",features_involving_mean,features_involving_sd)

write.table(measurements_with_activity_and_subject,file="/Users/hmgeiger/Documents/tidy_data_not_yet_averaged.txt",row.names=FALSE,col.names=TRUE,quote=FALSE,sep="\t")

#For each unique combination of activity/subject (which we will get by combinining these two values into one string), get the mean per feature.

activity_and_subject_names <- paste(measurements_with_activity_and_subject$Activity_name,measurements_with_activity_and_subject$SubjectID,sep="-")

measurements_with_activity_and_subject <- cbind(activity_and_subject_names,total_features)
colnames(measurements_with_activity_and_subject) <- c("Activity_plus_subject",features_involving_mean,features_involving_sd)

averages_per_activity_and_subject <- aggregate(measurements_with_activity_and_subject[,2:ncol(measurements_with_activity_and_subject)],by=list(measurements_with_activity_and_subject[,1]),FUN=mean)

colnames(averages_per_activity_and_subject)[1] <- "Activity-SubjectID"

write.table(averages_per_activity_and_subject,file="/Users/hmgeiger/Documents/tidy_data_averaged.txt",row.names=FALSE,col.names=TRUE,quote=FALSE,sep="\t")
