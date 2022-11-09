
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

columnas <- c("campana","alcance","impresiones","clics","ctr",
              "cpm","cpc","likes","gasto","fecha")


# Hacer query a la API de FB ----------------------------------------------

data_insights <- rfacebookstat::fbGetMarketingStat(accounts_id = id_1, # Acá va el id de tu cuenta de anuncios en FB
                               level = "campaign",
                               fields = "campaign_name,reach,impressions,clicks,
                                         inline_link_click_ctr,cpm,cpc,spend,actions",
                               date_start = Sys.Date()-5, # Query 5 días hacia atrás
                               date_stop = Sys.Date(), # Desde cuando hacia atrás
                               access_token = tkn) # Aquí va el token creado


# Limpiar dataframe ------------------------------------------------------

## Revisar dataframe
glimpse(data_insights)

## Seleccionar columnas que se ocuparan y filtrar las filas que se necesiten
data_insights <- data_insights %>% 
  select(campaign_name,
         reach,
         impressions,
         clicks,
         inline_link_click_ctr,
         cpm,
         cpc,
         like,
         spend,
         date_start) %>% 
  `colnames<-`(columnas) %>% # Renombrar columnas ocupando el vector con nombres que creamos arriba
  filter(stringr::str_detect(campana, 'Unificación')) # Filtrar solo las campañas que contengan el término de unificación

## Revisar dataframe
glimpse(data_insights)


## Cambiar tipos a variables -----------------------------------------------

data_insights$alcance <- as.numeric(data_insights$alcance)
data_insights$impresiones <- as.numeric(data_insights$impresiones)
data_insights$clics <- as.numeric(data_insights$clics)
data_insights$ctr <- as.numeric(data_insights$ctr) %>% round(digit = 2)
data_insights$cpm <- as.numeric(data_insights$cpm) %>% round(digit = 0)
data_insights$cpc <- as.numeric(data_insights$cpc) %>% round(digit = 0)
data_insights$likes <- as.numeric(data_insights$likes)
data_insights$gasto <- as.numeric(data_insights$gasto)
data_insights$fecha <- as.Date(data_insights$fecha)

## Revisar dataframe
glimpse(data_insights)


## Crear variable dia_semana con weekdays() --------------------------------

data_insights$dia_semana <- weekdays(data_insights$fecha) %>% 
  as.factor() # Transformar a factor


## Crear variable costo por like -------------------------------------------

data_insights$costo_like <- data_insights$gasto/data_insights$likes

## Transformar a numérico y redondear la variable
data_insights$costo_like <- as.numeric(data_insights$costo_like) %>% 
  round(digit = 0)


## Cambiar orden de columnas -----------------------------------------------

data_insights <- data_insights %>%
  relocate(costo_like, .after = likes)

## Revisar dataframe
glimpse(data_insights)


# Copiar dataframe para después pegarlo -----------------------------------

clipr::write_clip(data_insights)
