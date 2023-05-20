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

## Postam collection para probar

- [Link al archivo](https://github.com/AgustinYurescia/rapid-ticket/blob/master/Rapid%20Ticket.postman_collection.json)

## Modelo de datos

![imagen](https://github.com/AgustinYurescia/rapid-ticket/assets/48600998/953c9199-1924-4350-8cfe-35287b99211b)
