#!/bin/bash
<% if (prod_branch) { %>
gulp
gulp commit
(cd prod; git push heroku prod:master)
<% } else { %>
git push heroku master
<% } %>
