#!/bin/bash
<% if (prod_branch) { %>
./scripts/util/prod-package.sh
./scripts/util/prod-commit.sh
(cd prod; git push heroku prod:master)
<% } else { %>
git push heroku master
<% } %>
