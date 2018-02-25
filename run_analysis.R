# Firstly load the required packages i.e. read.table and reshape2
# read.table creates a dataframe from the data
# reshape2 package contains dcast function
# Data from UCI HAR Dataset are extracted and saved in a newly created folder in the working directory named as 'Course3_Project'

rm(list=ls()) # removing data already in memory
library("data.table")
library("reshape2")
library("tidyr") # although not necessary, but i was experimenting,so included it

xtest <- read.table("./Course3_Project/test/X_test.txt",header = FALSE) # Loading X_test
ytest <- read.table("./Course3_Project/test/y_test.txt",header = FALSE) #Loading y_test data
sb_test <- read.table("./Course3_Project/test/subject_test.txt",header = FALSE) # Loading subjest_test data 
ac_labels <- read.table("./Course3_Project/activity_labels.txt")[,2] # Activity data is being loaded


features <- read.table("./Course3_Project/features.txt", header = TRUE)[,2]# features are named as features


finding_features <- grepl("mean|std", features) # 'grepl' only extracts patterns as suggested i.e. on the mean and standard deviation.

names(xtest) = features

# Extracting mean and standard deviation data only.
xtest = xtest[,finding_features]

# Load activity labels
ytest[,2] = ac_labels[ytest[,1]]
names(ytest) = c("Activity_ID", "Activity_Label")
names(sb_test) = "subject"

# Bind data
test <- cbind(as.data.table(sb_test), ytest, xtest)

# fetching  both X_train & y_train data.
xtrain <- read.table("./Course3_Project/train/X_train.txt")
ytrain <- read.table("./Course3_Project/train/y_train.txt")

sb_train <- read.table("./Course3_Project/train/subject_train.txt")

names(xtrain) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
xtrain = xtrain[,finding_features]

# Load activity data
ytrain[,2] = ac_labels[ytrain[,1]]
names(ytrain) = c("Activity_ID", "Activity_Label")
names(sb_train) = "subject"

# rbind function binds two vectors/datsets: as.data.table checks if subject_train is a data table
train <- cbind(as.data.table(sb_train), ytrain, xtrain)

# rbind function binds two vectors/datsets
binddata = rbind(test, train)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
meltdata      = melt(binddata, id = id_labels, measure.vars = data_labels)

#dcast function function substantiates the feed for 'tapply' 
tidydata   = dcast(meltdata, subject + Activity_Label ~ variable, mean)

#tidy_data   = tapply(melt_data, subject + Activity_Label ~ variable, mean) didn't work

# tidy_data is saved as tidy_data.txt in the working directory
write.table(tidydata, file = "./Course3_Project/tidy_data.txt") 