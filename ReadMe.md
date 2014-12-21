The aim of this assignment was to understand the data set and merge them and extract some rows and then make a table of means.
The script does the following: 

a. Loads all the required data using the read.table
b. Gets the activity names by merging the data
c. Appends the activities to both the train and test data set
d. Appends the subject info to the train and  test data set. 
e. Added a column of the data source train or test if this was needed later.
f. Added the column labels to the train and test data set. 
g. Merge the two sets to get alldataset
h. Get all the columns that contain mean() and std() and the columns like activity and subject
i. Remove the activityID from the set. 
j. Load the reshape2 library
k. Use the melt to melt the data 
l. Use the dcast value to tabulate the data as req. 




