# generator-django-rest [![Build Status](https://secure.travis-ci.org/metakermit/generator-django-rest.png?branch=master)](https://travis-ci.org/metakermit/generator-django-rest)

[Yeoman](http://yeoman.io) generator for a Django REST API
that keeps things simple, yet includes includes features you need in a typical
web app.

Features:

- 12-factor 🤓
- quick to launch 🚀 Start a new project and deploy it to Heroku in 3 commands:

    yo django-rest
    ./scripts/devsetup.sh
    ./scripts/deploy.sh

- productive ⚡️ Start a development server easily using `./scripts/dev.sh`

## Getting Started

To begin, your computer first needs [node.js](https://nodejs.org).
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


## License

MIT
