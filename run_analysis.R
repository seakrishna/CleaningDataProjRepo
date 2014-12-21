run_analysis <- function()
{
##Load the activity labels
activitylabels <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

##Load the features
features <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")

##Train set
##Load the subject list for train data
subtrain <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

##Load the train data
trainset <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

##Load the train label data
trainLabel <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

############Test Data
##Load the sub for the test data
subtest <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

##Load the test set
testset <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

###Load the test Label
testLabel <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

##Get the names for the variables
activityNamestestLabels <- merge(testLabel, activitylabels, by.x = "V1",all = TRUE, sort = FALSE)
activityNamestrainLabels <- merge(trainLabel, activitylabels, by.x = "V1",all = TRUE, sort = FALSE)


##Train and test labels are the activity labels. 
trainsetwithactivity <- cbind(trainset,activityNamestrainLabels)
testsetwithactivity <- cbind(testset,activityNamestestLabels)

###Add the subject info
trainsetwithactivityAndSub <- cbind(trainsetwithactivity,subtrain)
testsetwithactivityAndSub <- cbind(testsetwithactivity,subtest)


## Add a column that says this belongs to the traindata or testdata incase this is needed to differentiate the data later

##Create a DF with train and test
reptrain <- data.frame(rep("train", nrow(trainsetwithactivityAndSub)))
reptest <- data.frame(rep("test", nrow(testsetwithactivityAndSub)))

##cbind this to the data
trainsetWithAllColumns <- cbind(trainsetwithactivityAndSub,reptrain)
testsetWithAllColumns <- cbind(testsetwithactivityAndSub,reptest)

##Add the headings to the two sets.
 
##Get the names from features
x <- as.vector(features[,2])
##Add the following to colnames
y <- c(x,"ActivityId", "Activity", "Subject", "DataSet")

##Set the colnames on train and test data set
colnames(trainsetWithAllColumns) <- y
colnames(testsetWithAllColumns)<- y


#mergedataset
alldataset <- rbind(trainsetWithAllColumns, trainsetWithAllColumns)


##Get only the mean() and std() cols

##Colnames
g<- colnames(alldataset)

##Find all the columns with mean() in the title
colwithmean <- grep("mean()", g)

##Find all the columns with std() in the title
colwithstd <- grep("std()", g)

##merge the cols that are neded and add the other columsn that we need like subject and activity
neededcols <- c(colwithmean, colwithstd, 562, 563, 564, 565)

##Sort the needed columns
sneededcols <- sort(neededcols)

##Subest the needed cols
neededData <- alldataset[sneededcols]

##Remove the two columns that are not needed
neededData1 <- neededData[,-80]
neededData2 <- neededData1[, -82]

##Load the reshape library
install.packages("reshape2")
library(reshape2)

##Get the columns
ncolnames <- colnames(neededData2)

##Define the id columns
id = ncolnames[80:81]

##Define the vars
var = ncolnames[1:79]

##Melt the data
dMelt <- melt(neededData2, id=id, measure.vars=var)

##Calculate means
dmean <- dcast(dMelt, Activity+Subject ~ variable, mean)


##Write out the file. 
dir <- getwd()

##Create the filename.
file <- paste(dir, "CleaningDataProjOutput.txt", sep="/")

##Write out the file
write.table(dmean, file)
}



















