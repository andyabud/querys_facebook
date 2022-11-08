
# Cargar Librerías --------------------------------------------------------

library(tidyverse)
library(rfacebookstat)


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

data_insights <- fbGetMarketingStat(accounts_id = id_1, # Acá va el id de tu cuenta de anuncios en FB
                               level = "campaign",
                               fields = "campaign_name,reach,impressions,clicks,
                               inline_link_click_ctr,cpm,cpc,spend",
                               date_start = Sys.Date()-3, # Query 3 días hacia atrás
                               date_stop = Sys.Date(), # Desde cuando hacia atrás
                               access_token = tkn) %>% # Aquí va el token creado
  `colnames<-`(columnas) %>% # Renombrar columnas
  select(-fecha_termino) # Esta variable no se ocupa porque es redundante


# Cambiar tipos a variables del dataset-----------------------------------------------

glimpse(insights_zurich_fb) # Para ver cómo se llaman las columnas y cuáles hay que cambiar

insights_zurich_fb$alcance <- as.numeric(insights_zurich_fb$alcance)
insights_zurich_fb$impresiones <- as.numeric(insights_zurich_fb$impresiones)
insights_zurich_fb$clics <- as.numeric(insights_zurich_fb$clics)
insights_zurich_fb$ctr <- as.numeric(insights_zurich_fb$ctr) %>% round(digit = 2)
insights_zurich_fb$cpm <- as.numeric(insights_zurich_fb$cpm) %>% round(digit = 0)
insights_zurich_fb$cpc <- as.numeric(insights_zurich_fb$cpc) %>% round(digit = 0)
insights_zurich_fb$gasto_total <- as.numeric(insights_zurich_fb$gasto_total)
insights_zurich_fb$fecha <- as.Date(insights_zurich_fb$fecha)

glimpse(insights_zurich_fb)


# Crear variable dia_semana con weekdays() --------------------------------
# Generar una variable categórica que puede ser usada en los análisis posteriores

insights_zurich_fb$dia_semana <- weekdays(insights_zurich_fb$fecha)
