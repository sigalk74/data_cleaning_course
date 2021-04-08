# I did the analsysis in steps so the code cannot run as it is but each part runs separately. 
# I only knew at the end of the assignment that everything should be in  a single code and could not do it again. 


# Download the zip folder, unzip and extract the data sets 
# Understanding which are the train and the text files to merge 

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
download.file(fileURL, destfile = "C:/Users/sigalk/Documents/GitHub/data_course/finaldataset.zip")
unzip("C:/Users/sigalk/Documents/GitHub/data_course/finaldataset.zip")
list.files ("UCI_HAR_Dataset") 
list.files ("UCI_HAR_Dataset/train")
list.files ("UCI_HAR_Dataset/test") 

# reading the train and test files into two data frames 

df_train <- read.table(file="C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")
df_test <- read.table(file="C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")
# Check table dimensions
ncol(df_train)
nrow(df_train)
ncol(df_test)
nrow(df_test)

#add column names from features to each of the tables 
df_features <- read.table(file="C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/features.txt", header = FALSE, sep = " ")
ncol(df_features)
df_names <- df_features[-1]
name_vector <- as.vector(t(df_names))
name_vector <- as.character(name_vector[1:length(name_vector)])

colnames(df_train) <- name_vector 
colnames(df_test) <- name_vector


# Merge the training and the test sets to create one data set.
# the merge is conducted by merging the train and test data sets one AFTER the other
# rbind is used to merge the two data sets 
# the flag variables differentiates between the training set and the test set 
df_merge <- rbind(df_train,df_test)
nrow(df_merge)
ncol(df_merge)
write.csv(df_merge,"C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/df_merge.csv",sep = ",", dec = ".", row.names = FALSE)

# Extract only the measurements on the mean and standard deviation for each measurement
# create an empty data frame names new_df
# in names vector detect the words "mean" and "std" 
# if the word is found then create a list of valid variables 
# loop over the list of column names and add the valid columns to a new data set
new_df = data.frame(matrix(, nrow=10299, ncol=0))
valid_list <- c()

for (i in 1:length(name_vector)) {
  temp <- name_vector[i]
  if (grepl("mean|std",temp) == TRUE) {
      print(names(df_merge[c(temp)]))
      valid_list <- append(valid_list,temp)
  }
}

for (i in 1:length(valid_list)){
   new_df <- cbind(new_df,df_merge[c(valid_list[i])])
}
 
write.csv(new_df,"C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/new_df.csv",row.names = FALSE)


# Use descriptive activity names to name the activities in the data set
# first merge the training and the test set for the activities 
train_lables <- read.table(file="C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/train/y_train.txt", sep="\t", quote="", comment.char="") 
test_lables <- read.table(file="C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/test/y_test.txt", sep="\t", quote="", comment.char="") 
df_lables <- rbind(train_lables,test_lables)
nrow(df_lables)
ncol(df_lables)
# transform to vector for loop 
activities <- as.vector(t(df_lables))

for (i in 1:length(activities)) {
 
  if (activities[i] == 1) {
    activities[i] <- "walking"
  }
  
  else if (activities[i] == 2) {
    activities[i] <- "walking_upstaris"
  }
  
  else if (activities[i] == 3) {
    activities[i] <- "walking_downstairs"
  }
  
  else if (activities[i] == 4) {
    activities[i] <- "sitting"
  }
  else if (activities[i] == 5) {
    activities[i] <- "standing"
  }
  else if (activities[i] == 6) {
    activities[i] <- "laying"
  }
}
activities

activity_df<- data.frame(activities)

# add the activities to the merged data set 
new_df <- cbind(new_df,activity_df)

# add a variable that identifies the training and the test set 
train <- rep("train", nrow(df_train))
test <- rep("test", nrow(df_test))

train_flag <- as.data.frame(train)
test_flag <- as.data.frame(test)
names(train_flag)<-c("flag_train_test")
names(test_flag)<-c("flag_train_test")

flag_train_test <- rbind(train_flag, test_flag)

#add the flag variable to the merged data set

new_df <- cbind(new_df,flag_train_test)

# write the data set to a csv file 

write.csv(new_df,"C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/new_df_activities_flag.csv", row.names = TRUE)

# Appropriately labels the data set with descriptive variable names.
# the variables names were changed to by more descriptive although the current format is relatively ok
names <- names(new_df)
names <- as.vector(t(names))                   
corrected_names <- gsub("^t","time_",names) 
corrected_names <- gsub("flag","data_flag",corrected_names) 
corrected_names <- gsub("^f","frequency_",corrected_names) 
corrected_names <- gsub("Acc","_Accelaration",corrected_names) 
corrected_names <- gsub("-","_",corrected_names) 
corrected_names <- gsub("\\()","",corrected_names) 
corrected_names <- gsub("Gyro","_Gyro",corrected_names) 
corrected_names <- gsub("Jerk","_Jerk",corrected_names) 
corrected_names <- gsub("Freq","_Frequency",corrected_names) 

names(new_df)<-corrected_names 
write.csv(new_df,"C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/new_df_activities_flag_corrected.csv", row.names = FALSE)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# adding subject_number to the merged data set 
train_subject <- read.table(file="C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/train/subject_train.txt", sep="\t", quote="", comment.char="") 
test_subject <- read.table(file="C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/test/subject_test.txt", sep="\t", quote="", comment.char="") 
df_subject <- rbind(train_subject,test_subject)
names(df_subject)<-c("subject")
nrow(df_subject)
ncol(df_subject)
new_df <- read.csv("C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/new_df_activities_flag_corrected.csv", header = TRUE, sep = ",", dec = ".")
new_df2 <- cbind(new_df, df_subject)


# create a new variable combining subject and activity
new_df2$subject_activity <- paste0(new_df2$subject,"_",new_df2$activities)

# average over the columns based on groups from the new variables 
group_df <- aggregate(new_df2[, 1:79], list(new_df2$subject_activity), mean)
head(group_df)
write.csv(group_df,"C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/mean_group_df.csv", row.names = FALSE)


x =read.csv("C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/mean_group_df.csv", header= TRUE)
write.table(x,"C:/Users/sigalk/Documents/GitHub/data_course/UCI_HAR_Dataset/mean_group_df.txt", row.names = FALSE)