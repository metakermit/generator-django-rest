# Development

Setup your <%= project_name %> development environment:

    ./scripts/devsetup.sh

And start developing

    ./scripts/dev.sh

## Deployment to Heroku

You can quickly deploy <%= project_name %> to Heroku:

    git init
    git add -A
    git commit -m "initial commit"
    heroku login
    heroku create <%= project_name %>
    heroku addons:create heroku-redis:hobby-dev # for Celery
    ./scripts/deploy.sh
    heroku run python manage.py migrate

*Note: there seems to be an error with Heroku, check
[this solution](http://stackoverflow.com/a/38954680/544059).*

Once this initial setup is working, you normally deploy by issuing:

    ./scripts/deploy.sh

## Upgrading the scaffolding

The scaffolding for this Django project was built using
[generator-django-rest][]. If you think of an improvement for your
Django project and that could benefit a wider range of projects
(e.g. auth, user management, caching improvements etc.), please consider
[contributing back][generator-django-rest].

To upgrade your project with the latest version of generator-django-rest
install `node` and get these npm package:

    npm install -g yo generator-django-rest
    npm update -g yo generator-django-rest # maybe not necessary?

If you use `yarn` instead do:

    yarn global add yo generator-django-rest
    yarn global upgrade yo generator-django-rest

Then from within the root of your project (the path containing this file) run:

    yo django-rest <%= project_name %>

And resolve any conflicts using the interactive queries.

[generator-django-rest]: https://github.com/metakermit/generator-django-rest
