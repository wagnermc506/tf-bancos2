import sqlalchemy as db
from get_data import GetData

# config DB
config = {
    'host': 'localhost',
    'port': 3002,
    'user': 'newuser',
    'password': 'newpassword',
    'database': 'anime_rec'
}
db_user = config.get('user')
db_pwd = config.get('password')
db_host = config.get('host')
db_port = config.get('port')
db_name = config.get('database')
connection_str = f'mysql+pymysql://{db_user}:{db_pwd}@{db_host}:{db_port}/{db_name}'
engine = db.create_engine(connection_str)
connection = engine.connect()


get_data = GetData(connection, db)
get_data.populate_reccomended_animes()