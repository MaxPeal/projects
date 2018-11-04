from sqlalchemy import func, select
from sa01 import engine
from sa01 import users

conn = engine.connect()

users_insert = users.insert()
#conn.execute(users_insert , [
#    {
#        'name': 'name_test' ,
#        'fullname': 'fullname_test' ,
#    },
#    {
#        'name': 'name_test2' ,
#        'fullname': 'fullname_test2' ,
#    },
#])

users_select = select([users])
#conn.execute(users_select).fetchall()

users_update = users.update()
#conn.execute(users_update, [
#
#])
