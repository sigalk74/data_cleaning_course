
================================================

# This file includes a codebook for the dataset

===============================================

# DATA Description 

data file names: 

# new_df.activities_flag_corrected.csv
# mean_group_df.csv

The current data set is a cleaned and arranged data provided as a task in Coursera
The original data is the Human Activity Recognition Using Smartphones Dataset
Version 1.0 by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory. Information regarding the original dataset 
is found here: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

===================================================================================

# First data set: new_df.activities_flag_corrected.csv

# Description Of variables

The variables are means and standard deviations along the x,y and Z axes of the following features: 

time_body_acceleration - time domain signal of body acceleration 
time_gravity_accelation - time domain signal of gravity acceleration
time_body_accelaration_jerk - calculated jerk signal of time domain signal of body acceleration
time_body_gyro - time domain signal of body gyroscope 3-axial
time_body_gyro_jerk - calculated jerk signal of time domain signal of body gyroscope 3-axial
Time_body_accelartion_mag - magnitude of the time domain signal of body acceleration 


frequency_body_acceleration - frequency domain signal of body acceleration  
frequency_body_acceleration_jerk - frequency of calculated jerk signal of body acceleration  
Frequency_body_gyro - frequency of body gyroscope signal
frequency_body_accelerationMAG - magnitude of the frequency of the body acclearttion 
frequency_body_accelaration_jerkMAG - magnitude of the frequency of the body accelaartion 
frequency_body_gyroMag - magnitude of the body gyroscope signal frequesncy 
time_body_gyro_jerkMag - magnitude of the calculated jer for the body gyroscope signal


The following variables aew flag variables:

Activities - categorical variable (text). the performed activity duribg measurement. categories are: walking, walking_upstairs, walking_downstairs, sitting , standing, laying
data_flag_train_test - categorical variable differentiating between the test and the train set. categories are: test, train. 
 

# mean_group_df.csv

# Description Of variables

The variables are mean values of the variables in ew_df.activities_flag_corrected.csv by activity and respondent.  

=========================================================================

# Transformation performed on the original dataset in order to derive the new datasets 

# The performed transformations with explanations are detailed in the file data_cleaning_final_project (Rscript)


1) I Merged the training and the test sets to create one data set. Added a flag variable to flag which data is fromn the test and train datasets. 

2) I created a data set only the measurements on the mean (mean) and standard deviation (std) for each measurement. 

3) I added the descriptive activity names to name the activities in the data set by replacing the code numbers fro activities with the activity names. 

4) I changed the variable names to be more explicite and descriptive (for example the use of 'time' instead of 't').

5) From the data set in step 4, I created a second, independent tidy data set with the average of each variable for each activity and each subject (respondent). 