Import Data
-----------

    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    features <- read.table("./UCI HAR Dataset/features.txt")
    train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
    train_y <- read.table("C:./UCI HAR Dataset/train/y_train.txt")
    train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    test_X <- read.table("C:./UCI HAR Dataset/test/X_test.txt")
    test_y <- read.table("C:./UCI HAR Dataset/test/y_test.txt")
    test_subject <- read.table("C:./UCI HAR Dataset/test/subject_test.txt")

Define variable for subsetting
------------------------------

*column\_subset* is used to find all of the column variables that
represent a previously computed mean or standard deviation. Importatnly
the “-” character helps to specify to occurences where the variable is
**Not** a function of the mean or standard deviation.

    #Keep only columns with mean and std, without selecting f(mean|std)
    column_subset <- grep("-[Mm]ean|-[Ss]td", features[[2]])

Combine subjects, data, and labels for test and training
--------------------------------------------------------

Here we append the unique subject identifying vector to the left hand
side of the data tables, we rename the column headings so they match the
features.txt, we add labels to the dataset, and we take the subset of
the data to capture vectors representing means and standard deviations.

    #Treat train data
    colnames(train_X) <- features[[2]]
    colnames(train_y)<- "label_num"
    train_X <- train_X[,column_subset]
    train <- cbind(train_X, train_y)
    train <- cbind(train_subject, train)

We repeat the same procedure here for the test data.

    #Treat test data
    colnames(test_X) <- features[[2]]
    colnames(test_y)<- "label_num"
    test_X <- test_X[,column_subset]
    test <- cbind(test_X, test_y)
    test <- cbind(test_subject, test)

We now combine the test and train data

    #Create combined data table
    data <- rbind(train, test)

First tidy datatset
-------------------

The subject column is propely labled as it was the only column without a
proper label. Now we add a vector for activity labels that corresponds
with the *label\_num* variable. Then we drop the *label\_num* variable
as to not be redundant.

    colnames(data)[1] <- "subject"
    data_tidy1 <- data %>% 
          mutate(label = activity_labels[[2]][label_num]) %>% 
          select(-(label_num))
    print(tbl_df(data_tidy1))

    ## # A tibble: 10,299 x 81
    ##    subject `tBodyAcc-mean(~ `tBodyAcc-mean(~ `tBodyAcc-mean(~ `tBodyAcc-std()~
    ##      <int>            <dbl>            <dbl>            <dbl>            <dbl>
    ##  1       1            0.289         -0.0203            -0.133           -0.995
    ##  2       1            0.278         -0.0164            -0.124           -0.998
    ##  3       1            0.280         -0.0195            -0.113           -0.995
    ##  4       1            0.279         -0.0262            -0.123           -0.996
    ##  5       1            0.277         -0.0166            -0.115           -0.998
    ##  6       1            0.277         -0.0101            -0.105           -0.997
    ##  7       1            0.279         -0.0196            -0.110           -0.997
    ##  8       1            0.277         -0.0305            -0.125           -0.997
    ##  9       1            0.277         -0.0218            -0.121           -0.997
    ## 10       1            0.281         -0.00996           -0.106           -0.995
    ## # ... with 10,289 more rows, and 76 more variables: `tBodyAcc-std()-Y` <dbl>,
    ## #   `tBodyAcc-std()-Z` <dbl>, `tGravityAcc-mean()-X` <dbl>,
    ## #   `tGravityAcc-mean()-Y` <dbl>, `tGravityAcc-mean()-Z` <dbl>,
    ## #   `tGravityAcc-std()-X` <dbl>, `tGravityAcc-std()-Y` <dbl>,
    ## #   `tGravityAcc-std()-Z` <dbl>, `tBodyAccJerk-mean()-X` <dbl>,
    ## #   `tBodyAccJerk-mean()-Y` <dbl>, `tBodyAccJerk-mean()-Z` <dbl>,
    ## #   `tBodyAccJerk-std()-X` <dbl>, `tBodyAccJerk-std()-Y` <dbl>,
    ## #   `tBodyAccJerk-std()-Z` <dbl>, `tBodyGyro-mean()-X` <dbl>,
    ## #   `tBodyGyro-mean()-Y` <dbl>, `tBodyGyro-mean()-Z` <dbl>,
    ## #   `tBodyGyro-std()-X` <dbl>, `tBodyGyro-std()-Y` <dbl>,
    ## #   `tBodyGyro-std()-Z` <dbl>, `tBodyGyroJerk-mean()-X` <dbl>,
    ## #   `tBodyGyroJerk-mean()-Y` <dbl>, `tBodyGyroJerk-mean()-Z` <dbl>,
    ## #   `tBodyGyroJerk-std()-X` <dbl>, `tBodyGyroJerk-std()-Y` <dbl>,
    ## #   `tBodyGyroJerk-std()-Z` <dbl>, `tBodyAccMag-mean()` <dbl>,
    ## #   `tBodyAccMag-std()` <dbl>, `tGravityAccMag-mean()` <dbl>,
    ## #   `tGravityAccMag-std()` <dbl>, `tBodyAccJerkMag-mean()` <dbl>,
    ## #   `tBodyAccJerkMag-std()` <dbl>, `tBodyGyroMag-mean()` <dbl>,
    ## #   `tBodyGyroMag-std()` <dbl>, `tBodyGyroJerkMag-mean()` <dbl>,
    ## #   `tBodyGyroJerkMag-std()` <dbl>, `fBodyAcc-mean()-X` <dbl>,
    ## #   `fBodyAcc-mean()-Y` <dbl>, `fBodyAcc-mean()-Z` <dbl>,
    ## #   `fBodyAcc-std()-X` <dbl>, `fBodyAcc-std()-Y` <dbl>,
    ## #   `fBodyAcc-std()-Z` <dbl>, `fBodyAcc-meanFreq()-X` <dbl>,
    ## #   `fBodyAcc-meanFreq()-Y` <dbl>, `fBodyAcc-meanFreq()-Z` <dbl>,
    ## #   `fBodyAccJerk-mean()-X` <dbl>, `fBodyAccJerk-mean()-Y` <dbl>,
    ## #   `fBodyAccJerk-mean()-Z` <dbl>, `fBodyAccJerk-std()-X` <dbl>,
    ## #   `fBodyAccJerk-std()-Y` <dbl>, `fBodyAccJerk-std()-Z` <dbl>,
    ## #   `fBodyAccJerk-meanFreq()-X` <dbl>, `fBodyAccJerk-meanFreq()-Y` <dbl>,
    ## #   `fBodyAccJerk-meanFreq()-Z` <dbl>, `fBodyGyro-mean()-X` <dbl>,
    ## #   `fBodyGyro-mean()-Y` <dbl>, `fBodyGyro-mean()-Z` <dbl>,
    ## #   `fBodyGyro-std()-X` <dbl>, `fBodyGyro-std()-Y` <dbl>,
    ## #   `fBodyGyro-std()-Z` <dbl>, `fBodyGyro-meanFreq()-X` <dbl>,
    ## #   `fBodyGyro-meanFreq()-Y` <dbl>, `fBodyGyro-meanFreq()-Z` <dbl>,
    ## #   `fBodyAccMag-mean()` <dbl>, `fBodyAccMag-std()` <dbl>,
    ## #   `fBodyAccMag-meanFreq()` <dbl>, `fBodyBodyAccJerkMag-mean()` <dbl>,
    ## #   `fBodyBodyAccJerkMag-std()` <dbl>, `fBodyBodyAccJerkMag-meanFreq()` <dbl>,
    ## #   `fBodyBodyGyroMag-mean()` <dbl>, `fBodyBodyGyroMag-std()` <dbl>,
    ## #   `fBodyBodyGyroMag-meanFreq()` <dbl>, `fBodyBodyGyroJerkMag-mean()` <dbl>,
    ## #   `fBodyBodyGyroJerkMag-std()` <dbl>,
    ## #   `fBodyBodyGyroJerkMag-meanFreq()` <dbl>, label <fct>

Second tidy dataset
-------------------

First we group the dataset by subject and label so the mean will be
taken across variables that share group headers. Next we collapse the
table to display the means with the summarize function, and then we
arrange by subject.

    data_tidy2 <- data_tidy1 %>%
          group_by(subject, label) %>% 
          summarize_all(mean) %>% 
          arrange(subject)
    print(data_tidy2)

    ## # A tibble: 180 x 81
    ## # Groups:   subject [30]
    ##    subject label `tBodyAcc-mean(~ `tBodyAcc-mean(~ `tBodyAcc-mean(~
    ##      <int> <fct>            <dbl>            <dbl>            <dbl>
    ##  1       1 LAYI~            0.222         -0.0405           -0.113 
    ##  2       1 SITT~            0.261         -0.00131          -0.105 
    ##  3       1 STAN~            0.279         -0.0161           -0.111 
    ##  4       1 WALK~            0.277         -0.0174           -0.111 
    ##  5       1 WALK~            0.289         -0.00992          -0.108 
    ##  6       1 WALK~            0.255         -0.0240           -0.0973
    ##  7       2 LAYI~            0.281         -0.0182           -0.107 
    ##  8       2 SITT~            0.277         -0.0157           -0.109 
    ##  9       2 STAN~            0.278         -0.0184           -0.106 
    ## 10       2 WALK~            0.276         -0.0186           -0.106 
    ## # ... with 170 more rows, and 76 more variables: `tBodyAcc-std()-X` <dbl>,
    ## #   `tBodyAcc-std()-Y` <dbl>, `tBodyAcc-std()-Z` <dbl>,
    ## #   `tGravityAcc-mean()-X` <dbl>, `tGravityAcc-mean()-Y` <dbl>,
    ## #   `tGravityAcc-mean()-Z` <dbl>, `tGravityAcc-std()-X` <dbl>,
    ## #   `tGravityAcc-std()-Y` <dbl>, `tGravityAcc-std()-Z` <dbl>,
    ## #   `tBodyAccJerk-mean()-X` <dbl>, `tBodyAccJerk-mean()-Y` <dbl>,
    ## #   `tBodyAccJerk-mean()-Z` <dbl>, `tBodyAccJerk-std()-X` <dbl>,
    ## #   `tBodyAccJerk-std()-Y` <dbl>, `tBodyAccJerk-std()-Z` <dbl>,
    ## #   `tBodyGyro-mean()-X` <dbl>, `tBodyGyro-mean()-Y` <dbl>,
    ## #   `tBodyGyro-mean()-Z` <dbl>, `tBodyGyro-std()-X` <dbl>,
    ## #   `tBodyGyro-std()-Y` <dbl>, `tBodyGyro-std()-Z` <dbl>,
    ## #   `tBodyGyroJerk-mean()-X` <dbl>, `tBodyGyroJerk-mean()-Y` <dbl>,
    ## #   `tBodyGyroJerk-mean()-Z` <dbl>, `tBodyGyroJerk-std()-X` <dbl>,
    ## #   `tBodyGyroJerk-std()-Y` <dbl>, `tBodyGyroJerk-std()-Z` <dbl>,
    ## #   `tBodyAccMag-mean()` <dbl>, `tBodyAccMag-std()` <dbl>,
    ## #   `tGravityAccMag-mean()` <dbl>, `tGravityAccMag-std()` <dbl>,
    ## #   `tBodyAccJerkMag-mean()` <dbl>, `tBodyAccJerkMag-std()` <dbl>,
    ## #   `tBodyGyroMag-mean()` <dbl>, `tBodyGyroMag-std()` <dbl>,
    ## #   `tBodyGyroJerkMag-mean()` <dbl>, `tBodyGyroJerkMag-std()` <dbl>,
    ## #   `fBodyAcc-mean()-X` <dbl>, `fBodyAcc-mean()-Y` <dbl>,
    ## #   `fBodyAcc-mean()-Z` <dbl>, `fBodyAcc-std()-X` <dbl>,
    ## #   `fBodyAcc-std()-Y` <dbl>, `fBodyAcc-std()-Z` <dbl>,
    ## #   `fBodyAcc-meanFreq()-X` <dbl>, `fBodyAcc-meanFreq()-Y` <dbl>,
    ## #   `fBodyAcc-meanFreq()-Z` <dbl>, `fBodyAccJerk-mean()-X` <dbl>,
    ## #   `fBodyAccJerk-mean()-Y` <dbl>, `fBodyAccJerk-mean()-Z` <dbl>,
    ## #   `fBodyAccJerk-std()-X` <dbl>, `fBodyAccJerk-std()-Y` <dbl>,
    ## #   `fBodyAccJerk-std()-Z` <dbl>, `fBodyAccJerk-meanFreq()-X` <dbl>,
    ## #   `fBodyAccJerk-meanFreq()-Y` <dbl>, `fBodyAccJerk-meanFreq()-Z` <dbl>,
    ## #   `fBodyGyro-mean()-X` <dbl>, `fBodyGyro-mean()-Y` <dbl>,
    ## #   `fBodyGyro-mean()-Z` <dbl>, `fBodyGyro-std()-X` <dbl>,
    ## #   `fBodyGyro-std()-Y` <dbl>, `fBodyGyro-std()-Z` <dbl>,
    ## #   `fBodyGyro-meanFreq()-X` <dbl>, `fBodyGyro-meanFreq()-Y` <dbl>,
    ## #   `fBodyGyro-meanFreq()-Z` <dbl>, `fBodyAccMag-mean()` <dbl>,
    ## #   `fBodyAccMag-std()` <dbl>, `fBodyAccMag-meanFreq()` <dbl>,
    ## #   `fBodyBodyAccJerkMag-mean()` <dbl>, `fBodyBodyAccJerkMag-std()` <dbl>,
    ## #   `fBodyBodyAccJerkMag-meanFreq()` <dbl>, `fBodyBodyGyroMag-mean()` <dbl>,
    ## #   `fBodyBodyGyroMag-std()` <dbl>, `fBodyBodyGyroMag-meanFreq()` <dbl>,
    ## #   `fBodyBodyGyroJerkMag-mean()` <dbl>, `fBodyBodyGyroJerkMag-std()` <dbl>,
    ## #   `fBodyBodyGyroJerkMag-meanFreq()` <dbl>
