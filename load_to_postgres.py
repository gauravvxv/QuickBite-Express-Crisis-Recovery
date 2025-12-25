import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

HOST = os.getenv('DB_HOST')
USER = os.getenv('DB_USER')
PORT = os.getenv('DB_PORT')
NAME = os.getenv('DB_NAME')
PASSWORD = os.getenv('DB_PASSWORD')

engine = create_engine(
    f'postgresql://{USER}:{PASSWORD}@{HOST}:{PORT}/{NAME}'
)

customers = pd.read_csv('./Datasets/customers.csv')
orders = pd.read_csv('./Datasets/orders.csv')
order_items = pd.read_csv('./Datasets/order_items.csv')
d_partners = pd.read_csv('./Datasets/delivery_partner.csv')
menu = pd.read_csv('./Datasets/menu.csv')
restaurants = pd.read_csv('./Datasets/restaurant.csv')
delivery = pd.read_csv('./Datasets/delivery.csv')
rating = pd.read_csv('./Datasets/ratings.csv')

customers.to_sql('customers',engine, if_exists='replace',index=False)
orders.to_sql('orders',engine,if_exists='replace',index=False)
order_items.to_sql('order_items',engine,if_exists='replace',index=False)
d_partners.to_sql('d_partners',engine,if_exists='replace',index=False)
menu.to_sql('menu',engine,if_exists='replace',index=False)
restaurants.to_sql('restaurants',engine,if_exists='replace',index=False)
delivery.to_sql('delivery',engine,if_exists='replace',index=False)
rating.to_sql('rating',engine,if_exists='replace',index=False)
print('all data is loaded properly on postgresql')




