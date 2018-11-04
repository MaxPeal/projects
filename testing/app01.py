#import sys
#sys.path.append('/home/vagrant/projects')
from testing.sa01_dml import users, users_select, conn, engine
# conn = engine.connect()
print(conn.execute(users_select).fetchall())
