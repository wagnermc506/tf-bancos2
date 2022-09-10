MAX_USERS = 50
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
                            self.connection.execute(self.db.text(f'insert into conecta_anime_recomendados (anime1, anime2, usuario) VALUES ({user["liked_animes"][i]["id"]}, {user["liked_animes"][j]["id"]}, {user["id"]})'))
                            break


    def get_full_info(self):
        users_full_info_list = []
        user_list = self.get_user_data()
        i = 0
        for user in user_list:
            i+=1
            if i > MAX_USERS:
                break
            user_full_info = {"id": user['id']}
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
    
    def get_recommended_anime(self, anime_id):
        return self.connection.execute(self.db.text(f'select COUNT(anime2) as recommendTimes, anime2 from conecta_anime_recomendados where anime1={anime_id} group by anime2'))

    def get_recomendation(self, user_id):
        watched_animes = self.get_watched_animes(user_id)
        recommend_anime_set = set()
        for anime in watched_animes:
            recommend_anime_list = self.get_recommended_anime(anime['anime'])
            for recommended_anime in recommend_anime_list:
                anime_info = self.get_anime_info(recommended_anime['anime2'])
                if recommended_anime["recommendTimes"] > 10:
                    print(recommended_anime["recommendTimes"])
                    recommend_anime_set.add(anime_info['nome'])
        # print(recommend_anime_set)

            