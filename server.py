""" Server file for Project Storenet """

from jinja2 import StrictUndefined
from flask import Flask, render_template, redirect, session, flash, request, jsonify
from flask_debugtoolbar import DebugToolbarExtension
from model import Employee, Store, connect_to_db, db

app = Flask(__name__)

app.secret_key = 'SHHHHHH'

# Normally, if you refer to an undefined variable in a Jinja template,
# Jinja silently ignores this. This makes debugging difficult, so we'll
# set an attribute of the Jinja environment that says to make this an
# error.

app.jinja_env.undefined = StrictUndefined

# ############################################################################


@app.route('/')
def index():
    """ This is the homepage. Will probably change. """

    return render_template('homepage.html')


@app.route('/login', methods=['POST'])
def login():
    """ Processes login. """

    form_emp_id = request.form.get('form_emp_id')
    form_pw = request.form.get('form_pw')
    employee = Employee.query.filter(Employee.emp_id == form_emp_id).first()

    if employee and form_pw == employee.password:
        session['emp_id'] = employee.emp_id
        session['name'] = "{} {}".format(employee.fname, employee.lname)
        session['pos_id'] = employee.pos_id
        print session
    else:
        flash("Login didn't work. Try again.")

    return redirect('/')


@app.route('/logout')
def logout():
    """ Logs user out. """

    session.clear()
    flash('You are logged out.')
    return redirect('/')


@app.route('/profile')
def view_profile():
    """ View user profile. """

    employee = Employee.query.filter(Employee.emp_id == session['emp_id']).first()

    return render_template('profile.html', obj=employee)


@app.route('/post')
def post_comm():
    """ Here, the almighty admin can post stuff. """

    stores = Store.query.all()
    # QUESTION: Is it better to make a list of stores or do in Jinja?

    return render_template('post_comm.html', stores=stores)


# ############################################################################

# Need to find out what to add to this thing.
if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True
    app.jinja_env.auto_reload = app.debug  # make sure templates, etc. are not cached in debug mode

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)
    app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

    app.run(port=5000, host='0.0.0.0')
