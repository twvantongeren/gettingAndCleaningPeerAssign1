Description of variables
========================

_The variables in the rows:_

Variable: *subject* Indicates a participant in the research.
Instead of using names for participants in the
research, numbers are used to identify each person. 
The class of this variable is a factor.
Since 30 persons have participated in the research
the values of this variable ranges from 1 to 30.

Variable: *activityNum* This variable is used to indicate
which activity is done, the activity is written as a descriptive word
in caps, the possibilities are:
"WALKING"
"WALKING_UPSTAIRS"
"WALKING_DOWNSTAIRS"
"SITTING"
"STANDING"
"LAYING"
The class of this variable is a factor.

_The variables in the columns:_

_What the values are_
The smartphone detectors can measure at 50 Hz which implies that it makes
50 measurements in one second.
For one time window which lasts for 2.65 seconds the mean and standard deviation
is calculated, for every new row the window is shifted 1.325 seconds.
One window contains $ 50 \times 2.65 = 128 $ measurements.

If the variable contains the mean() tag the mean of the 128 measurements is taken.
If the variable contains the std() tag the standard deviation of the 128 measurements is taken.

All window snapshots are normalized such that the values lie between [-1,1].

X, Y, and Z indicate the axis in which the acceleration is measured.
The bodyGyro tag indicates the data are from the gyroscope which measures the angular
velocity of the device around the X, Y and Z axis.

The class of the data is numeric.

_Dimensions of the variables:_
For the mean the values are relative to real accelerations, and so these are [meters]/[seconds^2].
Standard deviations of the accelerations therefore 
must have dimentions $sqrt([meters]/[seconds^2])$.
For angular momenta the mean in combination with BodyGyro
comes in $[1]/[seconds^2]$ and BodyGyroStd are $[1]/[seconds]$.
The jerk is the time derivative of the acceleration and thus
the dimentions of the BodyAccJerkMean is [meters]/[seconds^3]
For the standard deviation it is $sqrt([meters]/[seconds^3])$.
The jerk.

**Values for the body acceleration:**
These values contain the mean and the standard deviation of the
acceleration measured by the accelerometer of the phone.
These are the higher frequencies of the acceleration signal.
The lower frequencies are in the GravityAcc part which comes next.
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
These values are numerical values which vary between -1 and 1.

**Values for the body gravity acceleration**
These values are all accelerations of the phone with the high frequencies
filtered out ( above 0.3Hz are filtered out ).
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
These values are numerical values and vary between -1 and 1.

**Values for the Jerk**
These values contain the change in acceleration which can be found
by taking the acceleration and differentiating this to time.
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z

**Values for the axial speed**
The phone can measure its axial velocity, and it can do this
for 3 different principal axis, for all 3 datasets the standard deviation
is measured.
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z

This is the change per time-unit for the values above, with standard deviation.
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z

These values are the Euclidean norm (magnitude =  $sqrt(x^2+y^2+z^2)$ ) 
of the previous variables, also with standard deviation.
tBodyAccMag-mean()
tBodyAccMag-std()
tGravityAccMag-mean()
tGravityAccMag-std()
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyGyroMag-mean()
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()

Description of data
===================

To make this dataset 30 persons are asked to perform 6 specific actions 
( walking, walking upstairs, waling downstairs , sitting, standing , laying)
while having a smartphone attached to their body which has a
accelerometer and a gyroscope.
The accelerometer and gyroscope can record the acceleration in 3 directions and 
the speed the device rotates around 3 axis.
The smartphone saves these measurements 50 times per second.
During their activities the persons are filmed and their activities are written
down by researchers, to match the sensor outputs with the activities of the persons.

All frequencies faster than 20Hz are filtered out in order to eliminate noise.
The acceleration of the smartphone consists of different components which are already added, 
which is the gravity acceleration and the acceleration due to the movement of the person.
The researchers filtered out the higher and the lower frequencies and have split the
results of the acceleration signal into 2 different acceleration signals.
Accelerations moving faster than 0.3Hz are due to the movment of the body (human) 
acceleration moving slower than 0.3Hz are due to gravity.

Description of transformations of the data
==========================================
The measured data is stored in one zipfile which is unzipped by the "unz" function.
In the zipfile the test-data and the train data are in seperate files.

The test dataset and the train dataset are treated in the same way, they are 
done sequentially.

The readme file shows the features (which are the measurments of the
sensors in the smartphone) are in the "X_test.txt", this is stored in the "num" dataframe.
The "y_test.txt" file contains the activities and it is stored in the act dataframe.
The "subject_test.txt" file contains the id 
of the test persons and is stored in the "sub" dataframe

The activity column is placed on the right of the numeric data.
After that the id of the test person is added to the right of the resulting dataframe.

The same procedure is done for the train dataset.

The "train" dataset is placed under the test dataset, in order to get one
dataframe with all the data.
 
After that the two added columns are given descriptive names and the file is opened
with the labels of the sensor data.
This then is used to give the sensor data columns descriptive names.

The right columns are filtered out by filtering trough the descriptive names
of the sensor ( named "featuresLabels" ) to find out which columns should be kept.
It is important to know the columns of the dataset are in the same order as the
names in the "features.txt" text file.
The right columns are taken out of the dataframe and the new dataframe is named "subsetData".

Next the possible activities which have numbers are replaced by their descriptive names,
by simple substitution.

Then the column names of the sensor columns are placed in the dataframe

After this the aggregate command is used to get the mean for every combination
of activity and for every test-person.

The resulting dataframe is written to disk under the name "result.txt"

