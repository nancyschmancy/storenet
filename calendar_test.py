from model import (Employee, Store, Post, District, AssignedPost, Category, Task,
                   connect_to_db, db)
from datetime import date, datetime, timedelta

def find_sunday(current_weekday):
    """ EXPERIMENTAL CALENDAR THING """

    sun = datetime.now() - timedelta(days=current_weekday)
    mon = datetime.now() - timedelta(days=current_weekday-1)
    tue = datetime.now() - timedelta(days=current_weekday-2)
    wed = datetime.now() - timedelta(days=current_weekday-3)
    thu = datetime.now() - timedelta(days=current_weekday-4)
    fri = datetime.now() - timedelta(days=current_weekday-5)
    sat = datetime.now() - timedelta(days=current_weekday-6)

    print sun

find_sunday(6)


