require(MASS)

tr <- sample(1:50, 25)
train <- rbind(iris3[tr,,1], iris3[tr,,2], iris3[tr,,3])
test <- rbind(iris3[-tr,,1], iris3[-tr,,2], iris3[-tr,,3])

cl <- factor(c(rep("s",25), rep("c",25), rep("v",25)))

L <- lda(train, cl)

rl = predict(L,test)$class

success_l = sum(rl == cl)/length(cl)


res_l = sprintf('   Success rate LDA: %5.2f%%\n', success_l*100)


cat("LDA results on Iris Dataset:\n")
cat(res_l)
