""" Server file for Project Storenet """

from jinja2 import StrictUndefined
from flask import Flask, render_template, redirect, session, flash, request, jsonify
from flask_debugtoolbar import DebugToolbarExtension
from model import Employee, Store, Post, District, ReadReceipt, Category, Task, connect_to_db, db
from datetime import datetime
from sqlalchemy import desc
from faker import Faker
from markov import trump_text

fake = Faker()

app = Flask(__name__)

app.secret_key = 'SHHHHHH'

app.jinja_env.undefined = StrictUndefined


# ############################################################################


@app.route('/data.json')
def get_data():
    """ Gets data from storenet database for data visualization. """

    read = ReadReceipt.query.filter(ReadReceipt.was_read == True).count()
    unread = ReadReceipt.query.count()
    percent = read/unread
    data = []

    data.append([
        {'read': read},
        {'unread': unread},
    ])

    return jsonify(data)


@app.route('/')
def index():
    """ Homepage will display posts and tasks. """

    if session.get('emp_id'):
        read_receipts = ReadReceipt.query.filter(ReadReceipt.emp_id == session['emp_id']).all()
        incomplete_tasks = Task.query.filter(Task.emp_id == session['emp_id'],
                                                 Task.complete == False).all()
        complete_tasks = Task.query.filter(Task.emp_id == session['emp_id'],
                                               Task.complete == True).all()
        return render_template('homepage.html', read_receipts=read_receipts,
                               incomplete_tasks=incomplete_tasks,
                               complete_tasks=complete_tasks)
    else:
        return render_template('login.html')


@app.route('/login', methods=['POST'])
def login():
    """ Processes login. """

    # Grab emp_id & password from site
    form_emp_id = request.form.get('form_emp_id')
    form_pw = request.form.get('form_pw')

    # Grab employee object from database
    employee = Employee.query.filter(Employee.emp_id == form_emp_id).first()

    # Process login
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


@app.route('/post')
def post_stuff():
    """ Here, the almighty admin can post stuff. """

    # This is for the list of stores in post-stuff.html
    stores = Store.query.all()
    categories = Category.query.all()

    # Fake content for fun & giggles
    fake_title = trump_text(75)
    fake_text = '{} {} {}'.format(trump_text(1000), trump_text(1000),
                                  trump_text(1000))

    return render_template('post-stuff.html', stores=stores,
                           categories=categories, fake_text=fake_text,
                           fake_title=fake_title)


@app.route('/preview-post', methods=['POST'])
def preview_post():
    """ Preview what the almighty admin has posted."""

    title = request.form.get('title')
    cat_id = request.form.get('category')
    text = request.form.get('post-content')
    date = datetime.now()  # Make post ID the datetime to ensure uniqueness
    post_id = '{:0>4}{:0>2}{:0>2}{:0>2}{:0>2}{:0>2}'.format(date.year, date.month,
                                                            date.day, date.hour,
                                                            date.minute,
                                                            date.second)
    emp_id = session['emp_id']
    post = Post(post_id=post_id, title=title, cat_id=cat_id,
                date=date, text=text, emp_id=emp_id)
    db.session.add(post)

    # Determine who sees this post. This is a list of stores:
    audience = request.form.getlist('audience')

    # Add each employee from audience to read_receipt table:
    for store in audience:
        # Sales associates (03-SS) are excluded from seeing posts.
        employees = Employee.query.filter(Employee.store_id == store,
                                          db.not_(Employee.pos_id.in_(['03-SS']))).all()
        for employee in employees:
            emp_read_receipt = ReadReceipt(post_id=post_id, emp_id=employee.emp_id,
                                           was_read=False)
            db.session.add(emp_read_receipt)

    # Task section:
    if request.form.get('has_task'):
        for store in audience:
            task_item = request.form.get('task_item')
            deadline = request.form.get('deadline')
            task = Task(post_id=post_id, store_id=store, task_item=task_item, assigned_date=date,
                        deadline=deadline, complete=False)

            db.session.add(task)

    db.session.commit()

    flash("ERMAHGERD you posted something!")
    return redirect('/')


@app.route('/view-post/<post_id>')
def view_post(post_id):
    """ View a single post. """

    post = Post.query.filter(Post.post_id == post_id).one()

    # Read receipt:
    emp_id = session['emp_id']
    read_receipt = ReadReceipt.query.filter(ReadReceipt.post_id == post_id,
                                            ReadReceipt.emp_id == emp_id).one()
    read_receipt.was_read = True
    if read_receipt.read_date is None:  # Prevents read date from overwriting itself
        read_receipt.read_date = datetime.now()

    # Store specific task associated with this post
    store = Employee.query.filter(Employee.emp_id == emp_id).one().store
    task = Task.query.filter(Task.post_id == post_id, Task.store == store).one()

    db.session.commit()

    return render_template('view-post.html', post=post, task=task)


@app.route('/assign-task', methods=['POST'])
def assign_task():
    """ Assigns task to employee. """

    assignee = request.form.get('assignee')
    post_id = request.form.get('post_id')
    store_id = Employee.query.filter(Employee.emp_id == session['emp_id']).one().store.store_id
    print store_id, 'this is the store'
    task = Task.query.filter(Task.post_id == post_id,
                             Task.store_id == store_id).one()
    print task.task_id, 'this is the task ID'
    task.emp_id = assignee
    print store_id, post_id, assignee, task

    db.session.commit()

    return redirect('/')


@app.route('/complete-task', methods=['POST'])
def complete_task():
    """ Marks task as complete on homepage. """

    # Grab tasks completed from homepage & turn into list of integers
    tasks_from_form = request.form.getlist('completed-tasks')
    tasks_completed = map(int, tasks_from_form)

    # Grab all tasks associated with form submission
    all_tasks = Task.query.filter(Task.task_id.in_(tasks_completed)).all()

    # Update to completed
    for task in all_tasks:
        task.complete = True
        task.complete_date = datetime.now()

    db.session.commit()

    flash("Your tasks have been marked as complete")
    return redirect('/')


@app.route('/profile')
def view_profile():
    """ View user profile. """

    employee = Employee.query.filter(Employee.emp_id == session['emp_id']).first()

    return render_template('profile.html', obj=employee)


@app.route('/view-stores')
def view_stores():
    """ Displays a directory of all stores. """

    stores = Store.query.order_by('district_id').all()  # TODO: get this to be in order
    districts = District.query.order_by('district_id').all()

    # Create a store manager dictionary for store directory:
    sm_dict = {}
    store_managers = Employee.query.filter(Employee.pos_id == '01-SM').all()
    for manager in store_managers:
        sm_dict[manager.store_id] = "{} {}".format(manager.fname, manager.lname)

    return render_template('view-stores.html', stores=stores,
                           districts=districts, sm_dict=sm_dict)


# ############################################################################


if __name__ == "__main__":
    app.debug = True
    app.jinja_env.auto_reload = app.debug
    connect_to_db(app)

    DebugToolbarExtension(app)
    app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

    app.run(port=5000, host='0.0.0.0')
