# generator-django-rest [![npm](https://badge.fury.io/js/generator-django-rest.svg)](http://badge.fury.io/js/generator-django-rest) [![Build Status](https://travis-ci.org/metakermit/generator-django-rest.svg?branch=master)](https://travis-ci.org/metakermit/generator-django-rest) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/metakermit/generator-django-rest/master/LICENSE)

A [Yeoman](http://yeoman.io) generator for a Django REST API
(and optionally a React SPA)
that makes you efficient, includes features you need in a typical
modern web app, yet keeps things simple.

**Note: the project is still considered to be in beta until I get a chance
to test it on more apps. That said, I am using it in my own projects :)**

## Features

The philosophy is to include features useful across projects
that are tedious to set up from scratch.
Some of the cool features are:

- 🚀 quick to launch – start a new project and deploy it to [Heroku][]
in 3 commands:

        yo django-rest
        ./scripts/setup.sh
        ./scripts/deploy.sh

- ⚡️ productive – start the Django, DB & optionally frontend dev servers easily

        ./scripts/dev.sh

- 📜 sane logging – defaults to
  [fail nicely](https://github.com/metakermit/fail-nicely-django)
- 🦄 modern JS – serve static files on */* using [django-spa][] & Whitenoise for
  [nice single-page apps][spa-frontend-on-heroku] using React / Angular / Vue…
- ⛵️ monorepo - option to automatically set up a [create-react-app][]
  frontend for you in the same git repo with everything integrated under the mantra
  *one app, one repo, one dyno*
- 📦 Heroku-friendly packaging – if you're using the built-in React frontend,
  `deploy.sh` minifies the frontend and packages it up with Django
  into a separate prod branch ready for deployment as a Django web app
  (that gets deployed to Heroku by default)
- 🤓 [12-factor][] config – environment variable configuration

  * define a variable in *.env* for dev e.g. `REDIS_URL=redis://localhost:6379/0`
  * use it in *settings.py*, e.g. `CELERY_RESULT_BACKEND = env('REDIS_URL')`
  * set variables on the prod server (just works™ with Redis on [Heroku][])

- 🔋 batteries included

  * [Celery][] with a Redis backend – cause you'll need an async task queue
  * [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html)
    media file storage backend (optional)

- 🐶 familiar – check out the rough
  [project file layout](generators/app/templates/django/mysite),
  it's much like `django-admin startproject myproject` would set it up
  (only repeats the project name twice,
    i.e. *~/code/myproject/myproject/settigns.py*)

See [CHANGELOG.md](./CHANGELOG.md) for a full release history with all the
features.

## Getting Started

To begin, you need to install [node.js](https://nodejs.org).
Once you have that, you need Yeoman pre-installed. Yeoman lives in the
[npm](https://npmjs.org) package repository. You only have to ask for him
once, then he packs up and moves into your hard drive.

```bash
npm install -g yo
```

Then, we need the django-rest generator, i.e. plug-in. You install
generator-django-rest from
[npm](https://www.npmjs.com/package/generator-django-rest).

```bash
npm install -g generator-django-rest
```

Finally, for every new project you would initiate the generator
in an empty folder.

```bash
mkdir myproject
cd myproject
yo django-rest
```

Now check *HACKING.md* for extra instructions.

## License

MIT

[Heroku]: https://heroku.com/
[12-factor]: https://12factor.net/config
[spa-frontend-on-heroku]: https://metakermit.com/2016/simple-way-to-set-up-django-a-spa-frontend-on-heroku/
[Celery]: http://www.celeryproject.org/
[create-react-app]: https://github.com/facebookincubator/create-react-app
[django-spa]: https://github.com/metakermit/django-spa
