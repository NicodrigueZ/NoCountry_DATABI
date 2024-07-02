library(readr)
library(corrplot)
library(readr)
library(dplyr)
library(psych)
library(tidyverse)
library(sqldf)
library(xtable)
library(factoextra)
library(stringi)
library(plyr)  
library(rpart)
library(rpart.plot) 
library(caret)
library(ggplot2)
library(gridExtra) 
library(tidyverse) 
library(rsample)
library(e1071) 
library(GGally)
library(data.table)
library(DT)
library(readr)
library(dplyr)
library(tidyr)
library(corrplot)
#library(rms)
library(MASS)
library(e1071)
library(ROCR)
library(gplots)
library(pROC)
library(randomForest)
library(ggpubr)
library(plotly)
library(readr)
library(dplyr)
library(psych)
library(tidyverse)
library(sqldf)
library(xtable)
library(factoextra)

library(stringi)


###################################################################################################
###################################################################################################
####################################### CORRPLOT ##############################################
###################################################################################################
###################################################################################################


data <- read_csv("data_cart_abandonment.csv")
View(data)
attach(data)

names(data)
head(data)

colnames(data)

data<-data[,-1]
head(data)

summary(data)

data$Is_Product_Details_viewed <- as.character(data$Is_Product_Details_viewed)


data$Is_Product_Details_viewed[data$Is_Product_Details_viewed == "Yes"] <- 1
data$Is_Product_Details_viewed[data$Is_Product_Details_viewed == "No"] <- 0

data$Is_Product_Details_viewed <- as.numeric(data$Is_Product_Details_viewed)

sum(is.na(data$No_Items_Added_InCart))/nrow(data)
sum(is.na(data$No_Cart_Viewed))/nrow(data)

dataclean <- na.omit(data)

#dataclean_nor <- c("x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11")
#names(dataclean) <-dataclean_nor

corrplot(cor(dataclean))
corrplot(cor(dataclean[,c(-6,-8,-9)]))
corrplot(cor(dataclean[,c(-2,-3,-4,-6,-8,-9,-10)]))

corrplot(cor(dataclean[,-1]), method = 'number')




###################################################################################################
###################################################################################################
####################################### RANDOM FOREST ##############################################
###################################################################################################
###################################################################################################


data_cart_abandonment <- read_csv("data_cart_abandonment.csv")
View(data_cart_abandonment)
attach(data_cart_abandonment)

data_tree <- data_cart_abandonment
data_tree <- na.omit(data_cart_abandonment)

data_tree$Is_Product_Details_viewed[data_tree$Is_Product_Details_viewed == "Yes"] <- 1
data_tree$Is_Product_Details_viewed[data_tree$Is_Product_Details_viewed == "No"] <- 0

data_tree$Customer_Segment_Type <- as.factor(data_tree$Customer_Segment_Type)
data_tree$Cart_Abandoned <- as.factor(data_tree$Cart_Abandoned)

set.seed(1250) # Numero inicial del cual comenzara a generar una secuencia aleatoria.
split_train_test <- createDataPartition(data_tree$Cart_Abandoned, p=0.7, list=FALSE) #p = porcentaje de los datos a usar, list = Si el resultado devolvera una lista o una matriz. 

dtrain<- data_tree[split_train_test,]
dtest<-  data_tree[-split_train_test,]

dtest$Cart_Abandoned <- factor(dtest$Cart_Abandoned, levels = levels(dtrain$Cart_Abandoned))

#tr_fit <- rpart(Cart_Abandoned ~., data = dtrain, method="class") # Indicamos que deseamos un arbol de clasificacion, tambien podemos armar un arbol de regresion.
#tr_fit # Nuestro arbol obtenido.
#rpart.plot(tr_fit, tweak = 1.6) # Graficamos el arbol.

#aprender_rpart_pred <- predict(tr_fit, dtest, type="class")
#aprender_rpart_pred


rfModel <- randomForest(Cart_Abandoned ~ ., data = dtrain, 
                        importance = TRUE, ntree = 500)
print(rfModel)

# Evaluar el modelo en el conjunto de prueba
predictions <- predict(rfModel, dtest)

# Calcular la matriz de confusión
confusionMatrix(predictions, dtest$Cart_Abandoned)

importance_values <- importance(rfModel)
print(importance_values)

# Visualizar la importancia de las variables
varImpPlot(rfModel)

importance_df <- as.data.frame(importance_values)
importance_df$Variable <- rownames(importance_df)

ggplot(importance_df, aes(x = reorder(Variable, MeanDecreaseAccuracy), y = MeanDecreaseAccuracy)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Importancia de las Variables (MeanDecreaseAccuracy)", x = "Variable", y = "Importancia (MeanDecreaseAccuracy)") +
  theme_minimal()

ggplot(importance_df, aes(x = reorder(Variable, MeanDecreaseGini), y = MeanDecreaseGini)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Importancia de las Variables (MeanDecreaseGini)", x = "Variable", y = "Importancia (MeanDecreaseGini)") +
  theme_minimal()

corrplot(cor(rfModel[,-1]), method = 'number')



###################################################################################################
###################################################################################################
####################################### KMEANS ##############################################
###################################################################################################
###################################################################################################


library(broom)
library(factoextra)
library(readr)
library(corrplot)
library(readr)
install.packages("data.table")
library(data.table)

data_cart_abandonment <- read_csv("data_cart_abandonment.csv")

#SI ABANDONA
sum(data_cart_abandonment$Cart_Abandoned == '1')
#NO ABANDONA
sum(data_cart_abandonment$Cart_Abandoned == '0')


data <- fread("data_cart_abandonment.csv")
data <- data[,c(-1,-13)]
data <- na.omit(data)


data$Is_Product_Details_viewed[data$Is_Product_Details_viewed == "Yes"] <- 1
data$Is_Product_Details_viewed[data$Is_Product_Details_viewed == "No"] <- 0


data$Is_Product_Details_viewed <- suppressWarnings(as.numeric(data$Is_Product_Details_viewed))
data$Session_Activity_Count <- suppressWarnings(as.numeric(data$Session_Activity_Count))
data$No_Items_Added_InCart <- suppressWarnings(as.numeric(data$No_Items_Added_InCart))
data$No_Items_Removed_FromCart <- suppressWarnings(as.numeric(data$No_Items_Removed_FromCart))
data$No_Cart_Viewed <- suppressWarnings(as.numeric(data$No_Cart_Viewed))
data$No_Checkout_Confirmed <- suppressWarnings(as.numeric(data$No_Checkout_Confirmed))
data$No_Checkout_Initiated <- suppressWarnings(as.numeric(data$No_Checkout_Initiated))
data$No_Cart_Items_Viewed <- suppressWarnings(as.numeric(data$No_Cart_Items_Viewed))
data$No_Customer_Login <- suppressWarnings(as.numeric(data$No_Customer_Login))
data$No_Page_Viewed <- suppressWarnings(as.numeric(data$No_Page_Viewed))
data$Customer_Segment_Type <- suppressWarnings(as.numeric(data$Customer_Segment_Type))

dt_scaled <- data[, lapply(.SD, scale)]

View(dt_scaled)

set.seed(123)

#NO USAR por ahora
#dist_euclidean <- dist(dt_scaled, method = "euclidean")

#kmeans_result_dist <- kmeans(dist_euclidean, centers = 2, nstart = 25)

#fviz_cluster(kmeans_result_dist, data = dt_scaled, geom = "point",
#            ellipse.type = "norm", ggtheme = theme_minimal())

# pairs(dt_scaled, col = kmeans_result_dist$cluster)

kmeans_result_scale <- kmeans(dt_scaled, centers = 2, nstart = 25)

fviz_cluster(kmeans_result_scale, data = dt_scaled, geom = "point",
             ellipse.type = "norm", ggtheme = theme_minimal())

fviz_cluster(kmeans_result_scale, data = data, geom = "point",
             ellipse.type = "norm", ggtheme = theme_minimal())

fviz_nbclust(x = dt_scaled , FUNcluster = kmeans, method = "silhouette", k.max = 11) +
  labs(title = "Numero optimo de clusters")

#CENTERS ORIGINAL ESCALADO
print(kmeans_result_scale$centers)
print(kmeans_result_scale$cluster)
print(table(kmeans_result_scale$cluster))


inverse_transform <- function(scaled_data, original_data) {
  center <- sapply(original_data, mean, na.rm = TRUE)
  scale <- sapply(original_data, sd, na.rm = TRUE)
  t(t(scaled_data) * scale + center)
}

cluster_centers_scaled <- kmeans_result_scale$centers
cluster_centers_original <- inverse_transform(cluster_centers_scaled, data)

#CENTERS ESCALADO
print(cluster_centers_scaled)

#CENTERS ESCALA ORIGINAL
print(cluster_centers_original)

print("Hello world")




####################################################################
####################################################################
####################################################################

data_cart_abandonment <- read_csv("data_cart_abandonment.csv")
View(data_cart_abandonment)
attach(data_cart_abandonment)

head(data_cart_abandonment)

data <- data_cart_abandonment[,c(-1,-13)]
data <- na.omit(data)



data$Is_Product_Details_viewed[data$Is_Product_Details_viewed == "Yes"] <- 1
data$Is_Product_Details_viewed[data$Is_Product_Details_viewed == "No"] <- 0


data$Is_Product_Details_viewed <- suppressWarnings(as.numeric(data$Is_Product_Details_viewed))
data$Session_Activity_Count <- suppressWarnings(as.numeric(data$Session_Activity_Count))
data$No_Items_Added_InCart <- suppressWarnings(as.numeric(data$No_Items_Added_InCart))
data$No_Items_Removed_FromCart <- suppressWarnings(as.numeric(data$No_Items_Removed_FromCart))
data$No_Cart_Viewed <- suppressWarnings(as.numeric(data$No_Cart_Viewed))
data$No_Checkout_Confirmed <- suppressWarnings(as.numeric(data$No_Checkout_Confirmed))
data$No_Checkout_Initiated <- suppressWarnings(as.numeric(data$No_Checkout_Initiated))
data$No_Cart_Items_Viewed <- suppressWarnings(as.numeric(data$No_Cart_Items_Viewed))
data$No_Customer_Login <- suppressWarnings(as.numeric(data$No_Customer_Login))
data$No_Page_Viewed <- suppressWarnings(as.numeric(data$No_Page_Viewed))
data$Customer_Segment_Type <- suppressWarnings(as.numeric(data$Customer_Segment_Type))
data$Cart_Abandoned <- suppressWarnings(as.numeric(data$Cart_Abandoned))


View(data)