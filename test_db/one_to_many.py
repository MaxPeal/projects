from sqlalchemy import Column, Integer, String, ForeignKey, Table
from sqlalchemy.orm import relationship
from test_db import Base, session, engine


class Parent(Base):
    __tablename__ = 'parent'
    id = Column(Integer, primary_key=True)
    name = Column(String(20))

    def __repr__(self):
        return """
<Parent(
    id='%s',
    name='%s',
)>
        """ % (
            self.id,
            self.name,
        )


class Child(Base):
    __tablename__ = 'child'
    id = Column(Integer, primary_key=True)
    name = Column(String(20))

    def __repr__(self):
        return """
<Child(
    id='%s',
    name='%s',
)>
        """ % (
            self.id,
            self.name,
        )




# relationship: One to Many
# one
Parent.children = relationship("Child", back_populates="parent")
# many
Child.parent_id = Column(Integer, ForeignKey('parent.id'))
Child.parent = relationship("Parent", back_populates="children")

# create tables
Base.metadata.create_all(engine)

parent1 = Parent(name="Koji")
parent2 = Parent(name="Masa")

child1 = Child(name="Rio", parent=parent1)
child2 = Child(name="Riki", parent=parent1)
child3 = Child(name="Dylan", parent=parent2)
child4 = Child(name="Mike")

parent1.children.append(child4)
session.add(child1)
session.add(child2)
session.add(child3)
session.commit()

print(parent1.children)
#print(parent2)
#print(child1)
#print(child2)
#print(child3)
#print(child4)
