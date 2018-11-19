
from app01.samples.test_schema_sqlaorm_db_connect import sessions, engines
from app01.samples.test_schema_sqlaorm_table_create import Base, User, Address
import app01.samples.test_schema_sqlaorm_table_create

engine = engines["mydatabase"]

Base.metadata.create_all(engine)

session = sessions["mydatabase"]

user1 = User(name="John")
addr1 = Address(email_address="john101@localhost")
addr2 = Address(email_address="john102@localhost")
addr3 = Address(email_address="john103@localhost")
addr4 = Address(email_address="john104@localhost")

user1.addresses.append(addr1)
user1.addresses.append(addr2)
user1.addresses.append(addr3)
user1.addresses.append(addr4)

session.add(user1)
session.commit()

print(user1.addresses[1].email_address)
print(addr3.user.name)
