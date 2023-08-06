import requests
import datetime
from airflow.decorators import dag,task

@dag(start_date=datetime.datetime(2023, 7, 1), schedule="@daily")
def send_message_telegram():
    @task(task_id='send_message')
    def send_message():
        print("Hello Hoai Nam")
        data={
            "chat_id": 1622695632,
            "text": "sdfsdfsdfsdf",
        }
        try:
            respone = requests.post(
            url='https://api.telegram.org/bot6126031521:AAGukR7TwEusGSDgPSaQ26SNAQetR79RjHY/sendMessage',
            json=data)
            print(respone.json())
        except Exception as e:
            print(e)
    send_message()
send_message_telegram()

