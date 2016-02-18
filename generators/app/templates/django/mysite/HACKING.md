# Development

TODO

## Upgrading the scaffolding

The scaffolding for this project was built using Django-REST and a lot of the
changes that benefit a wider range of projects (e.g. auth, user management,
caching improvements etc.) could perhaps be contributed there. To update this
project with the latest version of the Django-REST generator install node and
get the generator-django-rest dependencies:

    npm install -g yo generator-django-rest
    npm update -g yo generator-django-rest # maybe not necessary?

Then from within the root of your project (the path containing this file) run:

    yo django-rest posterbat

And resolve any conflicts using the interactive queries.
