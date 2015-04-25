run_analysis <- function(path_to_folder = 'project_dataset/') {
    # read test data
    test_set <- read.table(paste0(path_to_folder, 'test/X_test.txt'))
    test_activities <- read.table(paste0(path_to_folder, 'test/y_test.txt'))
    test_subjects <- read.table(paste0(path_to_folder, 'test/subject_test.txt'))
    test_data <- cbind(test_subjects, test_activities, test_set)
    #read train data
    train_set <- read.table(paste0(path_to_folder, 'train/X_train.txt'))
    train_activities <- read.table(paste0(path_to_folder, 'train/y_train.txt'))
    train_subjects <- read.table(paste0(path_to_folder, 'train/subject_train.txt'))
    train_data <- cbind(train_subjects, train_activities, train_set)
    # merge two data
    union <- rbind(test_data, train_data)
    # label the columns
    column_names <- read.table(paste0(path_to_folder, 'features.txt'))
    names(union) <- c('Subject', 'Activities', as.character(column_names[[2]]))
    # select only required columns
    required_col <- grepl('mean\\(\\)|std\\(\\)|^Subject$|^Activities$', names(union))
    union_selected <- union[, required_col] 
    # tidy data
    final_data <- union_selected %>% group_by(Subject,Activities) %>% summarise_each(funs(mean))
}
