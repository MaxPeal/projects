from sqlalchemy import func, select
from testing.sa01 import engine
from testing.sa01 import users
from testing.sa01 import addresses

conn = engine.connect()

users_insert = users.insert()
# example:
# conn.execute(users_insert , [
#    {
#        'id': 'fielddata',
#        'name': 'fielddata',
#        'fullname': 'fielddata',
#    },
# ])
addresses_insert = addresses.insert()
# example:
# conn.execute(addresses_insert , [
#    {
#        'id': 'fielddata',
#        'user_id': 'fielddata',
#        'email_address': 'fielddata',
#    },
# ])

users_select = select([users])
# example:
# conn.execute(users_select).fetchall()
addresses_select = select([addresses])
# example:
# conn.execute(addresses_select).fetchall()

users_update = users.update()
# example:
# conn.execute(users_update, [
#    {
#        'id': 'fielddata',
#        'name': 'fielddata',
#        'fullname': 'fielddata',
#    },
# ])
addresses_update = addresses.update()
# example:
# conn.execute(addresses_update, [
#    {
#        'id': 'fielddata',
#        'user_id': 'fielddata',
#        'email_address': 'fielddata',
#    },
# ])

users_delete = users.delete()
# example:
# conn.execute(users_delete)
addresses_delete = addresses.delete()
# example:
# conn.execute(addresses_delete)
