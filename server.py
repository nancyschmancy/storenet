""" Server file for Project Storenet """

import os
from jinja2 import StrictUndefined
from flask import (Flask, render_template, redirect, session, flash, request,
                   jsonify)
from flask_debugtoolbar import DebugToolbarExtension
from werkzeug.utils import secure_filename
from model import (Employee, Store, Post, District, AssignedPost, Category, Task,
                   connect_to_db, db)
from datetime import date, datetime, timedelta
from sqlalchemy import desc
from faker import Faker
from markov import trump_text
import requests

CURRENT_DATE = date.today()
print CURRENT_DATE
CURRENT_WEEKDAY = CURRENT_DATE.isoweekday()
OW_KEY = os.environ['OPENWEATHER_API_KEY']
UPLOAD_FOLDER = '/home/vagrant/src/storenet/static/pdf'
UPLOAD_URL_PREFIX = '/static/pdf/'
ALLOWED_EXTENSIONS = set(['pdf'])

fake = Faker()

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

app.secret_key = 'CHUCK_NORRIS'

app.jinja_env.undefined = StrictUndefined


# ############################################################################

def find_sunday(current_weekday):
    """ Finds Sunday based on current day """

    n_days_ago = 6 - current_weekday
    sunday = datetime.now() - timedelta(days=n_days_ago)
    monday = datetime.now() - timedelta(days=n_days_ago-1)
    tuesday = datetime.now() - timedelta(days=n_days_ago-2)
    wednesday = datetime.now() - timedelta(days=n_days_ago-3)
    thursday = datetime.now() - timedelta(days=n_days_ago-4)
    friday = datetime.now() - timedelta(days=n_days_ago-5)
    saturday = datetime.now() - timedelta(days=n_days_ago-6)

    return sunday, monday, tuesday, wednesday, thursday, friday, saturday


def get_weather(zipcode):
    """ Helper function to get weather information for store dashboard. """

    result = requests.get('http://api.openweathermap.org/data/2.5/weather?zip=' + zipcode + ',us&appid=' + OW_KEY)
    json_result = result.json()

    weather_dict = {}
    weather_dict['desc'] = json_result['weather'][0]['description']
    weather_dict['place'] = json_result['name']
    weather_dict['icon'] = 'http://openweathermap.org/img/w/{}.png'.format(json_result['weather'][0]['icon'])

    return weather_dict


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


def make_calendar():
    """ makes blah """

    weekday_num = CURRENT_DATE.isoweekday()
    return weekday_num

make_calendar()


@app.route('/')
def index():
    """ Homepage will display posts and tasks. """

    if session.get('emp_id'):
        # There has to be a better way to do this
        assigned_posts = (AssignedPost.query.filter
                         (AssignedPost.emp_id == session['emp_id'])
                          .order_by(desc(AssignedPost.assigned_post_id)).limit(10))
        incomplete_tasks = Task.query.filter(Task.emp_id == session['emp_id'],
                                             Task.complete.is_(False)).all()
        complete_tasks = Task.query.filter(Task.emp_id == session['emp_id'],
                                           Task.complete.is_(True)).all()
        categories = Category.query.all()
        all_tasks = Task.query.count()
        all_read = AssignedPost.query.count()
        store = Store.query.filter(Store.store_id == session['store_id']).one()
        weather = get_weather(store.zipcode)
        calendar = find_sunday(CURRENT_WEEKDAY) # Returns weekday number
        return render_template('homepage.html', assigned_posts=assigned_posts,
                               incomplete_tasks=incomplete_tasks,
                               complete_tasks=complete_tasks,
                               categories=categories, all_tasks=all_tasks,
                               all_read=all_read, current_date=datetime.now(),
                               store=store, weather=weather, calendar=calendar)
    else:
        return render_template('login.html')

    # do dictionaries!


@app.route('/task-<post_id>.json')
def get_data(post_id):
    """ Gets data from storenet database for data visualization. """

    complete_tasks = Task.query.filter(Task.post_id == post_id, Task.complete.is_(True)).count()
    incomplete_tasks = Task.query.filter(Task.post_id == post_id, Task.complete.is_(False)).count()

    data = [{'label': 'incomplete tasks', 'count': incomplete_tasks},
            {'label': 'complete tasks', 'count': complete_tasks}
            ]

    return jsonify(data)


@app.route('/read-<post_id>.json')
def get_post_data(post_id):
    """ Gets data from storenet database for data visualization. """

    read = AssignedPost.query.filter(AssignedPost.post_id == post_id, AssignedPost.was_read.is_(True)).count()
    unread = AssignedPost.query.filter(AssignedPost.post_id == post_id, AssignedPost.was_read.is_(False)).count()

    data = [{'label': 'read', 'count': read},
            {'label': 'unread', 'count': unread}
            ]

    return jsonify(data)


@app.route('/view-stores/<store_id>')
def display_store(store_id):
    """ Displays stuff about a store. """

    store_obj = Store.query.filter(Store.store_id == store_id).one()
    weather = get_weather(store_obj.zipcode)
    fake_sales = fake.random_int(5)

    metrics = {}
    metrics['tasks_complete'] = Task.query.filter(Task.store_id == store_id,
                                            Task.complete == True).count()
    metrics['tasks_incomplete'] = Task.query.filter(Task.store_id == store_id, Task.complete == False).count()
    metrics['unassigned_tasks'] = Task.query.filter(Task.store_id == store_id, Task.emp_id == None).all()

    metrics['num_assigned_posts_read'] = (db.session.query(AssignedPost)
            .join(Employee, Employee.emp_id == AssignedPost.emp_id)
            .join(Store, Store.store_id == Employee.store_id)
            .filter(Store.store_id == '999', AssignedPost.was_read == True).count())

    metrics['num_assigned_posts_unread'] = (db.session.query(AssignedPost)
            .join(Employee, Employee.emp_id == AssignedPost.emp_id)
            .join(Store, Store.store_id == Employee.store_id)
            .filter(Store.store_id == '999', AssignedPost.was_read == False).count())


    return render_template('view-store.html', metrics=metrics, fake_sales=fake_sales, store_obj=store_obj, weather=weather)


@app.route('/search', methods=['GET'])
def search():
    """ Simple search in posts """

    search_term = request.args.get('search-term')
    search_results = Post.query.filter((Post.title.ilike('%{} %'.format(search_term))) |
                                       (Post.text.ilike('%{} %'.format(search_term)))).all()

    return render_template('search-results.html', search_results=search_results,
                           search_term=search_term)
    # QUESTION: Can you get the search_term from the URL bar instead of
    # sending it to template via this way?


@app.route('/category/<cat_id>')
def display_by_cat(cat_id):
    """ Displays posts by category. """

    posts_by_cat = Post.query.filter(Post.cat_id == cat_id).all()

    return render_template('view-category.html', posts_by_cat=posts_by_cat)


@app.route('/login', methods=['POST'])
def login():
    """ Processes login. """

    # Grab emp_id & password from site
    form_emp_id = request.form.get('form-emp-id')
    form_pw = request.form.get('form-pw')

    # Grab employee object from database
    employee = Employee.query.filter(Employee.emp_id == form_emp_id).first()

    # Process login & create session
    if employee and form_pw == employee.password:
        session['emp_id'] = employee.emp_id
        session['name'] = "{} {}".format(employee.fname, employee.lname)
        session['pos_id'] = employee.pos_id
        session['store_id'] = employee.store_id
    else:
        flash("Login failed. Try again.")

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
    fake_title = trump_text(70)
    fake_text = '{} {} {}'.format(trump_text(1000), trump_text(1000),
                                  trump_text(1000))

    return render_template('post-stuff.html', stores=stores,
                           categories=categories, fake_text=fake_text,
                           fake_title=fake_title)


@app.route('/preview-post', methods=['POST'])
def preview_post():
    """ Preview what the almighty admin has posted."""

    # File section
    file = request.files['file']
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        pdf_url = '{}{}'.format(UPLOAD_URL_PREFIX, filename)
    else:
        pdf_url = None

    # Look up Flask Upload!
    title = request.form.get('title-input')
    cat_id = request.form.get('category')
    text = request.form.get('post-content')
    date = datetime.now()  # Make post ID the datetime to ensure uniqueness
    post_id = '{:0>4}{:0>2}{:0>2}{:0>2}{:0>2}{:0>2}'.format(date.year,
                                                            date.month,
                                                            date.day, date.hour,
                                                            date.minute,
                                                            date.second)
    emp_id = session['emp_id']
    post = Post(post_id=post_id, title=title, cat_id=cat_id,
                date=date, text=text, emp_id=emp_id, pdf_url=pdf_url)

    db.session.add(post)

    # Determine who sees this post. This is a list of stores:
    audience = request.form.getlist('audience')
    print audience

    # Add each employee from audience to assigned_post table:
    for store in audience:
        # Sales associates (03-SS) are excluded from seeing posts.
        employees = Employee.query.filter(Employee.store_id == store,
                                          db.not_(Employee.pos_id.in_(['03-SS']))).all()
                                    # consolidate this, refactor to make more flexible
        for employee in employees:
            emp_assigned_post = AssignedPost(post_id=post_id,
                                             emp_id=employee.emp_id,
                                             was_read=False)
            db.session.add(emp_assigned_post)

    # Task section:
    if request.form.get('has_task'):
        for store in audience:
            task_item = request.form.get('task_item')
            deadline = request.form.get('deadline')
            task = Task(post_id=post_id, store_id=store, task_item=task_item,
                        assigned_date=date, deadline=deadline, complete=False)

            db.session.add(task)

    db.session.commit()

    flash("ERMAHGERD you posted something!")
    return redirect('/')


@app.route('/view-post/<post_id>')
def view_post(post_id):
    """ View a single post. """

    post = Post.query.filter(Post.post_id == post_id).one()

    # Read assigned_post:
    emp_id = session['emp_id']
    assigned_post = AssignedPost.query.filter(AssignedPost.post_id == post_id,
                                              AssignedPost.emp_id == emp_id).one()
    assigned_post.was_read = True
    if assigned_post.read_date is None:  # Prevents read date from overwriting itself
        assigned_post.read_date = CURRENT_DATE

    # Try to make this a method i.e. assigned_post.mark_read

    # Store specific task associated with this post
    store = Employee.query.filter(Employee.emp_id == emp_id).one().store
    if post.tasks:
        task = Task.query.filter(Task.post_id == post_id, Task.store == store).one()
    else:
        task = 'chuck norris'  # I have to send something to Jinja regardless

    db.session.commit()

    return render_template('view-post.html', post=post, task=task)


@app.route('/assign-task', methods=['POST'])
def assign_task():
    """ Assigns task to employee. """

    assignee = request.form.get('assignee')
    post_id = request.form.get('post_id')
    store_id = Employee.query.filter(Employee.emp_id == session['emp_id']).one().store.store_id
    task = Task.query.filter(Task.post_id == post_id,
                             Task.store_id == store_id).one()
    task.emp_id = assignee

    db.session.commit()

    return redirect('/')


@app.route('/complete-task', methods=['POST'])
def complete_task():
    """ Marks task as complete on homepage. """

    # Grab tasks completed from homepage & turn into list of integers
    tasks_from_form = request.form.getlist('completed-tasks')
    tasks_completed = map(int, tasks_from_form)  # This could be any function!

    # Grab all tasks associated with form submission
    all_tasks = Task.query.filter(Task.task_id.in_(tasks_completed)).all()

    # Update to completed
    for task in all_tasks:
        task.complete = True
        task.complete_date = CURRENT_DATE

    db.session.commit()

    flash("Your tasks have been marked as complete")
    return redirect('/')


@app.route('/profile')
def view_profile():
    """ View user profile. """

    employee = (Employee.query.filter(Employee.emp_id == session['emp_id'])
                .first())

    return render_template('profile.html', obj=employee)


@app.route('/profile.json')
def calculate_rating():
    # TODO: You can probably consolidate this into one function called by stores and whatnot
    rating = {}
    num_tasks = Task.query.filter(Task.emp_id == session['emp_id']).count()
    num_tasks_complete = Task.query.filter(Task.emp_id == session['emp_id'],
                                            Task.complete == True).count()

    num_assigned_posts = AssignedPost.query.filter(AssignedPost.emp_id == session['emp_id']).count()
    num_assigned_posts_read = AssignedPost.query.filter(AssignedPost.emp_id == session['emp_id'],
                                            AssignedPost.was_read == True).count()

    rating = {'tasks': [num_tasks, num_tasks_complete], 'posts': [num_assigned_posts, num_assigned_posts_read]}

    return jsonify(rating)


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
