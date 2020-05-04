#Project - Analysis.R

#read in data descriptors
activity_labels <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/activity_labels.txt")
features <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/features.txt")

#read in all data and data labels
train_X <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/train/X_train.txt")
train_y <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/train/y_train.txt")
train_subject <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/train/subject_train.txt")
test_X <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/test/X_test.txt")
test_y <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/test/y_test.txt")
test_subject <- fread("C:/Users/michaelvolk/Desktop/datasciencecoursera/R/Getting_and_Cleaning_Data/UCI HAR Dataset/test/subject_test.txt")

#Keep only columns with mean and std, without selecting f(mean|std)
column_subset <- grep("-[Mm]ean|-[Ss]td", features[[2]])
#provide column labels to training data
colnames(train_X) <- features[[2]]
colnames(train_y)<- "label_num"
train_X <- train_X[,column_subset, with =FALSE]
train <- cbind(train_X, train_y)
train <- cbind(train_subject, train)

#provide column labels to test data
colnames(test_X) <- features[[2]]
colnames(test_y)<- "label_num"
test_X <- test_X[,column_subset, with =FALSE]
test <- cbind(test_X, test_y)
test <- cbind(test_subject, test)

#Create combined data table
data <- rbind(train, test)
colnames(data)[1] <- "subject"
data_tidy1 <- data %>% 
      mutate(label = activity_labels[[2]][label_num]) %>% 
      select(-(label_num)) 

#Second tidy data set
data_tidy2 <- data_tidy1 %>%
      group_by(subject, label) %>% 
      summarize_all(mean) %>% 
      arrange(subject)



