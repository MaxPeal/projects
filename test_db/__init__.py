from sqlalchemy import create_engine


engine = create_engine('sqlite:///:memory:', echo=True)

from sqlalchemy.orm import sessionmaker
Session = sessionmaker()
Session.configure(bind=engine)
session = Session()


from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()






