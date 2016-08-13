CodeBook

The data contains experiments conducted on group of 30 individuals. These dataset are divided into two sets: test and training with each sets 
containg Activities, Subjects, and Features.

Activities : Activity dataset is named as y_train.txt for training and y_test.txt for test. Both of these datasets contains the activties the individual
             performed which are numbered from 1 to 6.

             There is also a final named activity-lables.txt which describes what these numbers represent.

             1 WALKING
             2 WALKING_UPSTAIRS
			 3 WALKING_DOWNSTAIRS
			 4 SITTING
			 5 STANDING
			 6 LAYING

Subjects : Subject dataset is named as subject_train.txt for training and subject_test.txt for test. Both of these datasets contains numbers from
		   1 to 30. Each number represent the individual/person that is being experimented.


Features : Features are dataset is named as X_train.txt for training and X_test.txt for test. These datasets contains the numerical values of all the 			   features obtained from accelerometer and gyroscope. The complete list of variables names of these features are availabe in text file named
		   features.txt with a total number of 561 features. Some of the characteristics and names of these features are explained below.

	        These signals were used to estimate variables of the feature vector for each pattern:  
			'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

			tBodyAcc-XYZ
			tGravityAcc-XYZ
			tBodyAccJerk-XYZ
			tBodyGyro-XYZ
			tBodyGyroJerk-XYZ
			tBodyAccMag
			tGravityAccMag
			tBodyAccJerkMag
			tBodyGyroMag
			tBodyGyroJerkMag
			fBodyAcc-XYZ
			fBodyAccJerk-XYZ
			fBodyGyro-XYZ
			fBodyAccMag
			fBodyAccJerkMag
			fBodyGyroMag
			fBodyGyroJerkMag

			The set of variables that were estimated from these signals are: 

			mean(): Mean value
			std(): Standard deviation
			mad(): Median absolute deviation 
			max(): Largest value in array
			min(): Smallest value in array
			sma(): Signal magnitude area
			energy(): Energy measure. Sum of the squares divided by the number of values. 
			iqr(): Interquartile range 
			entropy(): Signal entropy
			arCoeff(): Autorregresion coefficients with Burg order equal to 4
			correlation(): correlation coefficient between two signals
			maxInds(): index of the frequency component with largest magnitude
			meanFreq(): Weighted average of the frequency components to obtain a mean frequency
			skewness(): skewness of the frequency domain signal 
			kurtosis(): kurtosis of the frequency domain signal 
			bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
			angle(): Angle between to vectors.

			Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

			gravityMean
			tBodyAccMean
			tBodyAccJerkMean
			tBodyGyroMean
			tBodyGyroJerkMean

TRANSFORMATIONS:
The first step was to remove the partition of test and training and merge both of them in a single dataframe and seperate files named as activity, subjects and features.

The dataframes created by merging the training and test partitions had no variable names. In the second step, each dataframe were given appropriated variables names. Subject dataframe was given a variable named "subject". Activity dataframe was given a variable named "activity". Features dataframe were given 561 variable names contained in the file named "feature.txt"

In the third step all the activity numbers were replaced by the descriptive labels.

In the fourth steps all the dataframes of activity,subjects and features were combined by columns to create a single dataset.

In the fifth steps the feature variables were replaced by more descriptive labels to remove any ambiguous variables.
1. Acc was replaced by Acceloremeter.
2. Freq was replaced by Frequency.
3. Mag was replaced by Magnitude.
4. Gyro was replaced by Gyroscope.
5. t was replaced by Time.
6. f was replaced by Frequency.

In the final step the data was grouped by Activity and Subjects to calculate the mean of all the features based on the combinations of these two variables.

