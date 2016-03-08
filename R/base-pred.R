# baseline predictors

#' FUNCTION: cat_majority
#'
#' This function takes in data and the desired program to predict mutation
#' scores for and returns the accuracy when predicting majority occurrence
#'

cat_majority <- function(data, pred, col = "program", predict = "range") {
  train <- data[!(data[,col]==pred),]
  test <- data[(data[,col]==pred),]
  m <- tail(names(sort(table(train[,predict]))), 1)
  c <- length(which(test[,predict] == m))
  acc.major <- (c/nrow(test))
  return(toString(acc.major))
}

#' FUNCTION: cat_rand
#'
#' This function takes in data and the desired program to predict mutation
#' scores for and returns the accuracy when predicting random occurrences
#'

cat_rand <- function(data, pred, progcol = "program", predcol = "range") {
  test <- data[(data[,progcol]==pred),]
  elems.occ <- levels(test[,predcol])
  test$prediction <- sample(elems.occ,1, size = nrow(test))
  cm <- confusionMatrix(test[,predcol], test$prediction)
  return(cm$overall["Accuracy"])
}