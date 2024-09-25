
data1 <- read.csv2("E-CARS.csv")
data2 = data1[c(1:20),-12]
colnames(data2)
str(data2)
summary(data2)
data2$PREZZO <- as.numeric(data2$PREZZO)
names(data2)[1] ="CAR_NAME"
names(data2)[3] = "CAPACITYkwh"
data2matr <- data.matrix(data2[,2:11])
rownames(data2matr) <- data2$CAR_NAME
data2matr
str(data2matr)

#Vediamo la distribuzione degli indici
library(e1071)
?apply
apply(X = data2matr, MARGIN = 2, FUN = "mean")
asimm <- apply(data2matr,2, skewness)
kurt <- apply(data2matr,2,kurtosis)
min <- apply(data2matr,2, min)
max <- apply(data2matr,2, max)
median <- apply(data2matr,2, median)
stat <- cbind.data.frame(mean,asimm,kurt,min,max,median, )
stat
#asimmetria positiva per tutti gli indici tranne ROE

#ACP:
#Quando si ha a che fare con tante variabili, queste possono entrare in conflitto perché possono essere correlate tra loro
#L'ACP risolve questo problema riducendo la dimensionalità creando delle nuove variabili, possibilmente
#un numero minimo di variabili rispetto a quelle originali che sono combinazioni lineari delle variabili ordinarie
#Queste variabili create sono tra loro incorrelate e posseggono la maggior parte della varianza possibile
#di tutto il sistema.

#Correlation matrix
R <- cor(data2[,-1])
R
#corr pos tra ROI e ROE
#corr neg tra CR e ROD

#PCA usando la correlation matrix
rownames(data2)<-data2[,1] 
pr <- princomp(data2[,-1], cor=T)
summary(pr)

#selezione delle principali componenti per calcolare la variabilità cumulata
eig <- eigen(R)
pr$dev
cumprop <- cumsum(pr$sdev^2/sum(pr$sdev^2))
princompselect <- cbind(EigenValue=eig$values, CumulativePropVariance=cumprop)
princompselect #osserviamo gli autovalori e la varianza cumulata
#Noi prendiamo il minimo numero possibile di componenti ma che spiegano la porzione maggiore di variabilità
#In genere se un gruppo di componenti spiega il 60% o poco più di variabilità, selezioniamo queste
#Le prime due componenti spiegano molto (80%), non c'è bisogno di prendere la terza


XX <- t(sqrt(eig$values)*t(eig$vectors))
colnames(XX) <- c("Comp.1", "Comp.2", "Comp.3", "Comp.4", "Comp.5", "Comp.6","Comp.7","Comp.8","Comp.9","Comp.10")
rownames(XX) <- c("AUTONOMIA","CAPACITYkwh","POTENZA.CV","LUNGHEZZA","ALTEZZA",
                  "LARGHEZZA","PREZZO","PESO","H.DA.TERRA","CX")
XX
XX[,c(1,2)]


library(factoextra)


fviz_pca_biplot(pr)

fviz_pca_var(pr, col.var="steelblue")+
  theme_minimal()

#Il quadrante migliore è quello in alto a destra
#BCU è quasi tra le migliori al contrario di TODS

pr$loadings
pr$center
pr$scale
pr$scores

#regressione multipla

library(ggplot2)
library(broom)
library(ggfortify)
theme_set(theme_bw())
str(data2)

datamulti <- data2[,-1]

model1 <- lm(AUTONOMIA ~ CAPACITYkwh, data = datamulti)
summary(model1)

back <- step(lm(mpg~., data = mtcars), direction = "backward",trace=0)

#First fit regression as step-wise
# Stepwise Regression
#variable :
#"AUTONOMIA","CAPACITYkwh","POTENZA.CV","LUNGHEZZA","ALTEZZA",
#"LARGHEZZA","PREZZO","PESO","H.DA.TERRA","CX"
library(MASS)
fit <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA + ALTEZZA + LARGHEZZA
          + PREZZO + PESO + H.DA.TERRA + CX,
          data=datamulti)
summary(fit)
step <- stepAIC(fit, direction="both")
step$anova # display results
#Fit the final model from the stepwise regression
step$anova
fit_final <- lm(AUTONOMIA ~ CAPACITYkwh + CX, data=datamulti)
print(fit_final)
AIC(fit_final)



par(mfrow=c(2,2))
autoplot(fit_final)

#ripeto il processo manualmente per ferificare il risultato

fit <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA + ALTEZZA + LARGHEZZA
          + PREZZO + PESO + H.DA.TERRA + CX,
          data=datamulti)

fit1 <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA + ALTEZZA + LARGHEZZA
           + PREZZO + PESO + H.DA.TERRA ,
           data=datamulti)

fit2 <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA + ALTEZZA + LARGHEZZA
           + PREZZO + PESO ,
           data=datamulti)

fit3 <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA + ALTEZZA + LARGHEZZA
           + PREZZO ,
           data=datamulti)

fit4 <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA + ALTEZZA + LARGHEZZA
           ,
           data=datamulti)

fit5 <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA + ALTEZZA ,
           data=datamulti)

fit6 <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV + LUNGHEZZA ,
           data=datamulti)

fit7 <- lm(AUTONOMIA ~ CAPACITYkwh + POTENZA.CV  ,
           data=datamulti)

fit8 <- lm(AUTONOMIA ~ CAPACITYkwh  ,
           data=datamulti)

fit_final <- lm(AUTONOMIA ~ CAPACITYkwh + CX, data=datamulti)


#fatto da me osservando le variabili
fit_final2 <- lm(AUTONOMIA ~ CAPACITYkwh + CX + 
                   PESO, data=datamulti)
summary(fit_final2)
# ho ottenuto un ottimo risultato queste
#variabili sono molto più interessanti e non 
#perdo molta precisione in termini di AIC


AIC(fit1);AIC(fit2);AIC(fit3);AIC(fit4);AIC(fit5);AIC(fit6);AIC(fit7);AIC(fit8);AIC(fit_final);AIC(fit_final2)


#cluster analysis

# Seleziona le colonne di interesse per l'analisi di clustering
colnames(datamulti)
cars_cluster <- datamulti[, c("AUTONOMIA","CAPACITYkwh","POTENZA.CV","LUNGHEZZA","ALTEZZA",
                              "LARGHEZZA","PREZZO","PESO","H.DA.TERRA","CX")]

# Normalizza i dati per garantire che le variabili abbiano la stessa scala
cars_cluster_norm <- scale(cars_cluster)

# Esegui l'algoritmo di clustering K-means con un numero predefinito di cluster
num_cluster <- 3  # Numero di cluster desiderato
kmeans_result <- kmeans(cars_cluster_norm, centers = num_cluster)

# Ottieni le etichette di cluster assegnate a ciascuna osservazione
cluster_labels <- kmeans_result$cluster

# Stampa le etichette di cluster
print(cluster_labels)

# Valuta le statistiche del cluster
print(kmeans_result)

# Plot dei cluster
library(cluster)
par(mfrow=c(1,1))
clusplot(mtcars_cluster_norm, cluster_labels, main = "Cluster Analysis of mtcars dataset")
library(ggdendro)
hc <- hclust(dist(cars_cluster_norm), "ave")
ggdendrogram(hc, rotate = T)

