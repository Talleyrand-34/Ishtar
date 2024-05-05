# models.py
from sqlalchemy import Column, Integer, String
from db import Base

class Product(Base):
    __tablename__ = "products"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), index=True)
    ean = Column(String(13))
