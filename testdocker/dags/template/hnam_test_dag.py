import datetime

from airflow.decorators import dag,task
from airflow.operators.empty import EmptyOperator


@dag(start_date=datetime.datetime(2023, 7, 1), schedule="@daily")
def hoainam_dag():
    @task(task_id='first_task',)
    def hello_world():
        print("Hello Hoai Nam")
    hello_world()>>hello_world()

hoainam_dag()
