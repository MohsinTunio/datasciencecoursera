# Firstly load the required packages i.e. read.table and reshape2
# read.table creates a dataframe from the data
# reshape2 package contains dcast function for  

library("data.table")
library("reshape2")

# Activity data is being loaded
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# column names are being extracted
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# 'grepl' only extracts patterns as suggested i.e. on the mean and standard deviation.
extract_features <- grepl("mean|std", features)

# Loading X_test and y_test data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

# Extracting mean and standard deviation datan only.
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# rbind function binds two vectors/datsets: as.data.table checks if subject_train is a data table
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# rbind function binds two vectors/datsets
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

#dcast function function substantiates the feed for 'tapply' 
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

# tidy_data is saved as tidy_data.txt in the working directory
write.table(tidy_data, file = "./tidy_data.txt") 