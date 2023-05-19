# rapid-ticket

Aplicación para la reserva de tickets de distintos eventos de latinoamérica.

## ¿Cómo probar aplicación localmente?

Para montar el modo development de la aplicación y poder usarla localmente para hacer pruebas es necesario contar con **docker** y **docker-compose** en nuestro sistema. Una vez que contamos con estas dependencias, podemos realizar lo siguiente:

- Descargamos el código del proyecto.

- Nos movemos a la carpeta del proyecto y allí ejecutamos:

  - `docker-compose build`
  - `docker-compose run --rm app bundle install`
  - `docker-compose run --rm app bundle exec rake db:create`
  - `docker-compose run --rm app bundle exec rake db:migrate`
  - `docker-compose run --rm app bundle exec rake db:seed`
- Una vez realizado lo anterior, podemos hacer un start de nuestra aplicación en un contenedor docker con el siguiente comando: `docker-compose up -d`.
- El dominio del sitio para probar localmente será: **http://localhost:3000/**
