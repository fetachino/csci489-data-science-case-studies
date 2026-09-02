# Load dataset
iris_data <- read.csv("iris.data", header = FALSE)

# Assign column names
colnames(iris_data) <- c("SepalLength", "SepalWidth",
                         "PetalLength", "PetalWidth", "Species")

cat("Dataset Dimensions:\n")
print(dim(iris_data))

cat("\nColumn Names:\n")
print(names(iris_data))

cat("\nMean Values:\n")
print(colMeans(iris_data[,1:4]))

cat("\nMinimum Values:\n")
print(apply(iris_data[,1:4], 2, min))

cat("\nMaximum Values:\n")
print(apply(iris_data[,1:4], 2, max))

cat("\nStandard Deviation:\n")
print(apply(iris_data[,1:4], 2, sd))

cat("\nMissing Values Count:\n")
print(sum(is.na(iris_data)))

setosa <- subset(iris_data, Species == "Iris-setosa")
cat("\nNumber of Setosa samples:\n")
print(nrow(setosa))

png("scatter_plot.png")
plot(iris_data$PetalLength, iris_data$PetalWidth,
     main="Petal Length vs Petal Width",
     xlab="Petal Length",
     ylab="Petal Width")
dev.off()

png("boxplot.png")
boxplot(SepalLength ~ Species, data=iris_data,
        main="Sepal Length by Species")
dev.off()

cat("\nCorrelation Matrix:\n")
print(cor(iris_data[,1:4]))
