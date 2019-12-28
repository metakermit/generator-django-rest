# Development

Setup your <%= project_name %> development environment:

```shell
./scripts/install.sh
```

And start developing

```shell
./scripts/start.sh
```

## Deployment to Heroku

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

## Upgrading the scaffolding

The scaffolding for this Django project was built using
[generator-django-rest][]. If you think of an improvement for your
Django project and that could benefit a wider range of projects
(e.g. auth, user management, caching improvements etc.), please consider
[contributing back][generator-django-rest].

To upgrade your project with the latest version of generator-django-rest
install `node` and get these npm package:

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


## Docker

To run `python manage.py` commands use `docker-compose run cli` instead:

```shell
docker-compose run cli migrate
docker-compose run cli createsuperuser
```

And to run the entire application with necessary services:

```shell
docker-compose up
```

If you want to run Django with runserver for better debug output,
update the *docker-compose.yml* file.


[generator-django-rest]: https://github.com/metakermit/generator-django-rest
