# Criar scripts
Para rodar o gerador, baixe o dataset abaixo, extraia numa pasta e renomeie-a para 'anime'.

https://www.kaggle.com/datasets/hernan4444/anime-recommendation-database-2020?select=anime.csv


# Rodar data mining

## DB

Criar um container do mysql usando o comando
```
docker run --name=user_mysql_1 --env="MYSQL_ROOT_PASSWORD=root_password" -p 3002:3306 -d mysql:latest
```

Pegar o numero do container usando o comando
```
docker ps
```

Mover os scripts para o container usando o comando (substituir numeroContainer pelo id que você pegou acima)
```
docker cp ./fisico.sql numeroContainer:'/'
docker cp ./popula.sql numeroContainer:'/'
```

Entrar no container usando o comando
```
docker exec -it user_mysql_1 bash
```

Popular o bd usando o comando
```
mysql -uroot -proot_password < fisico.sql
mysql anime_rec -uroot -proot_password < popula.sql
```

Criar usuário do bd usando os comandos
```
mysql -uroot -proot_password
CREATE USER 'newuser'@'%' IDENTIFIED BY 'newpassword';
GRANT ALL PRIVILEGES ON anime_rec.* to 'newuser'@'%';
```
## Script para data mining
Entrar na pasta data-mining e rodar o comando
```
pip install -r requirements.txt
```

Executar o arquivo app.py com o comando
```
python3 app.py
```

* Caso seja a primeira vez rodando o projeto popular a base de dados com a opção 1 do menu.
