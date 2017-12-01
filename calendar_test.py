from datetime import datetime, timedelta


def find_sunday(current_weekday):
    """ Finds Sunday based on current day """

    n_days_ago = 8 - current_weekday
    sunday = datetime.now() - timedelta(days=n_days_ago)
    monday = datetime.now() - timedelta(days=n_days_ago-1)
    tuesday = datetime.now() - timedelta(days=n_days_ago-2)
    wednesday = datetime.now() - timedelta(days=n_days_ago-3)
    thursday = datetime.now() - timedelta(days=n_days_ago-4)
    friday = datetime.now() - timedelta(days=n_days_ago-5)
    saturday = datetime.now() - timedelta(days=n_days_ago-6)

    return sunday, monday, tuesday, wednesday, thursday, friday, saturday

current_weekday = datetime.now().isoweekday()
print current_weekday
print find_sunday(current_weekday)


