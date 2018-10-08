#load 
# read train data
X_train <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/train/subject_train.txt")

# read test data
X_test <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/test/Y_test.txt")
sub_test <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/test/subject_test.txt")

#read description & labels
variable_names <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/UCI HAR Dataset/activity_labels.txt")

library(dplyr)
#1.- Merges the training and the test
X_whole<-rbind(X_train,X_test)
Y_whole<-rbind(Y_train,Y_test)
sub_whole<-rbind(sub_train,sub_test)

#2.-Extracts only the measurements on the mean and standard deviation for each measurement.
selected_var <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
X_whole <- X_whole[,selected_var[,1]]

#3.-Uses descriptive activity names to name the activities in the data set
colnames(Y_whole) <- "activity"
Y_whole$activitylabel <- factor(Y_whole$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_whole[,-1]

#4.-Appropriately labels the data set with descriptive variable names.
colnames(X_whole) <- variable_names[selected_var[,1],2]

#5.-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
colnames(sub_whole) <- "subject"
total <- cbind(X_whole, activitylabel, sub_whole)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "C:/Users/GUSTAVO/Documents/Doctorado/1 semestre/Zeus assignment/R programing/R/Clean data/tidy.txt", row.names = FALSE, col.names = TRUE)
