#!/usr/bin/python3

import sqlalchemy
import sqlalchemy.orm

engine=sqlalchemy.create_engine('sqlite:///test.db',echo=True)
session=sqlalchemy.orm.sessionmaker(bind=engine)
session=sqlalchemy.orm.Session()

tablename='people'

print(session.query(tablename))

