# Development

Setup your <%= project_name %> development environment:

```shell
./scripts/install.sh
```

And start developing

```shell
./scripts/start.sh
```


## Docker

You can run the entire web app with all the necessary services inside Docker:

```shell
docker-compose up
```

To run `python manage.py` commands use `docker-compose run cli` instead:

```shell
docker-compose run cli migrate
docker-compose run cli createsuperuser
```

If you want to run Django with runserver for better debug output,
update the *docker-compose.yml* file.


## Frontend details
<% if (prod_branch) { %>
Since the tooling manages a React SPA as well,
the compilation is a bit more complex, so we will explain the internals a bit.
When you call *./deploy.sh* everything gets compiled into a *prod/* folder,
commited into a prod branch and pushed to Heroku.

An example of the *prod/* folder layout would look something like this:

```
prod
├── Dockerfile
├── HACKING.md
├── Procfile
├── Procfile.dev.example
├── README.md
├── docker-compose.yml
├── manage.py
├── myproject
│   ├── __init__.py
│   ├── celery.py
│   ├── logger.py
│   ├── middleware.py
│   ├── settings.py
│   ├── static
│   │   ├── asset-manifest.json
│   │   ├── favicon.ico
│   │   ├── index.html
│   │   ├── manifest.json
│   │   ├── service-worker.js
│   │   └── static
│   │       ├── css
│   │       │   ├── main.cacbacc7.css
│   │       │   └── main.cacbacc7.css.map
│   │       ├── js
│   │       │   ├── main.120eaed3.js
│   │       │   └── main.120eaed3.js.map
│   │       └── media
│   │           └── logo.5d5d9eef.svg
│   ├── urls.py
│   └── wsgi.py
├── requirements
│   ├── base.txt
│   ├── custom.txt
│   ├── dev.txt
│   ├── prod.txt
│   └── test.txt
├── requirements.txt
└── runtime.txt
```

Note that create-react-app includes a service worker that caches everything
into local storage which is good for performance reasons, but messes up routing
for server-side routes like /admin. If you still wish to use these, disable
the service worker by commenting out the line `registerServiceWorker();`
in *index.js*.
<% } %>


# Deployment

You can deploy your Django web app to different PaaS providers
in just a few commands.

## Heroku

You can quickly deploy <%= project_name %> to Heroku:

```shell
heroku login
heroku create <%= project_name %>
heroku git:remote -a <%= project_name %>
heroku addons:create heroku-postgresql:hobby-dev # for the DB
heroku addons:create heroku-redis:hobby-dev # for Celery
./scripts/deploy.sh
heroku run python manage.py migrate
```

Once this initial setup is working, you normally deploy by issuing:

```shell
./scripts/deploy.sh
```

And you're running on Heroku! 🚀

## Dokku

Dokku is an alternative to Heroku that you can self-host. We assume that your
Dokku server uses the hostname (and email) *dokku.me* in the commands bellow –
replace with your actual information.

SSH into your Dokku host and create the app:

```shell
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku plugin:install https://github.com/dokku/dokku-postgres.git
dokku plugin:install https://github.com/dokku/dokku-redis.git
dokku apps:create <%= project_name %>
dokku postgres:create <%= project_name %>db
dokku postgres:link <%= project_name %>db <%= project_name %>
dokku redis:create <%= project_name %>redis
dokku redis:link <%= project_name %>redis <%= project_name %>
dokku config:set --no-restart <%= project_name %> DOKKU_LETSENCRYPT_EMAIL=youremail@dokku.me
```

Inside your project do:

```shell
git remote add dokku dokku@dokku.me:<%= project_name %>
git push dokku master
```

Now a few more commands on the server:

```shell
dokku letsencrypt <%= project_name %>
dokku run <%= project_name %> python manage.py migrate
```

That's it! Your app should be live on https://<%= project_name %>.dokku.me 🚀


# Upgrading the scaffolding

The scaffolding for this Django project was built using
[generator-django-rest][]. To upgrade your project with the latest version
of generator-django-rest install `node` and get these npm package:

```shell
npm install -g yo generator-django-rest
npm update -g yo generator-django-rest # maybe not necessary?
```

If you use `yarn` instead do:

```shell
yarn global add yo generator-django-rest
yarn global upgrade yo generator-django-rest
```

Then from within the root of your project (the path containing this file) run:

```shell
yo django-rest <%= project_name %>
```

And resolve any conflicts using the interactive queries.


[generator-django-rest]: https://github.com/metakermit/generator-django-rest
