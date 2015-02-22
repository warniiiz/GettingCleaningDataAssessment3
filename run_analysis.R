
# 1. Loads, then merges the training and the test sets to create one data set.
dTestData      <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
dTestLabels    <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
dTestSubjects  <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
dTrainData     <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
dTrainLabels   <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
dTrainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)

dAllData <- rbind(
                cbind(dTestLabels, dTestSubjects, dTestData), 
                cbind(dTrainLabels, dTrainSubjects, dTrainData)
            )

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
dAllDataMean <- sapply(dAllData, mean, na.rm=TRUE)
dAllDataSd   <- sapply(dAllData, sd,   na.rm=TRUE)

# 3. Uses descriptive activity names to name the activities in the data set
activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character")
dAllData$V1   <- factor(dAllData$V1, levels=activities$V1, labels=activities$V2)

# 4. Appropriately labels the data set with descriptive variable names. 
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character")
colnames(dAllData) <- c("Activity", "Subject", features$V2)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
dTidyData <- aggregate(dAllData[, 3:563], by=list(dAllData$Activity, dAllData$Subject), mean)
colnames(dTidyData)[1:2] <- c("GroupByActivity", "GroupBySubject")

# Saves Tidy data set under "./tidy_data_set.csv"
write.table(dTidyData, file="./tidy_data_set.csv", sep=";", row.names = FALSE, col.names = TRUE)
write.table(dAllData, file="./raw_data_set.csv", sep=";", row.names = FALSE, col.names = TRUE)

