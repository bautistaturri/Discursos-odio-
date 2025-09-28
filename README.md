### Proyecto: Monitoreo y Análisis de Discursos de Odio en Redes Sociales

Este proyecto forma parte de una iniciativa impulsada por el Centro de Inteligencia Artificial Interdisciplinario (CIAI) de la Universidad Nacional de San Martín. Su objetivo general es desarrollar un sistema que permita recolectar, depurar, analizar y visualizar la presencia de discursos de odio en Twitter en el contexto argentino. El trabajo combina técnicas de scraping, procesamiento y análisis de datos con herramientas de inteligencia artificial y análisis lingüístico, buscando generar conocimiento útil tanto para la investigación académica como para el desarrollo de políticas públicas.

### Script en R (`tweetsodio.R`)

El archivo en R se utiliza para la primera etapa del proyecto: la recolección y limpieza inicial de datos. Mediante la librería `TweetScraperR`, el script descarga tweets históricos según palabras clave relacionadas con discursos de odio, dentro de un rango temporal definido. El código permite modificar estas palabras en la función `getTweetsHistoricalSearch` para adaptarlas al objetivo de cada análisis. Luego, combina todos los datos obtenidos, elimina duplicados, limpia el texto (quitando emojis y caracteres no deseados) y genera datasets finales en formatos `.rds` y `.csv` que servirán como insumo para etapas posteriores.

### Notebook en Python (`analisis.ipynb`)

El archivo en Python complementa el trabajo realizado en R y se enfoca en el análisis exploratorio y la interpretación de los datos recolectados. En esta etapa, se realizan tareas como la exploración descriptiva del corpus, la visualización de tendencias, la identificación de usuarios y hashtags relevantes y la aplicación de modelos de clasificación (por ejemplo, BETO) para detectar y categorizar discursos de odio. Además, el notebook permite preparar los datos para futuros desarrollos, como dashboards interactivos o pipelines automatizados de monitoreo.

Este flujo de trabajo conjunto entre ambos archivos garantiza un proceso completo: desde la extracción y limpieza de datos hasta el análisis profundo y la generación de conocimiento a partir de los discursos detectados en redes sociales.
