## NO COUNTRY DATA BI

Este proyecto es un analisis en el area de E-Commerce de un set de datos de un carrito de compra virtual.

Diccionario de Datos:

- **Producto_Detalles_Vistos**: Indica si el cliente está viendo los detalles del producto (1: Sí, 0: No).
- **Cantidad_Actividades_Sesión**: Número de veces que el cliente visita diferentes páginas durante la sesión.
- **Cantidad_Artículos_En_Carro**: Número de artículos en el carrito de compra.
- **Cantidad_Artículos_Eliminados_Carro**: Número de artículos eliminados del carrito de compra.
- **Cantidad_Visitas_Carro**: Número de veces que el cliente visita la página del carrito de compra.
- **Confirmaciones_Compra**: Número de confirmaciones exitosas de compra por parte del cliente.
- **Inicios_Pago**: Número de veces que se inicia el proceso de pago, ya sea con éxito o sin éxito.
- **Vistas_Productos_Carro**: Número de veces que el usuario ve los productos en el carrito de compra.
- **Inicios_Sesión_Cliente**: Número de veces que el cliente inicia sesión.
- **Vistas_Páginas**: Número de páginas vistas por el cliente.
- **Segmento_Cliente**: Categoría a la que pertenece el cliente (Cliente Objetivo, Cliente  Leal, Cliente No Segmentado).
- **Abandono_Carro**: Indica si el cliente ha abandonado el carrito de compra (1: Sí, 0: No).

El objetivo de este proyecto es predecir la variable dicotomica Abandono_Carro (Cart_Abandoned), analizar las causas de porque los usuarios 
abandonan el carrito virtual y generar posibles estrategias para evitar perdida de usuarios a nuestro cliente interesado en el proyecto. 

En dicho analisis de ha hecho usa de diversas herramientas y tecnicas en el area de Data Sciences, Machine Learning Development, Data analyst y Data Business Analyst.

Mi rol en este proyecto fue el Data Science y Machine Learning developer, en conjunto con otro colega, realizamos en primera instancia modelos en Random Forest.
En primera instancia se realizaron diversos modelos donde se consiguieron resultados prometedores, realizamos otros modelos quitando variables, 
descubrimos que la variable mas relevante en cada caso era Confirmaciones_Compra (No_Checkout_Confirmed), otras relevantes eran Cantidad_Actividades_Sesión (Session_Activity_Count), Inicios_Sesión_Cliente (No_Customer_Login) e Inicios_Pago (No_Checkout_Initiated), aunque las Confirmaciones de compra presentaba alta correlacion negativa con la variable Abandono_Carro. 


Luego procedimos a realizar 2 clusters con kmeans en el cual se obtuvieron resultados interesantes. Si uno analisa la cantidad de casos de usuarios que abandonan el carrito hay un total de 3668 y las personas que no abandonan serian de 616 sobre un total de 4284 observaciones, cuando se realiza los clusters se veia un comportamiento en cuanto la variable relevante Confirmaciones_Compra donde se agrupan 3348 observaciones en total teniendo dicha variable una inclinacion mas negativa siendo esta de -0.1849501, mientras que para nuestro otro clusters su inclinacion seria de 0.6708699 donde se nota una gran diferencia contra la otra donde se agrupan 923 observaciones. Esto nos lleva a la conclusion de que el usuario cuando no logra confirmar su compra tiende a abandonar el carrito pero en el caso opuesto el usuario no abandonara el carrito de compra virtual concluyendo la compra.

Encontraran MAYOR detalle dentro de las carpetas del proyecto con su respectivo analisis





