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

option = input('Digite 1 para popular os dados de recomendação ou 2 para procurar recomendações para um usuário em especifico. Ou 0 para sair\n')
while option != '0':
    get_data = GetData(connection, db)
    if option == '1':
        get_data.populate_reccomended_animes()
    elif option == '2':
        user_id = input('Digite o ID do usuário que quer obter recomendações\n')
        get_data.get_recomendation(user_id)
    option = input('Digite 1 para popular os dados de recomendação ou 2 para procurar recomendações para um usuário em especifico. Ou 0 para sair\n')


