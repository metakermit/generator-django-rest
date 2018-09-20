function lc(){
  echo $1 | awk '{print tolower($0)}'
}

DB_PORT=5433
PROJECT_NAME=<%= project_name %>
PROJECT_NAME_LOWERCASE=$(lc $PROJECT_NAME)
FRONTEND_NAME=<%= project_name %>-frontend
GIT_URL=<%= git_url %>
HEROKU_URL=<%= heroku_url %>
