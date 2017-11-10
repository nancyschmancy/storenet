""" Server file for Project Storenet """

from jinja2 import StrictUndefined
from flask import Flask, render_template, redirect, session, flash, request
from flask_debugtoolbar import DebugToolbarExtension
from model import Employee, Store, Post, District, ReadReceipt, Category, connect_to_db, db
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

    if session.get('emp_id'):
        posts = []
        read_receipts = ReadReceipt.query.filter(ReadReceipt.emp_id == session['emp_id']).all()
        for receipt in read_receipts:
            posts.append(Post.query.filter(Post.post_id == receipt.post_id).first())
            print posts
        return render_template('homepage.html', posts=posts)
    else:
        return render_template('login.html')


@app.route('/view-post/<post_id>')
def view_post(post_id):
    """ View a single post """

    post = Post.query.filter(Post.post_id == post_id).one()

    return render_template('view-post.html', post=post)


@app.route('/view-stores')
def view_stores():
    """ Displays a directory of all stores. """

    stores = Store.query.order_by('district_id').all()  # get this to be in order
    districts = District.query.order_by('district_id').all()

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
    categories = Category.query.all()

    # Fake content for fun
    fake_title = fake.catch_phrase()
    fake_text = fake.paragraph()

    # QUESTION: Is it better to make a list of stores or do in Jinja?

    return render_template('post-stuff.html', stores=stores, categories=categories,
                           fake_text=fake_text, fake_title=fake_title)


@app.route('/preview-post', methods=['POST'])
def preview_post():
    """ Preview what the almighty admin has posted."""

    # Make post ID the datetime to ensure uniqueness
    date = datetime.now()
    title = request.form.get('title')
    cat_id = request.form.get('category')
    text = request.form.get('post-content')
    post_id = '{}{}{}{}{}{}'.format(date.year, date.month, date.day, date.hour,
                                    date.minute, date.second)
    emp_id = session['emp_id']
    post = Post(post_id=post_id, title=title, cat_id=cat_id,
                date=date, text=text, emp_id=emp_id)
    db.session.add(post)

    audience = request.form.getlist('audience')

    # Add employees to read_receipt table:
    for store in audience:
        # Sales associates (03-SS) are excluded from seeing posts.
        employees = Employee.query.filter(Employee.store_id == store,
                                          db.not_(Employee.pos_id.in_(['03-SS']))).all()
        for employee in employees:
            print employee.emp_id
            emp_read_receipt = ReadReceipt(post_id=post_id, emp_id=employee.emp_id,
                                           was_read=False)
            db.session.add(emp_read_receipt)

    # if request.form.get('action'):
    #     action = True
    #     deadline = request.form.get('deadline')
    # else:
    #     action = False
    #     deadline = None

    db.session.commit()

    flash("ERMAHGERD you posted something!")
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
