MAX_COUNT = 1
class GetData:
    def __init__(self, connection, db):
        self.connection = connection
        self.db = db
        self.connected_animes = {}

    def populate_reccomended_animes(self):
        users = self.get_full_info()
        for user in users:
            for i in range(len(user["liked_animes"])):
                for j in range(len(user["liked_animes"])):
                    for gender in user["liked_animes"][i]['genders']:
                        if gender in user["liked_animes"][j]['genders']:
                            print(f'Anime {user["liked_animes"][i]["id"]} conectado com {user["liked_animes"][j]["id"]}')
                            break


    def get_full_info(self):
        users_full_info_list = []
        user_list = self.get_user_data()
        i = 0
        for user in user_list:
            user_full_info = {"id": user['id']}

            i+=1
            if i > MAX_COUNT:
                break
        
            watched_animes  = self.get_watched_animes(user['id'])
            user_full_info["liked_animes"] = []
            for anime in watched_animes:
                if anime['nota'] >= 7:
                    liked_anime_dict = {
                        "id": anime['anime'],
                    }
                    anime_genders_index = self.get_anime_gender_index(anime['anime'])
                    anime_genders = []
                    for gender_index in anime_genders_index:
                        gender_info = self.get_gender_info(gender_index['genero'])
                        anime_genders.append(gender_info['nome'])
                    liked_anime_dict['genders'] = anime_genders
                    user_full_info['liked_animes'].append(liked_anime_dict)
            users_full_info_list.append(user_full_info)
        return users_full_info_list

                
    def connect_liked_animes(self):
        pass

    def get_user_data(self):
        return self.connection.execute(self.db.text('select * from USUARIO'))
    
    def get_watched_animes(self, user_id):
        return  self.connection.execute(self.db.text(f'select * from assiste where usuario={user_id}'))
    
    def get_anime_info(self, anime_id):
        return self.connection.execute(self.db.text(f'select * from ANIME where id={anime_id}')).first()
    
    def get_anime_gender_index(self, anime_id):
        return self.connection.execute(self.db.text(f'select * from participa where anime={anime_id}'))
    
    def get_gender_info(self, gender_id):
        return self.connection.execute(self.db.text(f'select * from GENERO where id={gender_id}')).first()
        
            