import requests
import datetime
from airflow.decorators import dag,task
from airflow.hooks.postgres_hook import PostgresHook
import csv
import os
import subprocess


# def get_data_customer():
#     sql_stmt='''COPY customer TO 
#         'Downloads\\Exported_data.csv' 
#         DELIMITER ',' CSV HEADER'''
#     pg_hook=PostgresHook(
#         postgres_conn_id='postgresql_database',
#         schema='airflow'
#     )
#     pg_conn=pg_hook.get_conn()
#     cursor= pg_conn.cursor()
#     cursor.execute(sql_stmt)
#     data = cursor.fetchall()
#     print(data)   
#     with open('my_data.csv', 'w') as f:
#         writer = csv.writer(f)
#         for row in data:
#             writer.writerow(row)
#     print('hello world')

# @dag(start_date=datetime.datetime(2023, 7, 1), schedule="@daily")
# def get_data_database():
#     @task(task_id='get_data')
#     def get_data_customer():
#         sql_stmt='SELECT * FROM customer'
#         pg_hook=PostgresHook(
#             postgres_conn_id='postgresql_database',
#             schema='airflow'
#         )
#         pg_conn=pg_hook.get_conn()
#         cursor= pg_conn.cursor()
#         cursor.execute(sql_stmt)
#         data = cursor.fetchall()
#         for row in data:
#              print(row)   
#         try:
#             with open('dags/Exported_data.py', 'a') as f:
#                 writer = csv.writer(f)
#                 for row in data:
#                     writer.writerow(row)
#         except Exception as error:
#             print(error)                    
#         print('hello world')

#     get_data_customer() 

# get_data_database()

@dag(start_date=datetime.datetime(2023, 7, 1), schedule="@daily")
def get_backup_database():
    @task(task_id='get_backup')
    def get_backup():
        command = ['pg_dump','"host=host.docker.internal port=5432 dbname=airflow user=airflow password=airflow"', '>', 'dags/mydb_export.sql']
        try:
            process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
            output, err = process.communicate()
            print('Hello World')
            print(output)
            # if err:
            #     raise Exception(err)
            # with open('dags/mydb_export.sql', 'wb') as f:
            #     f.write(output)
        except Exception as error:
            print(error)
    get_backup() 
get_backup_database()

