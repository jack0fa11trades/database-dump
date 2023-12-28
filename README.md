This is the bash script to backup database of mongo and postgre. This script takes arguments in command line while running the script.

Run the command like this:

First make it executable by running:

chmod +x <filename.sh>

And,

./postgres_dump.sh <postgres_container_name> <host> <port> <db_username> <db_name>

./mongo_dump.sh <mongo_container> <port> <db_name> <db_username> <password> <authenticationDatabase>

Replace the arguments as per your DB details.
