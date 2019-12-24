# generator-django-rest [![npm](https://badge.fury.io/js/generator-django-rest.svg)](http://badge.fury.io/js/generator-django-rest) [![Build Status](https://travis-ci.org/metakermit/generator-django-rest.svg?branch=master)](https://travis-ci.org/metakermit/generator-django-rest) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/metakermit/generator-django-rest/master/LICENSE) [![Updates](https://pyup.io/repos/github/metakermit/generator-django-rest/shield.svg)](https://pyup.io/repos/github/metakermit/generator-django-rest/)

A [Yeoman](http://yeoman.io) generator for a Django REST API
(and optionally a React SPA)
that makes you efficient, includes features you need in a typical
modern web app, yet keeps things simple. You can see an example app bootstrapped
in this manner [here][hellodjango].

**Note: the project is still considered to be in beta until I get a chance
to test it on more apps. That said, I am using it in my own projects :)**

## Features

The philosophy is to include features useful across projects
that are tedious to set up from scratch.
Some of the cool features are:

* 🚀 quick to launch – start a new project and deploy it to [Heroku][]
  in 3 commands:
  
  ```shell
  yo django-rest
  ./scripts/setup.sh
  ./scripts/deploy.sh
  ```

* ⚡️ productive – start the Django, DB & optionally frontend dev servers easily

  ```shell
  ./scripts/dev.sh
  ```

* 🐳 Docker support – get a complete environment with Django, Postgres & Redis in a single command:

  ```shell
  docker-compose up
  ```

* 🦄 modern JS – serve static files on _/_ using [django-spa][] for
  [nice single-page apps][spa-frontend-on-heroku] using React / Angular / Vue…
* ⚛️ GraphQL – interactive API with filtering and nested queries using [Graphene](https://docs.graphene-python.org/en/latest/)
* ⛵️ monorepo - option to automatically set up a [create-react-app][]
  frontend for you in the same git repo with everything integrated under the mantra
  _one app, one repo, one dyno_
* 📦 Heroku-friendly packaging – if you're using the built-in React frontend,
  `deploy.sh` minifies the frontend and packages it up with Django
  into a separate prod branch ready for deployment as a Django web app
  (that gets deployed to [Heroku][] by default)
* 🤓 [12-factor][] config – environment variable configuration using [django-environ](https://github.com/joke2k/django-environ)

  * define a variable in _.env_ for dev e.g. `REDIS_URL=redis://localhost:6379/0`
  * use it in _settings.py_, e.g. `CELERY_RESULT_BACKEND = env('REDIS_URL')`
  * set variables on the prod server (just works™ with Redis on [Heroku][])

* 🔋 batteries included

  * [Celery][] with a Redis backend – cause you'll need an async task queue
  * [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html)
    media file storage backend (optional)
  * [snapshottest](https://github.com/syrusakbary/snapshottest) quickly write tests
    by taking API snapshots.

* 📜 sane logging – defaults to
  [fail nicely](https://github.com/metakermit/fail-nicely-django)
* 🐶 familiar – check out the rough
  [project file layout](generators/app/templates/django/mysite),
  it's much like `django-admin startproject myproject` would set it up
  (only repeats the project name twice,
  i.e. _~/code/myproject/myproject/settigns.py_). An example generated app is
  available [here][hellodjango].

See [CHANGELOG.md](./CHANGELOG.md) for a full release history with all the
features.

## Getting Started

To begin, you need to install [node.js](https://nodejs.org).
Once you have that, you need Yeoman pre-installed. Yeoman lives in the
[npm](https://npmjs.org) package repository. You only have to ask for him
once, then he packs up and moves into your hard drive.

```shell
npm install -g yo
```

Then, we need the django-rest generator, i.e. plug-in. You install
generator-django-rest from
[npm](https://www.npmjs.com/package/generator-django-rest).

```shell
npm install -g generator-django-rest
```

Finally, for every new project you would initiate the generator
in an empty folder.

```shell
mkdir myproject
cd myproject
yo django-rest
```

Now check the _HACKING.md_ file in the generated code project for
extra instructions (generated from [this template](https://github.com/metakermit/generator-django-rest/blob/master/generators/app/templates/django/mysite/HACKING.md) if you're curious).

## Contributing

As a reminder to myself, I release a new version of generator-django-rest by running:

```shell
npm run release:patch # or :minor or :major
npm publish
```

## License

[MIT](LICENSE)

[heroku]: https://heroku.com/
[12-factor]: https://12factor.net/config
[spa-frontend-on-heroku]: https://metakermit.com/2016/simple-way-to-set-up-django-a-spa-frontend-on-heroku/
[celery]: http://www.celeryproject.org/
[create-react-app]: https://github.com/facebookincubator/create-react-app
[django-spa]: https://github.com/metakermit/django-spa
[hellodjango]: https://github.com/metakermit/hellodjango
