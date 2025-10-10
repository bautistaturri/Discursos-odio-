# ================================
# Librerías
# ================================
library(TweetScraperR)
library(dplyr)
library(stringr)


## Instalación de paquetes necesarios
##
#install.packages("chromote")
#install.packages("remotes")
#remotes::install_github("agusnieto77/TweetScraperR")
#install.packages("TweetScraperR")


# ================================
# Autenticación
# ================================
openTwitter()

# ================================
# Carpeta de salida
# ================================
out_dir <- "C:/Users/bauti/Documents/tweets"
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

# ================================
# Rango de fechas
# ================================
fecha_inicio <- as.Date("2025-09-16")
fecha_fin    <- as.Date("2025-09-24")
fechas       <- seq.Date(from = fecha_inicio, to = fecha_fin, by = "day")

# ================================
# Palabras de búsqueda
# ================================
odio_terms <- paste(
  "zurdo OR zurdos OR zurdita OR kukaracha OR kuka OR kks OR",
  "chorra OR chorro OR planera OR planero OR vago OR vagos OR mantenido OR ñoqui OR",
  "cristina OR cfk OR kretina OR kchorra OR kretinista OR",
  "kicillof OR axelito OR masa OR massita OR alberto OR alborto OR alburrto OR",
  "peroncho OR peronia OR camporista OR campora OR pejotista OR",
  "coimera OR corrupta OR ladrona OR afanadora OR delincuente OR",
  "la yegua OR la jefa OR la chorra"
)

odio_terms_oposicion <- "gorila OR globoludo OR macrista OR cheto OR casta OR garca OR libertonto OR libertarado OR fascista OR facho OR ultraderecha OR neoliberal OR antipatria OR vendepatria OR macri OR mauricio OR bullrich OR milei OR villarruel OR larreta OR picheto OR melconian OR vidal OR espert OR pro OR juntos OR cambiemos OR libertario OR amarillos OR gorilaje OR antiK OR anti peronista OR anti peronia OR capitalista OR chupaculos OR empresaurio OR bostero OR lacayo OR sirviente OR burgués OR oligarca OR cipayo"


# ================================
# Descargar tweets día por día
# ================================
for (dia in fechas) {
  since_str <- format(as.Date(dia), "%Y-%m-%d")
  until_str <- format(as.Date(dia) + 1, "%Y-%m-%d")
  
  message("Descargando tweets del ", since_str)
  
  tryCatch({
    getTweetsHistoricalSearch(
      search   = odio_terms_oposicion,
      timeout  = 20,
      n_tweets = 1000,
      since    = since_str,
      until    = until_str,
      live     = TRUE,         # streaming controlado
      save     = TRUE,         # guarda automáticamente
      dir      = out_dir
    )
  }, error = function(e) {
    message("Error en ", since_str, ": ", e$message)
  })
}

# ================================
# Combinar todos los .rds
# ================================
files <- list.files(out_dir, pattern = "\\.rds$", full.names = TRUE)
df_total <- do.call(bind_rows, lapply(files, readRDS))

# ================================
# Limpiar y normalizar datos
# ================================
df_total <- df_total %>% distinct(url, .keep_all = TRUE)

# Eliminar columnas innecesarias
if ("art_html" %in% names(df_total)) df_total$art_html <- NULL

# Eliminar emojis y caracteres no texto del tweet
remove_emojis <- function(text) {
  text <- iconv(text, from = "UTF-8", to = "ASCII//TRANSLIT") # elimina emojis
  text <- gsub("[^[:alnum:]\\s[:punct:]]", "", text)          # borra restos raros
  text <- gsub("\\s+", " ", text)                             # limpia espacios múltiples
  trimws(text)
}

if ("tweet" %in% colnames(df_total)) {
  df_total$tweet <- sapply(df_total$tweet, remove_emojis)
}

# ================================
# Guardar RDS y CSV limpio
# ================================
final_rds <- "C:/Users/bauti/Desktop/tweets_final.rds"
saveRDS(df_total, final_rds)

# Convertir listas a texto plano antes del CSV
df_total <- df_total %>%
  mutate(across(where(is.list), ~ sapply(., function(x) paste(unlist(x), collapse = ", "))))

final_csv <- "C:/Users/bauti/Desktop/tweets_final.csv"
write.csv(df_total, final_csv, row.names = FALSE)

message("Terminado. Guardado en: ", final_rds, " y ", final_csv)

# ================================
# Crear CSV unificado adicional
# ================================
carpeta <- "C:/Users/bauti/Documents/tweets"
archivos <- list.files(carpeta, pattern = "\\.rds$", full.names = TRUE)
tweets_total <- do.call(bind_rows, lapply(archivos, readRDS))

tweets_total <- tweets_total %>% distinct(url, .keep_all = TRUE)
tweets_total <- tweets_total %>% mutate(across(where(is.list), ~ sapply(., function(x) paste(unlist(x), collapse = ", "))))

# Eliminar emojis en todo el dataset
if ("tweet" %in% colnames(tweets_total)) {
  tweets_total$tweet <- sapply(tweets_total$tweet, remove_emojis)
}

write.csv(
  tweets_total,
  "C:/Users/bauti/Desktop/tweets_unificados.csv",
  row.names = FALSE
)

message("CSV limpio y sin emojis creado en el escritorio.")
