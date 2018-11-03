# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, create_engine
engine = create_engine('mysql+pymysql://mariadb:Super123@192.168.56.101/mydatabase')
metadata = MetaData()
users = Table( 'users', metadata,
    Column( name='id', type_=Integer, primary_key=True),
    Column( name='name', type_=String(50)),
    Column( name='fullname', type_=String(100)),
)
addresses = Table( 'addresses', metadata,
    Column( name='id', type_=Integer, primary_key=True),
    Column( 'user_id', None, ForeignKey('users.id')),
    Column( name='email_address', type_=String(200), nullable=False),
)

metadata.create_all(engine)
