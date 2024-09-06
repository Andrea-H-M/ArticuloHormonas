###############################################################
## Tema: Heatmap                                             ##
## Autor: Olga Andrea Hernandez Miranda, Miranda H           ##
## Fecha: 05/09/2024                                         ##
## Nota: Mapa de calor para visualizar expresión genética    ##
###############################################################

# Instalar y cargar las librerías necesarias
if (!requireNamespace("pheatmap", quietly = TRUE)) {
  install.packages("pheatmap")
}
if (!requireNamespace("viridis", quietly = TRUE)) {
  install.packages("viridis")
}

# Cargar librerías
library(pheatmap)
library(viridis)
library(grid)

# Parámetros
alpha <- 0.01
directorio <- "C:/Users/andii/OneDrive/Documents/DoctoradoEnCiencias/Semestre4/Redes y HM"

# Cargar los datos
data <- read.table("HM_Nucleo.csv", sep = ",", header = TRUE)
row.names(data) <- data[, 1] # Asignar los nombres de fila
mat_data <- data.matrix(data[, -1]) # Convertir a matriz, excluyendo la primera columna

# Normalizar los datos con log2, evitando ceros o valores negativos
countTable.kept <- log2(mat_data + 1)

# Verificar y eliminar filas/columnas con NA/NaN/Inf
countTable.kept <- countTable.kept[complete.cases(countTable.kept), ]
row_sd <- apply(countTable.kept, 1, sd) # Desviación estándar por filas
col_sd <- apply(countTable.kept, 2, sd) # Desviación estándar por columnas
countTable.kept <- countTable.kept[row_sd > 0, col_sd > 0] # Filtrar filas/columnas con desvío positivo

# Generar un mapa de calor básico
pheatmap(countTable.kept,
         display_numbers = TRUE,
         number_color = "darkgray", 
         fontsize_number = 8,
         color = viridis(50))

# Variación del mapa de calor con otra paleta de colores
pheatmap(countTable.kept, color = hcl.colors(50, "viridis"))

# Mapa de calor sin agrupación de filas/columnas, ajustando tamaño de celdas
pheatmap(countTable.kept,
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         cellwidth = 20,
         cellheight = 20,
         color = hcl.colors(50, "viridis"))

# Crear el heatmap sin mostrarlo
heatmap_plot <- pheatmap(
  countTable.kept,
  cluster_rows = FALSE,   # No agrupar filas
  cluster_cols = FALSE,   # No agrupar columnas
  cellwidth = 20,         # Ancho de cada celda
  cellheight = 20,        # Altura de cada celda
  color = hcl.colors(50, "viridis")  # Usar la paleta de colores viridis
)

# Obtener el objeto 'gtable' del heatmap para modificar
heatmap_gtable <- heatmap_plot$gtable

# Modificar los nombres de las filas (genes) para que estén en cursiva
heatmap_gtable$grobs[[which(heatmap_gtable$layout$name == "row_names")]]$gp <- gpar(fontface = "italic")

# Dibujar el heatmap con los nombres de los genes en cursiva
grid.draw(heatmap_gtable)
