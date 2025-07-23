# Introduccion

 Sistema para analizar los artistas mas populares en los géneros de nicho de musica flamenco pop, reggae, ska y kpop entre los años 2013 a 2017 (veintena de los millennials).
 Nos contrata una productora de grandes festivales solicitando que precisan analizar los artistas mas populares en los géneros y años mencionados, ya que estos años eran los primeros en los que 
 que este sector de clientes ha acudido a grandes festivales.Nos lo solicitan a raíz de un estudio interno que les ha arrojado que en este momento tienen edad en la que cuentan con mayores 
 ingresos y pueden permitirse este tipo de eventos. Para la empresa es un target interesante de atraer.
 Desean desarrollar una gira de grandes eventos para atraerlos en masa. 

 Este proyecto implementa un sistema basico de consultas, que permite analizar la evolucón de los géneros músicales en el período e identificar cuales son los artistas y canciones mas populares en los diferentes generos durante el rango de años definido.

## Ejemplo de Uso

El sistema permite extraer artistas de distintos años y géneros

- Extraer características de los artistas en distintas plataformas
- Crear una base de datos en la que se pueda almacenar los datos extraídos
- Analizar los resultados de los datos

## Como arrancar el proyecto
El proyecto inicia con un [notebook](PROYECTO_MOD2_SPOTIFY.ipynb) desde la fase de extraccion de datos 

Comienza con una función que incluye un bucle for para la extracción de datos en ambas plataformas

### Fase de extracción de datos

**Extracción de datos de las Apis Spotify y Last.fm
Para acceder a la extracción de datos son necesarias credenciales de las Apis

Ejemplo introducción credenciales:

```python
auth_manager = SpotifyClientCredentials(client_id=CLIENT_ID, client_secret=CLIENT_SECRET)
sp = spotipy.Spotify(auth_manager=auth_manager)

```python
API_KEY = ' # INTRODUCE con tu clave de API válida de Last.fm'  
BASE_URL = ' # URL base de la API de Last.fm'  
```

- **Antes de la fase de inserción de datos visualizamos la información extraída a través de un DataFrame
- **Se ha descargado la información en CSV y XLSM
  
### Fase de inserción de datos

- **Manejar la información obtenida en los DF**
- **Limpiar los datos en VSCode (Python)**
- **Crear la base de datos con sus tablas y relaciones En MYSQL Workbench.**
- **Insertar datos desde VsCode con biblioteca "MySQL.connector"**
- **Hemos limpiado la columna de la fecha, dejando solo el año (MySQL Workbench)**
- **Se han eliminado columnas innecesarias (MySQL Workbench)**
- **Se han realizado las querys para obtener la información necesaria**


### Fase de análisis de la información recopilada

- **Análisis de los resultados obtenidos**
- **Redacción de informe con descripción de conclusiones**
- **Presentación de resultados**

### Herramientas utilizadas:

- **GitHub**
- **VsCode**
- **Jupyter Notebook**
- **Python**
- **Bibliotecas Python: Resquest, Spotipy, Pandas, MySQL.Connector**
- **MySQL Workbench**
- **Office: Excel, Word**
- **Canva**

### Metodología SCRUM

- **Scrum Master: Aida Bau**
- **Creación de Backlog y actualizaciones diarias**
- **Definición de Hitos**
- **Dailys**
- **Sprint reviews**
- **Feedbacks de mejora**
  
### Autoras: :tecnóloga:

- **Nombres**: Irantzu Urkiola, Inés García, Aura Candela, Aida Bau
- **Curso**: Adalab - Data Analyst (Promo 52 - Julia Salander)
- **Módulo**: 2 - Bases de datos y SQL







