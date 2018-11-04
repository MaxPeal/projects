from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, create_engine
engine = create_engine('mysql+pymysql://mariadb:Super123@192.168.56.101/mydatabase')
metadata = MetaData()

users = Table( 'users', metadata,
    Column('id', Integer, 
        nullable=False,
        autoincrement=True,
        primary_key=True,
        index=True,
    ),
    Column('name', String(50), 
    ),
    Column('fullname', String(100), 
    ),
)
addresses = Table( 'addresses', metadata,
    Column('id', Integer, 
        primary_key=True,
    ),
    Column('user_id', None, 
        ForeignKey('users.id'),
    ),
    Column('email_address', String(200), 
    ),
)

metadata.create_all(engine)