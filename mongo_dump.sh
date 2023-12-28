#!/bin/bash

# Check if the required number of arguments is provided
if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <container> <port> <database> <username> <password> <authenticationDatabase>"
    exit 1
fi

# Assign command-line arguments to variables
CONTAINER="$1"
PORT="$2"
DATABASE="$3"
USERNAME="$4"
PASSWORD="$5"
AUTH_DB="$6"

# Define other variables
PROJECT_PATH=$(pwd)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M)
BACKUP_FOLDER_NAME=$(basename "$PROJECT_PATH")"-BACKUP-"$TIMESTAMP
BACKUP_DIR=$(pwd)/"$BACKUP_FOLDER_NAME"

mongo_dump() {
    echo "Dumping mongo database..."
    sudo mkdir -p "$BACKUP_DIR/mongo_dump"
    cd "$PROJECT_PATH" || exit 1
    docker exec -it "$CONTAINER" mongodump --uri "mongodb://$USERNAME:$PASSWORD@localhost:$PORT/$DATABASE?authSource=$AUTH_DB" --out "$BACKUP_DIR/mongo_dump/mongo-"$TIMESTAMP".mongo"
    echo "Dumping mongo database completed"
}

# Call the function
mongo_dump