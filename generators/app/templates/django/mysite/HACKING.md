# Development

Setup your development environment:

    ./scripts/devsetup.sh

And start developing

    ./scripts/dev.sh

Manual steps on the first run (TODO: automate):

    mkvirtualenv -p `python3` <%= project_name %>
    pip install -r requirements/dev.txt
    honcho -f Procfile.dev start # with commented out web command
    psql postgres -p 5433
    create user <%= project_name %> with password '<%= project_name %>';
    create database <%= project_name %> encoding 'utf8' template template0 owner <%= project_name %>;
    python manage.py migrate
    # uncomment the web command

## Upgrading the scaffolding

The scaffolding for this project was built using Django-REST and a lot of the
changes that benefit a wider range of projects (e.g. auth, user management,
caching improvements etc.) could perhaps be contributed there. To update this
project with the latest version of the Django-REST generator install node and
get the generator-django-rest dependencies:

    npm install -g yo generator-django-rest
    npm update -g yo generator-django-rest # maybe not necessary?

Then from within the root of your project (the path containing this file) run:

    yo django-rest <%= project_name %>

And resolve any conflicts using the interactive queries.
