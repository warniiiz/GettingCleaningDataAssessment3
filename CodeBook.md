### Code book introduction

The code book contains:
1. Information about the variables (including units)
1. Information about the summary choices I made
1. Information about the experimental study design I used


### Data Set Description

#### Location

The dataset represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data set has been stored in the `UCI HAR Dataset/` directory of this repo.


#### Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about the original dataset. 


#### Attribute Information

For each record it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.


#### Files in the original dataset 

* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 



### Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt' (in the original dataset directory).



### Work/Transformations

#### Summary of the applied transformations

I applied the following tranformations to the raw data in order to get a tidy dataset:
1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement. 
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names. 
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#### Merges the training and the test sets to create one data set

Note that we consider that the dataset has been stored in the `UCI HAR Dataset/` directory. We will first load all the different files into R environment, and then merge all the dataset in a unique one.

`read.table` is used to load the data from text files to R environment. Train and test data are loaded from respectively train and test directories. Each directories containing 3 files : the first one for the data, the second one for the activities and the third one for the subjects.

```
dTestData      <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
dTestLabels    <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
dTestSubjects  <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
dTrainData     <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
dTrainLabels   <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
dTrainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
```

Then `dAllData` is a merge of all the above 6 datasets (column binding between activities, subjects and raw data ; and then row binding between train and test datasets).

```
dAllData <- rbind(
                cbind(dTestLabels, dTestSubjects, dTestData), 
                cbind(dTrainLabels, dTrainSubjects, dTrainData)
            )
```

#### Extracts only the measurements on the mean and standard deviation for each measurement

Functions `mean()` and `sd()` are used with `sapply()` on `dAllData` dataset in order to extract the requested measurements. 
* `dAllDataMean` contains the mean for each measurement
* `dAllDataSd` contains the standard deviation for each measurement

```
dAllDataMean <- sapply(dAllData, mean, na.rm=TRUE)
dAllDataSd   <- sapply(dAllData, sd,   na.rm=TRUE)
```


#### Uses descriptive activity names to name the activities in the data set

The activity names are loaded from the `activity_labels.txt` file (in the raw data directory). The figures coming from of the `dTestLabels` and `dTrainLabels` datasets are replaced by the corresponding names:

```
activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character")
dAllData$V1   <- factor(dAllData$V1, levels=activities$V1, labels=activities$V2)
```


#### Appropriately labels the data set with descriptive variable names

The labels of each measurement are loaded from the `features.txt` file (in the raw data directory) and applied to the corresopnding column names of the `dAllData` dataset. The first 2 columns (which contains `Activity` and `Subject` values) are also manually named.

```
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character")
colnames(dAllData) <- c("Activity", "Subject", features$V2)
```


#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The function `aggregate` has been used to split the data into subsets, compute summary statistics for each (in our case it computes the `mean` value for each subset), and return the result in a convenient form. Note that the first 2 columns are the Activity and the Subject, so it make no sense to calculate the mean on these columns. The subset are defined with the argument `by`. As asked, I grouped the data by activity and by subject. `dTidyData` is the resulting dataset.

```
dTidyData <- aggregate(dAllData[, 3:563], by=list(dAllData$Activity, dAllData$Subject), mean)
colnames(dTidyData)[1:2] <- c("GroupByActivity", "GroupBySubject")
```


#### Saves Tidy data set under "./tidy_data_set.csv"

The last activity has not been explicitely asked for this assessment. The goal is to save the resulting datasets in 2 files : 
* `./tidy_data_set.csv` : contains the final tidy dataset;
* `./raw_data_set.csv` : contains the raw dataset with proper labels and activity names.

```
write.table(dTidyData, file="./tidy_data_set.csv", sep=";", row.names = FALSE, col.names = TRUE)
write.table(dAllData, file="./raw_data_set.csv", sep=";", row.names = FALSE, col.names = TRUE)
```


