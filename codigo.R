nombres = c("Fecha", "IDCliente", "Edad", "Zona Residencia", "Subclase Producto", "IDProducto", "Cantidad", "Activo", "Precio")
noviembre = data.frame(read.csv2("/home/wr1/Escritorio/datasets/D11-02/D11", header = FALSE, sep = ";", dec = ".", col.names = nombres, colClasses = "character"))
diciembre = data.frame(read.csv2("/home/wr1/Escritorio/datasets/D11-02/D12", header = FALSE, sep = ";", dec = ".", col.names = nombres, colClasses = "character"))
enero = data.frame(read.csv2("/home/wr1/Escritorio/datasets/D11-02/D01", header = FALSE, sep = ";", dec = ".", col.names = nombres, colClasses = "character"))
febrero = data.frame(read.csv2("/home/wr1/Escritorio/datasets/D11-02/D02", header = FALSE, sep = ";", dec = ".", col.names = nombres, colClasses = "character"))
aux <- rbind.data.frame(noviembre,diciembre,enero,febrero)
library(arules)
res <- aux
aux$Fecha <- NULL
aux$IDCliente <- factor(aux$IDCliente)
aux$Edad <- factor(aux$Edad)
aux$Zona.Residencia <- factor(aux$Zona.Residencia)
aux$Subclase.Producto <- factor(aux$Subclase.Producto)
aux$IDProducto <- NULL
aux$Cantidad <- factor(aux$Cantidad)
aux$Activo <- NULL
aux$Precio <- factor(aux$Precio)
reglas <- apriori(aux, parameter = list(maxlen = 25, confidence = 0.75))
inspect(reglas)

transac <- as(aux, "transactions")
itemLabels(transac)
reglasR <- apriori(transac, parameter = list(maxlen = 25, confidence = 0.95, support = 0.05, target = "frequent"), appearance = list(items = c("Edad=C ", "Edad=E ", "Edad=D ", "Zona.Residencia=F ", "Zona.Residencia=E "),default = "none"))
inspect(reglasR)

reglasRtt <- apriori(transac, parameter = list(maxlen = 25, confidence = 0.9, support = 0.01, target = "frequent"), appearance = list(items = c("Edad=A ", "Edad=B ", "Edad=F ", "Edad=G ", "Zona.Residencia=A ", "Zona.Residencia=B ", "Zona.Residencia=C ", "Zona.Residencia=D ", "Zona.Residencia=G "),default = "none"))
inspect(reglasRtt)

val <- as.numeric(aux$Precio)
hola<- cut(val, breaks = seq(1,70589,100))
hola <- as.character.factor(hola)