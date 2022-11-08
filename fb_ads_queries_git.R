
# Cargar Librerías --------------------------------------------------------

library(tidyverse) # Por ahora para ocupar la librería dplyr
library(rfacebookstat) # Para hacer el query


# Crear Token -------------------------------------------------------------

tkn <- "your_token"


# Designar ID de cada cuenta de anuncios de Facebook-----------------------
# Se le asignará este valor a la función fbGetMarketingStat(accounts_id)

id_1 <- your_id
id_2 <- another_id


# Nombres columnas --------------------------------------------------------
# Se utilizarán más abajo para renombras las columnas del dataset que crearemos

columnas <- c("campana","alcance","impresiones","clics","ctr","cpm","cpc","gasto_total","fecha","fecha_termino")


# Hacer un query ----------------------------------------------------------
# Crear un objeto con el query

data_insights <- rfacebookstat::fbGetMarketingStat(accounts_id = id_1, # Acá va el id de tu cuenta de anuncios en FB
                               level = "campaign",
                               fields = "campaign_name,reach,impressions,clicks,
                               inline_link_click_ctr,cpm,cpc,spend",
                               date_start = Sys.Date()-3, # Query 3 días hacia atrás
                               date_stop = Sys.Date(), # Desde cuando hacia atrás
                               access_token = tkn) %>% # Aquí va el token creado
  `colnames<-`(columnas) %>% # Renombrar columnas
  dplyr::select(-fecha_termino) # Esta variable no se ocupa porque es redundante


# Cambiar tipos a variables del dataset-----------------------------------------------

dplyr::glimpse(data_insights) # Para ver cómo se llaman las columnas y cuáles hay que cambiar

data_insights$alcance <- as.numeric(data_insights$alcance)
data_insights$impresiones <- as.numeric(data_insights$impresiones)
data_insights$clics <- as.numeric(data_insights$clics)
data_insights$ctr <- as.numeric(data_insights$ctr) %>% round(digit = 2)
data_insights$cpm <- as.numeric(data_insights$cpm) %>% round(digit = 0)
data_insights$cpc <- as.numeric(data_insights$cpc) %>% round(digit = 0)
data_insights$gasto_total <- as.numeric(data_insights$gasto_total)
data_insights$fecha <- as.Date(data_insights$fecha)

dplyr::glimpse(data_insights)


# Crear variable dia_semana con weekdays() --------------------------------
# Generar una variable categórica que puede ser usada en los análisis posteriores

data_insights$dia_semana <- weekdays(data_insights$fecha) # Se crea la variable directamente con $dia_semana, queda al final en la última columna
