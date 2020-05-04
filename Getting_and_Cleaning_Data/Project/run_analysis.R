#Project - Analysis.R

library(dplyr)
#read in data descriptors
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#read in all data and data labels
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("C:./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_X <- read.table("C:./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("C:./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("C:./UCI HAR Dataset/test/subject_test.txt")

#Keep only columns with mean and std, without selecting f(mean|std)
column_subset <- grep("-[Mm]ean|-[Ss]td", features[[2]])
colnames(train_X) <- features[[2]]
colnames(train_y)<- "label_num"
train_X <- train_X[,column_subset]
train <- cbind(train_X, train_y)
train <- cbind(train_subject, train)

#provide column labels to test data
colnames(test_X) <- features[[2]]
colnames(test_y)<- "label_num"
test_X <- test_X[,column_subset]
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

write.table(data_tidy2, "./Project/data_tidy2.txt", row.name = FALSE)
