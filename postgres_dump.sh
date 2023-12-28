# Check if the required number of arguments is provided
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <container> <host> <port> <username> <database>"
    exit 1
fi

# Assign command-line arguments to variables
CONTAINER="$1"
HOST="$2"
PORT="$3"
USERNAME="$4"
DATABASE="$5"

# Define other variables
PROJECT_PATH=$(pwd)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M)
BACKUP_FOLDER_NAME=$(basename "$PROJECT_PATH")"-BACKUP-"$TIMESTAMP
BACKUP_DIR=$(pwd)/"$BACKUP_FOLDER_NAME"

postgres_dump() {
    echo "Dumping PostgreSQL database..."
    sudo mkdir -p "$BACKUP_DIR/postgres_dump"
    cd "$PROJECT_PATH" || exit 1
    docker exec "$CONTAINER" pg_dump -h "$HOST" -p "$PORT" -U "$USERNAME" -d "$DATABASE" > "$BACKUP_DIR/postgres_dump/postgres-"$TIMESTAMP".sql"
    echo "Dumping PostgreSQL database completed"
}

# Call the function
postgres_dump


