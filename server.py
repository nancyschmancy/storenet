""" Server file for Project Storenet """

from jinja2 import StrictUndefined
from flask import Flask, render_template, redirect, session, flash, request
from flask_debugtoolbar import DebugToolbarExtension
from model import Employee, Store, Post, District, connect_to_db, db
from datetime import datetime
from sqlalchemy import desc
from faker import Faker

fake = Faker()

app = Flask(__name__)

app.secret_key = 'SHHHHHH'

app.jinja_env.undefined = StrictUndefined


# ############################################################################


@app.route('/')
def index():
    """ This is the homepage. Will probably change. """

    posts = Post.query.order_by(desc('date')).all()
    return render_template('homepage.html', posts=posts)


@app.route('/view-post/<post_id>')
def view_post(post_id):
    """ View a single post """

    flash('you are trying to view post {}'.format(post_id))
    post = Post.query.filter(Post.post_id == post_id).one()

    return render_template('view-post.html', post=post)


@app.route('/view-stores')
def view_stores():
    """ Displays a directory of all stores. """

    stores = Store.query.order_by('district_id').all()  # get this to be in order
    districts = District.query.order_by('district_id').all()
    # package up the list of Store Managers into a dict:
    sm_obj = Employee.query.filter(Employee.pos_id == '01-SM').all()
    store_managers = {}
    for manager in sm_obj:
        store_managers[manager.store_id] = "{} {}".format(manager.fname, manager.lname)

    return render_template('view-stores.html', stores=stores,
                           districts=districts)
    # html <!-- Store Manager: {{ store_managers[store.store_id] }}<br><br> -->


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
def post_stuff():
    """ Here, the almighty admin can post stuff. """

    # This is for the list of stores in post-stuff.html
    stores = Store.query.all()

    # Fake content for fun
    fake_title = fake.catch_phrase()
    fake_text = fake.paragraphs()

    # QUESTION: Is it better to make a list of stores or do in Jinja?

    return render_template('post-stuff.html', stores=stores,
                           fake_text=fake_text, fake_title=fake_title)


@app.route('/preview-post', methods=['POST'])
def preview_post():
    """ Preview what the almighty admin has posted."""

    title = request.form.get('title')
    text = request.form.get('post-content')
    audience = request.form.get('audience')
    # if request.form.get('action'):
    #     action = True
    #     deadline = request.form.get('deadline')
    # else:
    #     action = False
    #     deadline = None
    emp_id = session['emp_id']
    date = datetime.now()

    post = Post(title=title, date=date, text=text, audience=audience, emp_id=emp_id)

    # Package all of this up in a pretty little dictionary
    # preview = {'title': title, 'text': text, 'audience': audience,
    #            'action': action, 'deadline': deadline}
    db.session.add(post)
    db.session.commit()

    flash("ERMAHGERD you posted something! It will soon show up on this here homepage.")
    return redirect('/')


# I WAS TRYING TO DO A POST PREVIEW HERE, WILL TRY JAVASCRIPT INSTEAD
# @app.route('/post-post', methods=['POST'])
# def post_post():
#     """ Posts the thing to the database """

#     preview = request.form.get('preview')
#     print preview

#     # title = preview['title']
#     # text = preview['text']
#     # audience = preview['audience']
#     # action = poreview['action']
#     # deadline = preview['deadline']
#     # pos_id = session['emp_id']

#     # post = Comm(title=title, text=text, audience=audience, action=action,
#     #             deadline=deadline, pos_id=pos_id)

#     # db.session.add(post)
#     # db.session.commit()

#     flash(preview)
#     return redirect('/')

# ############################################################################

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
