# querys_facebook
Repositorio creado

07/11/22 - Versión 0.2 - ¡Ya está arriba!

Hoy al subir esto se cumple un anhelado proyecto que entre otras cosas me motivó al principio a estudiar programación. ¡chan! Es un proyecto simple en realidad, pero bastante funcional. Se trata de un query a la API Graphs de Facebook. 

Consiste en hacer un token y un user id para que a través de la biblioteca rfacebookstat se realice un query donde se pueden escoger las variables o insights de las campañas activas y que devuelva un dataframe.

Se pueden agregar más parámetros en el operador fields al momento de hacer el query, sólo hay que saber un poco de la API de Facebook, lo cual constituye la parte más compleja de la operación.

Luego de que se genere el dataframe se cambian los tipos a las variables de la base de datos para poder realizar operaciones como medias, boxplots, series de tiempo entre otras.

Por último se crea una variable adicional que es el día de la semana de la medición, esta variable es categórica y puede ser ocupada posteriormente para realizar regresiones o modelos de machine learning.

08/11/22 - Versión 0.4 - Primeras iteraciones y mejoras

Se genera un query más extenso y se trabajan las variables que entrega:

- Se transforma la variable dia_semana a factor
- Se crea variable "costo_like" a partir de cálculos entre 2 variables (gasto/likes)
- Se ordenan las variables dentro del dataframe

09/11/22 - Versión 0.6 - Optimización del código

Se limpió el código y se cambió la metodología de selección de variables (o columnas). En las versiones anteriores se eliminaban las columnas que no se necesitaban. Ahora a partir de la función select se escogen las variables y se ordenan directamente en la selección, evitando así tener que ordenarlas posteriormente y ahorrando un par de líneas de código.

Además de eso se agrega la función de filtrar solamente las campañas que se necesiten a través de la función stringr::str_detect, esto básicamente filtra por la condición "contiene: " lo que permite un poco más de flexibilidad al momento de ingresar el filtro.
