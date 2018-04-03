declare -a programs=("python3" "pipenv" "redis-server" "postgres")

## now loop through the above array
for program in "${programs[@]}"
do
   if ! hash $program 2>/dev/null; then
       echo "$program should be there. Run this script to install OS packages:"
       echo
       echo "./scripts/util/install.sh"
       echo
       exit 1
   fi
done
