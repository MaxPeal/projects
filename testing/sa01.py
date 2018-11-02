#!/usr/bin/python3
# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, create_engine
engine = create_engine('mysql+pymysql://mariadb:Super123@192.168.56.101/mydatabase')
metadata = MetaData()
users = Table( 'users', metadata,
    Column( name='id', type=Integer, primary_key=True),
    Column( name='name', type=String),
    Column( name='fullname', type=String),
)
addresses = Table( 'addresses', metadata,
    Column( name='id', type=Integer, primary_key=True),
    Column( name='user_id', type=None, ForeignKey('users.id')),
    Column( name='email_address', type=String, nullable=False),
)

metadata.create_all(engine)
