getwd()

# install.packages("BART")
library(BART)
help(BART)
??BART
??pbart
X_train = read.csv("lending_club/X_train.csv")
y_train = read.csv("lending_club/y_train.csv")
X_val = read.csv("lending_club/X_val.csv")
y_val = read.csv("lending_club/y_val.csv")
names(X_train)
head(X_train)

table(y_train)

bart_model = pbart(X_train, y_train$loan_status, X_val)
hist(bart_model$prob.test)

library(pROC)
?roc
bart_roc = roc(y_val$loan_status ~ bart_model$prob.test.mean, print.auc = TRUE, plot = TRUE)
