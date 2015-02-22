### Introduction

#### Purpose of this repository

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare a tidy data that can be used for later analysis. 

I am required to submit: 
1. a tidy data set as described below,
2. a link to a Github repository with your script for performing the analysis, and 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

I should also include a `README.md` (actually the file you are currently reading) in the repo with your scripts. This file explains how all of the scripts work and how they are connected.  


#### Data theme

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Note that these data are also available on this repository, in the `UCI HAR Dataset/` directory.

Please read the `CodeBook.md` for more information about the raw data and all the transformations I did.


#### Summary of the assessment goal

I should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Details about this work

#### Files list

Here are all the files you can find in this repository:
* `CodeBook.md` describes the variables, the data, and the work that I performed to clean up the raw data and get a tidy dataset
* `run_analysis.R` contains all the R code I used in order to obtain the tidy dataset from the raw data
* `tidy.csv` is the final tidy dataset I obtained from the raw data, using the above R script
* the raw dataset has been stored in `UCI HAR Dataset/` directory


#### How the R script works

Please find below a description of the `run_analysis.R` file.


##### Merges the training and the test sets to create one data set

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

##### Extracts only the measurements on the mean and standard deviation for each measurement

Functions `mean()` and `sd()` are used with `sapply()` on `dAllData` dataset in order to extract the requested measurements. 
* `dAllDataMean` contains the mean for each measurement
* `dAllDataSd` contains the standard deviation for each measurement

```
dAllDataMean <- sapply(dAllData, mean, na.rm=TRUE)
dAllDataSd   <- sapply(dAllData, sd,   na.rm=TRUE)
```


##### Uses descriptive activity names to name the activities in the data set

The activity names are loaded from the `activity_labels.txt` file (in the raw data directory). The figures coming from of the `dTestLabels` and `dTrainLabels` datasets are replaced by the corresponding names:

```
activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character")
dAllData$V1   <- factor(dAllData$V1, levels=activities$V1, labels=activities$V2)
```


##### Appropriately labels the data set with descriptive variable names

The labels of each measurement are loaded from the `features.txt` file (in the raw data directory) and applied to the corresopnding column names of the `dAllData` dataset. The first 2 columns (which contains `Activity` and `Subject` values) are also manually named.

```
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character")
colnames(dAllData) <- c("Activity", "Subject", features$V2)
```


##### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The function `aggregate` has been used to split the data into subsets, compute summary statistics for each (in our case it computes the `mean` value for each subset), and return the result in a convenient form. Note that the first 2 columns are the Activity and the Subject, so it make no sense to calculate the mean on these columns. The subset are defined with the argument `by`. As asked, I grouped the data by activity and by subject. `dTidyData` is the resulting dataset.

```
dTidyData <- aggregate(dAllData[, 3:563], by=list(dAllData$Activity, dAllData$Subject), mean)
colnames(dTidyData)[1:2] <- c("GroupByActivity", "GroupBySubject")
```


##### Saves Tidy data set under "./tidy_data_set.csv"

The last activity has not been explicitely asked for this assessment. The goal is to save the resulting datasets in 2 files : 
* `./tidy_data_set.csv` : contains the final tidy dataset;
* `./raw_data_set.csv` : contains the raw dataset with proper labels and activity names.

```
write.table(dTidyData, file="./tidy_data_set.csv", sep=";", row.names = FALSE, col.names = TRUE)
write.table(dAllData, file="./raw_data_set.csv", sep=";", row.names = FALSE, col.names = TRUE)
```
