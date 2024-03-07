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
hist(bart_model$prob.test.mean)

library(pROC)
?roc
bart_roc_val = roc(y_val$loan_status ~ bart_model$prob.test.mean, print.auc = TRUE, plot = TRUE)
bart_roc_train = roc(y_train$loan_status ~ bart_model$prob.train.mean, print.auc = TRUE, plot = TRUE)


write.csv(bart_model$prob.test.mean, "bart_phat_val.csv")

predictions = predict(bart_model, X_val)
sum((predictions$prob.test.mean - bart_model$prob.test.mean)<0.00000001)

mean_var_count = colMeans(bart_model$varcount)
plot(mean_var_count)
barplot(sort(mean_var_count))
write.csv(mean_var_count, "mean_var_counts.csv")

mean(bart_model$treedraws$cutpoints$sub_grade)
sum(bart_model$varcount.mean == mean_var_count)

