from sqlalchemy import Column, Integer, String, ForeignKey, Table
from sqlalchemy.orm import relationship
from test_db import Base, session, engine


class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True)
    name = Column(String(20))

    def __repr__(self):
        return """
<User(
    id='%s',
    name='%s',
)>
        """ % (
            self.id,
            self.name,
        )


class Channel(Base):
    __tablename__ = 'channel'
    id = Column(Integer, primary_key=True)
    name = Column(String(20))

    def __repr__(self):
        return """
<Channel(
    id='%s',
    parent='%s',
)>
        """ % (
            self.id,
            self.name,
        )


association_table = Table('association', Base.metadata,
                          Column('user_id', Integer, ForeignKey('user.id')),
                          Column('channel_id', Integer, ForeignKey('channel.id')),
                          )


# relationship: Many to Many (many user to many channel)
# many
User.channels = relationship("Channel", secondary=association_table, back_populates="users")
# many
Channel.users = relationship("User", secondary=association_table, back_populates="channels")

# create tables
Base.metadata.create_all(engine)

user1 = User(name="Koji")
user2 = User(name="Masa")
user3 = User(name="Mariko")
user4 = User(name="Rio")

channel1 = Channel(name="WSJ")
channel2 = Channel(name="Nikkei")

session.add(user1)
session.add(user2)
session.add(user3)
session.add(user4)
session.add(channel1)
session.add(channel2)
session.commit()

print(user1)
print(user2)
print(user3)
print(user4)
print(channel1)
print(channel2)