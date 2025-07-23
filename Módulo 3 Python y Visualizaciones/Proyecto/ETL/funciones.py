import pandas as pd
import warnings
warnings.filterwarnings("ignore")
import numpy as np
from IPython.display import display
from sklearn.impute import SimpleImputer
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import IterativeImputer
from sklearn.impute import KNNImputer
import matplotlib.pyplot as plt
from sqlalchemy import create_engine  
import pymysql

# Función de extracción de datos
def lectura_archivo(file_path):
    print(f"Extrayendo datos del archivo {file_path}...")
    data = pd.read_csv(file_path)
    print(data.head())
    return data

# Función EDA del Dataframe, incluyendo algunos for y algunos if/else:
def exploracion(df):
        print(f"La forma:")
        print(f"{df.shape}\n")
        print('_'*80)
        print(f"Las columnas:")
        print(f"{df.columns}\n")
        print('_'*80)
        print(f"Los tipos de datos:")
        print(f"{df.dtypes}\n")
        print('_'*80)
        print('Datos únicos por columna:')
        display(df.nunique())
        print('_'*80)
        print(f"Los nulos:")
        print(f"{df.isnull().sum()}\n")
        print('_'*80)

        #PORCENTAJES NULOS
        porcentajes_nulos = df.isnull().mean() * 100
        cols_numericas = df.select_dtypes(include=['number']).columns
        cols_categoricas = df.select_dtypes(include=['object', 'category']).columns
        nulos_numericas = porcentajes_nulos[cols_numericas]
        nulos_categoricas = porcentajes_nulos[cols_categoricas]
        
        if (porcentajes_nulos > 0).any():
            if (nulos_numericas > 0).any():
                print('Porcentajes de nulos en columnas numéricas:')
                print(nulos_numericas.sort_values(ascending=False))
            else:
                print('No hay nulos en columnas numéricas.')
                print('_'*80)
            
            if (nulos_categoricas > 0).any():
                print('\nPorcentajes de nulos en columnas categóricas:')
                print(nulos_categoricas.sort_values(ascending=False))
            else:
                print('No hay nulos en columnas categóricas.')
        else:
            pass
        print('_'*80)

        #CONTEO SOLO PARA COLUMNAS CON NULOS
        columnas_cat_con_nulos = [col for col in cols_categoricas if df[col].isnull().any()]
        if columnas_cat_con_nulos:
            print('Distribución de valores en columnas categóricas con nulos:')
            for col in columnas_cat_con_nulos:
                print(f"\nRevisando '{col}':")
                print(df[col].value_counts(dropna=False))
            print('_'*80)

        #DUPLICADOS
        cantid_duplicados = df.duplicated().sum()
        print(f'Cantidad de duplicados: {cantid_duplicados}')
        if cantid_duplicados >0:
            print('Primeros duplicados:')
            display(df[df.duplicated()].head(3))
        else:
            print('No hay duplicados')
        print('_'*80)

        #DESCRIPCIONES
        columnas_num = df.select_dtypes(include='number')
        if not columnas_num.empty:
            print('Descripción datos numéricos:')
            display(columnas_num.describe().T)
        else:
            print('No hay datos de tipo numérico')
        print('_'*80)
        columnas_str = df.select_dtypes(include='object')
        if not columnas_str.empty:
            print('Descripción datos string (moda):')
            display(columnas_str.describe().T)
        else:
            print('No hay datos de tipo string')
        print('_'*80)
        
        return

# Función visualizaciones:
def graficos(df):
    # Visualización de columnas numéricas
    columnas_num = df.select_dtypes(include=['number']).columns
    bins = 30
    colores = ['khaki', 'steelblue', 'darkorange', 'indianred', 'orchid',
               'mediumpurple', 'goldenrod', 'teal', 'seagreen']
    
    if len(columnas_num) > 0:
        num_cols = 4
        num_filas = (len(columnas_num) + num_cols - 1) // num_cols
        fig, axes = plt.subplots(num_filas, num_cols, figsize=(5 * num_cols, 4 * num_filas))
        axes = axes.flatten()

        for i, col in enumerate(columnas_num):
            color = colores[i % len(colores)]
            df[col].hist(bins=bins, ax=axes[i], edgecolor='black', color=color )
            axes[i].set_title(col, fontsize=10)

        for j in range(i + 1, len(axes)):
            axes[j].axis('off')

        plt.tight_layout()
        plt.subplots_adjust(top=0.95, bottom=0.1, hspace=0.8)
        plt.show()
    else:
        pass

    # Visualización de columnas categóricas
    columnas_cat = df.select_dtypes(include=['O']).columns
    
    if len(columnas_cat) == 0:
        return  

    # Separamos columnas según tipo de gráfico
    cat_bar = []
    cat_pie = []

    for col in columnas_cat:
        if df[col].nunique() > 4:
            cat_bar.append(col)
        else:
            cat_pie.append(col)

    # Creamos un subplot automático e iteramos a la vez para sacar el índice y la columna para crear los gráficos de barras
    if cat_bar:
        num_cols = 2
        num_filas = (len(cat_bar) + num_cols - 1) // num_cols
        fig, axes = plt.subplots(num_filas, num_cols, figsize=(num_cols * 6, num_filas * 4))
        axes = axes.flatten()

        for i, col in enumerate(cat_bar):
            color = colores[i % len(colores)]
            df[col].value_counts().plot(kind='bar', ax=axes[i], edgecolor='black', color=color)
            axes[i].set_title(f'Distribución de {col}')
            axes[i].set_xlabel(col)
            axes[i].set_ylabel('Frecuencia')
            axes[i].tick_params(axis='x', rotation=90)

        for j in range(i + 1, len(axes)):
            axes[j].axis('off')

        plt.tight_layout()
        plt.subplots_adjust(hspace=0.6)
        plt.show()

    # # Creamos un subplot automático e iteramos a la vez para sacar el índice y la columna para crear los gráficos de quesitos
    if cat_pie:
        num_cols = 4
        num_filas = (len(cat_pie) + num_cols - 1) // num_cols
        fig, axes = plt.subplots(num_filas, num_cols, figsize=(num_cols * 6, num_filas * 5))
        axes = axes.flatten()

        for i, col in enumerate(cat_pie):
            data = df[col].value_counts()
            colors = colores[:len(data)]
            axes[i].pie(data, labels=data.index, autopct='%1.1f%%', startangle=130, colors = colors, wedgeprops={'edgecolor': 'black'} )
            axes[i].set_title(f'Porcentajes de {col}')

        for j in range(i + 1, len(axes)):
            axes[j].axis('off')

        plt.tight_layout()
        plt.subplots_adjust(hspace=0.6)
        plt.show()

# Función de limpieza
def limpieza(df):
    nuevas_columnas = {}
    for col in df.columns:
        nuevas_columnas[col] = col.lower().replace(".", "").replace("_","").strip()
    
    columnas_str = df.select_dtypes(include=['object']).columns
    for col in columnas_str:
        mask = df[col].notna()
        df.loc[mask, col] = df.loc[mask, col].str.lower().str.replace(",", ".").str.replace("_", "").str.strip()
    
    #La máscara crea un filtro para omitir las filas en cada columna que tenga valores nulos.
    #df.loc aplica los cambios solo a los valores no nulos.

    df.rename(columns = nuevas_columnas, inplace = True)

    return df 

# Funciones imputación:
def usar_iterative_imputer(df, col, umbral=0.4):
        
        # Obtenemos la matriz de correlaciones absolutas
        correlaciones = df.corr().abs()
        # Eliminamos la autocorrelación (relación de una columna consigo misma, que siempre será 1)
        correlaciones_col = correlaciones[col].drop(labels=[col])
        # Extraemos el resultado de si hay correlaciones significantes comparando con el umbral, en una variable
        correlaciones_significativas = correlaciones_col[correlaciones_col >= umbral]
        # Con el 'not' nos devolverá True si hay al menos una correlación >= umbral
        return not correlaciones_significativas.empty  

def imputacion_nulos(df):
    # Imputación de columnas categóricas:
    columnas_categóricas_con_nulos = df[df.columns[df.isnull().any()]].select_dtypes(include = "O").columns
    for col in columnas_categóricas_con_nulos:
        nulos = df[col].isnull().sum()
        total = len(df)
        porcentaje_nulos = nulos / total

        if porcentaje_nulos > 0.20:
            # Si hay más del 20% de nulos; rellenar con "Desconocido"
            df[col] = df[col].fillna("Desconocido")
            print(f"{col} se va a imputar con Desconocido")
        else:
            # Menos del 20% de nulos
            valores = df[col].value_counts(dropna=True)
            if len(valores) >= 2:
                # Calcular diferencia porcentual entre los dos más frecuentes
                primero = valores.iloc[0]
                segundo = valores.iloc[1]
                diferencia = (primero - segundo) / total

                if diferencia > 0.20:
                    # Si la diferencia entre los dos más comunes > 20% → usar moda
                    moda = valores.idxmax() #es lo mismo que decirle la moda = df[col].mode[0]
                    df[col] = df[col].fillna(moda)
                    print(f"{col} se va a imputar con la moda")
                else:
                    # Si no → usar "Desconocido"
                    df[col] = df[col].fillna("Desconocido")
                    print(f"{col} se va a imputar con Desconocido")
            else:
                moda = valores.idxmax() #es lo mismo que decirle la moda = df[col].mode[0]
                df[col] = df[col].fillna(moda)
                print(f"{col} se va a imputar con la moda")
                
    # Imputación de columnas numéricas:
    columnas_numericas_con_nulos = df[df.columns[df.isnull().any()]].select_dtypes(include = "number").columns

    # Sacamos el porcentaje de nulos por columna:
    for col in columnas_numericas_con_nulos:
        nulos = df[col].isnull().sum()
        total = len(df)
        porcentaje_nulos = nulos / total

        # Si es mayor a 20, imputamos con técnicas avanzadas según si hay o no correlación entre las columnas
        if porcentaje_nulos > 0.20:
            if usar_iterative_imputer(df, col, umbral=0.3) == True:
                imputer_iter = IterativeImputer(max_iter = 150, random_state = 42)
                df[col] = imputer_iter.fit_transform(df[[col]]).ravel()  # para aplanar el array que nos devuelve
                print(f"{col} se va a imputar con IterativeImputer")
            
            else:
                imputer_knn = KNNImputer(n_neighbors=10)
                df[col] = imputer_knn.fit_transform(df[[col]]).ravel()
                print(f"{col} se va a imputar con KNNImputer")

        # Si es menor de 20, imputamos con media o mediana según la diferencia entre ellas
        else:
            media = df[col].mean()
            mediana = df[col].median()
            diferencia = abs(media - mediana) / media
            if diferencia < 0.05:
                df[col] = df[col].fillna(df[col].mean())
                print(f"{col} se va a imputar con la media")
            else:
                df[col] = df[col].fillna(df[col].median())
                print(f"{col} se va a imputar con la mediana")
    
    return df

# Funcion de conexión:
# Configuramos la base de datos
host = '127.0.0.1'
user = 'root'
password = 'AlumnaAdalab'
database = 'proyecto_3'

def conexion(database):
    # Conectar a MySQL usando pymysql
    connection = pymysql.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    # Crear un cursor
    cursor = connection.cursor()

    # Cerrar la conexión
    connection.close()

def carga_datos(tabla, df_datos):
    print(f"Cargando datos en la tabla {tabla}...")

    # Crear conexión a MySQL usando SQLAlchemy
    engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}/{database}')

    # Insertar datos desde el DataFrame en MySQL
    df_datos = pd.DataFrame(df_datos).to_sql(tabla, con=engine, if_exists='append', index=False)
    print(f"Datos insertados en la tabla {tabla} exitosamente.")

# Función de ETL completa
def proceso_etl(tabla, csv):

    # Extraer, transformar y cargar los datos del csv
    df = lectura_archivo(csv)
    exploracion(df)
    graficos(df)
    print('no se corta antes de limpieza')
    df_modificado = limpieza(df)
    print('no se corta despues de limpieza')
    df_imputado = imputacion_nulos(df_modificado)
    print('ha llegado a nulos')
    sql = conexion(database)
    carga_datos(tabla, df_imputado)