Este proyecto consta de dos archivos principales: un script en R (.R) utilizado para la recolección y limpieza inicial de los datos (scraping), y un cuaderno en Python (.ipynb) destinado al análisis posterior de esos datos. El flujo de trabajo consiste en ejecutar primero el script en R para obtener un dataset limpio de tweets y, una vez generado, utilizar el archivo en Python para realizar el análisis exploratorio, estadístico o de clasificación sobre el contenido recolectado.

El archivo en R, denominado `tweetsodio.R`, permite recolectar, procesar y exportar tweets relacionados con discursos de odio en Argentina utilizando el paquete TweetScraperR. Está diseñado para obtener datos históricos dentro de un rango de fechas específico y almacenarlos en archivos .rds y .csv listos para su análisis posterior.

Primero se deben instalar las librerías necesarias (TweetScraperR, dplyr y stringr) y autenticar la conexión con Twitter mediante la función `openTwitter()`. Luego se configura la carpeta de salida donde se guardarán los archivos descargados y se define el rango de fechas que se desea analizar.

El script permite configurar las palabras clave de búsqueda, divididas en dos grupos: una lista de términos comúnmente dirigidos contra sectores oficialistas y otra utilizada contra sectores opositores. Es importante destacar que dentro de la función `getTweetsHistoricalSearch`, en el argumento `search`, se deben modificar estas palabras según el objetivo del análisis. Esto permite adaptar la búsqueda a distintos contextos o temas de interés, incorporando hashtags, expresiones específicas o palabras clave relevantes.

A continuación, el script ejecuta un bucle que descarga tweets día por día con la función `getTweetsHistoricalSearch`, obteniendo hasta 1000 tweets por jornada dentro del rango definido. Cada lote de tweets se guarda automáticamente en la carpeta especificada.

Una vez finalizada la descarga, el script combina todos los archivos `.rds` generados, elimina duplicados, descarta columnas innecesarias y limpia el texto de los tweets, eliminando emojis y caracteres especiales para facilitar el análisis.

Finalmente, se generan dos archivos principales: `tweets_final.rds`, que contiene el dataset limpio en formato RDS, y `tweets_final.csv`, que almacena el mismo conjunto de datos en formato CSV para ser utilizado en herramientas externas. Además, se crea un archivo adicional denominado `tweets_unificados.csv` que reúne todos los tweets procesados sin duplicados ni emojis.


