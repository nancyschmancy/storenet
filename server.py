""" Project Storenet """

# What the heck is all this below? yeah?

from flask import Flask, render_template, redirect, session, flash, request
from flask_debugtoolbar import DebugToolbarExtension

# from jinja2 import StrictUndefined

# Oh yeah this instansiates an app or something like that.
app = Flask(__name__)

# A secret key is needed to use Flask sessioning features

app.secret_key = 'this-should-be-something-unguessable'


# Normally, if you refer to an undefined variable in a Jinja template,
# Jinja silently ignores this. This makes debugging difficult, so we'll
# set an attribute of the Jinja environment that says to make this an
# error.

# app.jinja_env.undefined = jinja2.StrictUndefined

# ############################################################################

@app.route('/')
def index():
    """ This is the homepage. Will probably change. """

    return render_template('homepage.html')


@app.route('/login', methods=['POST'])
def login():
    """ Processes login. """

    user_id = request.form.get('user_id')
    password = request.form.get('password')
    # Check this against a database

    session['user_id'] = user_id

    print session

    flash('You are logged in as {} and you entered the password {}.'.format(user_id, password))

    return redirect('/')


@app.route('/logout')
def logout():
    """ Logs user out. """

    session.clear()

    flash('You are logged out.')

    return redirect('/')

# ############################################################################

# Need to find out what to add to this thing.
if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True
    app.jinja_env.auto_reload = app.debug  # make sure templates, etc. are not cached in debug mode

    # connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)
    app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False


    app.run(port=5000, host='0.0.0.0')
