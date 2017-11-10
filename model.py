"""Models and database functions for Storenet project."""

from flask_sqlalchemy import SQLAlchemy

# This is the connection to the PostgreSQL database; we're getting this through
# the Flask-SQLAlchemy helper library. On this, we can find the `session`
# object, where we do most of our interactions (like committing, etc.)

db = SQLAlchemy()


##############################################################################

class District(db.Model):
    """ District class thingy """

    __tablename__ = 'districts'

    district_id = db.Column(db.String(3), primary_key=True, nullable=False)
    name = db.Column(db.String(25), nullable=False)


class Store(db.Model):
    """ Store. """

    __tablename__ = 'stores'

    store_id = db.Column(db.String(3), primary_key=True, nullable=False)
    name = db.Column(db.String(255), nullable=False)
    address = db.Column(db.String(255), nullable=False)
    phone = db.Column(db.String(14), nullable=False)
    district_id = db.Column(db.String(3),
                            db.ForeignKey('districts.district_id'),
                            nullable=False)

    district = db.relationship('District', backref='stores')

    def __repr__(self):
        return '<Store {}, {}>'.format(self.store_id, self.name)


class Position(db.Model):
    """ Position class. """

    __tablename__ = 'positions'

    pos_id = db.Column(db.String(5), primary_key=True, nullable=False)
    title = db.Column(db.String(25), nullable=False)


class Employee(db.Model):
    """ Employee. """

    __tablename__ = 'employees'

    emp_id = db.Column(db.String(5), primary_key=True, nullable=False)
    fname = db.Column(db.String(25), nullable=False)
    lname = db.Column(db.String(25), nullable=False)
    ssn = db.Column(db.String(11), nullable=False)
    password = db.Column(db.String(5), nullable=False)
    store_id = db.Column(db.String(3), db.ForeignKey('stores.store_id'),
                         nullable=False)
    pos_id = db.Column(db.String(5), db.ForeignKey('positions.pos_id'),
                       nullable=False)

    store = db.relationship('Store', backref='employees')
    position = db.relationship('Position', backref='employees')

    def __repr__(self):
        """ This displays information about the employee. """

        return '<Employee {}, {} {}>'.format(self.emp_id, self.fname,
                                             self.lname)


class Post(db.Model):
    """ This will hold all info about a post. """

    __tablename__ = 'posts'

    post_id = db.Column(db.String(11), nullable=False, primary_key=True)
    title = db.Column(db.String(75), nullable=False)
    date = db.Column(db.DateTime, nullable=False)
    text = db.Column(db.Text, nullable=False)
    emp_id = db.Column(db.String(5), db.ForeignKey('employees.emp_id'),
                       nullable=False)

    employee = db.relationship('Employee', backref='posts')

    def __repr__(self):
        """ This displays information about the communication. """

        return '<Post {}, {}>'.format(self.post_id, self.title)


class ReadReceipt(db.Model):
    """ Tracks if post was read by employee. """

    __tablename__ = 'read_receipt'

    receipt_id = db.Column(db.Integer, primary_key=True, nullable=False,
                           autoincrement=True)
    post_id = db.Column(db.String(11), db.ForeignKey('posts.post_id'), nullable=False)
    emp_id = db.Column(db.String(5), db.ForeignKey('employees.emp_id'),
                       nullable=False)
    was_read = db.Column(db.Boolean, nullable=False)

    post = db.relationship('Post', backref='read_receipt')
    employee = db.relationship('Employee', backref='read_receipt')

    def __repr__(self):
        """ Displays info about read receipt """

        return "<WAS {} READ? {} {}>".format(self.post_id, self.employee.emp_id,
                                             self.was_read)


class Action(db.Model):
    """ Tracks action item. """

    __tablename__ = 'action'

    action_id = db.Column(db.Integer, primary_key=True, nullable=False,
                          autoincrement=True)
    post_id = db.Column(db.String(11), db.ForeignKey('posts.post_id'),
                        primary_key=True, nullable=False)
    # assigned_by = db.Column(db.String(5), db.ForeignKey('employees.emp_id'))
    emp_id = db.Column(db.String(5), db.ForeignKey('employees.emp_id'))
    complete = db.Column(db.Boolean)

    # assigned_by = db.relationship('Employee', backref='assigned_by')
    employee = db.relationship('Employee', backref='action')

    def __repr__(self):
        """ This displays information about for each communcation. """

        return '<Action on {}>'.format(self.post_id)


##############################################################################
# Helper functions - NTS: find out what these do


def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///storenet'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.app = app
    db.init_app(app)


if __name__ == '__main__':
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app
    connect_to_db(app)
    print 'You are connected to the database:'
