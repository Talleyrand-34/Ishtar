# db.py
from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import sessionmaker, declarative_base

# Credenciales fijas
POSTGRES_DB = "seidor_db"
POSTGRES_USER = "anonymous_not_seidor_user"
POSTGRES_PASSWORD = "tst"
POSTGRES_HOST = "localhost"
POSTGRES_PORT = "5431"

# Construir la cadena de conexión con las credenciales fijas
DATABASE_URL = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}"

# Imprimir la cadena de conexión para confirmar
print(f"Cadena de conexión: {DATABASE_URL}")

# Crear el motor y la sesión
engine = create_engine(DATABASE_URL)
metadata = MetaData()
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Crea la base para los modelos
Base = declarative_base()
