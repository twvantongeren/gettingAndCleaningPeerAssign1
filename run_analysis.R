# This file will perform all the data cleaning steps in order to
# get the data file uploaded to the Coursera dialog.

# first I will get the information from the zipfile which have to be merged 
# I do the test and train part seperately
unzHndlTstNum<-unz("getdata_projectfiles_UCI HAR Dataset.zip", "UCI HAR Dataset/test/X_test.txt")
unzHndlTstAct<-unz("getdata_projectfiles_UCI HAR Dataset.zip", "UCI HAR Dataset/test/y_test.txt")
unzHndlTstSub<-unz("getdata_projectfiles_UCI HAR Dataset.zip", "UCI HAR Dataset/test/subject_test.txt")

num<-read.table(unzHndlTstNum, header = FALSE)
act<-read.table(unzHndlTstAct, header = FALSE)
sub<-read.table(unzHndlTstSub, header = FALSE)

unlink(unzHndlTstNum)
unlink(unzHndlTstAct)
unlink(unzHndlTstSub)

# now add the column with information about the activities 
# to the numerical measurements of the sensors
# the column is added to the right otherwise
# all the index numbers of the activities are shifted.
numAct<-cbind(num, act)

# bind a new column to the set with the subjects(person id' actually)
numActSub<-cbind(numAct, sub)

# rename
testMerged<-numActSub

# remove the originally read data 
rm(num)
rm(act)
rm(sub)
rm(numAct)
rm(numActSub)

# remove file handles
rm(unzHndlTstNum, unzHndlTstAct, unzHndlTstSub)


# Exactly the same is done for the train data set...

# I do the test and train part seperately
unzHndlTrnNum<-unz("getdata_projectfiles_UCI HAR Dataset.zip", "UCI HAR Dataset/train/X_train.txt")
unzHndlTrnAct<-unz("getdata_projectfiles_UCI HAR Dataset.zip", "UCI HAR Dataset/train/y_train.txt")
unzHndlTrnSub<-unz("getdata_projectfiles_UCI HAR Dataset.zip", "UCI HAR Dataset/train/subject_train.txt")

num<-read.table(unzHndlTrnNum, header = FALSE)
act<-read.table(unzHndlTrnAct, header = FALSE)
sub<-read.table(unzHndlTrnSub, header = FALSE)

unlink(unzHndlTrnNum)
unlink(unzHndlTrnAct)
unlink(unzHndlTrnSub)

# now add the column with information about the activities 
# to the numerical measurements of the sensors
numAct<-cbind(num, act)

# bind a new column to the set with the subjects (person id)
numActSub<-cbind(numAct, sub)

# rename the dataframe
trainMerged<-numActSub

# remove the originally read data 
rm(num)
rm(act)
rm(sub)
rm(numAct)
rm(numActSub)

# remove the file handles
rm(unzHndlTrnNum, unzHndlTrnAct, unzHndlTrnSub)

# merge the test and train data to get one data frame which can be
mergedData<-rbind(testMerged, trainMerged)

rm(testMerged, trainMerged)

# put labels on the last 2 columns
colnames(mergedData)[length(mergedData)]<-"subject"
colnames(mergedData)[length(mergedData)-1]<-"activityNum"

# I know I only want columns which have the mean and stdev for every
# measurement, but the columns of the merged dataframe are not labeled. 
# I will first load these labels from features.txt
unzHndlFeatures<-unz("getdata_projectfiles_UCI HAR Dataset.zip", "UCI HAR Dataset/features.txt")
featuresLabels<-read.table(unzHndlFeatures, header = FALSE)
unlink(unzHndlFeatures)
rm(unzHndlFeatures)
# From the raw file it still is a dataframe, here I convert it
# to a vector of character strings
featuresLabels<-as.character(featuresLabels$V2)

# grep strips the fourier transformed columns by demanding that the label starts with t ("^t")
# then it just scans on the words mean or Mean or Std or std.
# if it is a mean or a stdev we want to have it in the filter.
# filter now holds true only for columns which we want to have 
# so filter[1] = T  means we want column 1 filter[7]=F means we want to delete column 7
filter<-grepl( "^t.*[Mm]ean", featuresLabels) | grepl("^t.*[Ss]td", featuresLabels)

# if the filter is true I want a to put the index number of that
# location in the filter vector in the keepCol vector
# beware that the filter vector is shorter than the number of columns in the
# mergedData frame, and these 2 extra columns in the dataframe
# are the added columns, which subset will also add.
keepCol = subset(1:length(mergedData), filter) 

# subselect only the right columns
subsetData<-mergedData[keepCol]
rm(mergedData)

# There are not so many activities, which makes it possible to
# replace the labels by hand.
# The activity_labels.txt file contains the labels and
# one can know this by reading the README.txt
subsetData$activityNum<-sub(1, "WALKING", subsetData$activityNum)
subsetData$activityNum<-sub(2, "WALKING_UPSTAIRS", subsetData$activityNum)
subsetData$activityNum<-sub(3, "WALKING_DOWNSTAIRS", subsetData$activityNum)
subsetData$activityNum<-sub(4, "SITTING", subsetData$activityNum)
subsetData$activityNum<-sub(5, "STANDING", subsetData$activityNum)
subsetData$activityNum<-sub(6, "LAYING", subsetData$activityNum)

# The for loop skips the last two rows, otherwise the
# labels activityNum and subject would be overwritten
for (rowSelect in 1:(length(keepCol)-2))
{ 
    colnames(subsetData)[rowSelect]<-featuresLabels[keepCol[rowSelect]]
}

# The data already is in a form in which there is a subject and activity.
# However if for one subject and one activity is more than one value
# we want to take the mean and put this in one row.
meanForCombOfPersonActivity<-aggregate( .~ activityNum+subject, subsetData, mean)

# Write the table to disk with filename "result.txt", this is the
# file uploaded to the coursera text box
write.table(meanForCombOfPersonActivity, file="result.txt" ,row.name=FALSE)

