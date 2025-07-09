#!/bin/bash

# run `chmod +x docker-control.sh` to make executable
# then `./docker-control.sh {build/start/stop/...}`
# ssh into container with: `docker exec -it cap4770_project_container /bin/bash`
# exit ssh with `exit`

IMAGE_NAME="cap4770_project_image"
CONTAINER_NAME="cap4770_project_container"

print_help() {
    echo ""
    echo "Usage: $0 {build|start|stop|logs|help}"
    echo ""
    echo "Commands:"
    echo "  build   Build the Docker image."
    echo "  start   Start the Docker container."
    echo "  stop    Stop and remove the Docker container."
    echo "  logs    Show logs from the Docker container."
    echo "  help    Show this help message."
    echo ""
}

case "$1" in
    build)
        echo "Stopping and removing container $CONTAINER_NAME (if exists)..."
        docker rm -f "$CONTAINER_NAME" > /dev/null 2>&1 || true

        echo "Removing image $IMAGE_NAME (if exists)..."
        docker rmi -f "$IMAGE_NAME" > /dev/null 2>&1 || true

        echo "Building Docker image..."
        docker build -t "$IMAGE_NAME" .
        echo "Build complete!"
        ;;
    start)
        echo "Starting Docker container..."

        # Remove any existing container with the same name
        docker rm -f $CONTAINER_NAME > /dev/null 2>&1

        # Run the container
        docker run -d \
            --name $CONTAINER_NAME \
            -v "$PWD":/app \
            -p 8501:8501 \
            -p 8888:8888 \
            $IMAGE_NAME

        echo "Container started!"
        echo "Streamlit: http://localhost:8501"
        echo "Jupyter:   http://localhost:8888"
        ;;
    stop)
        echo "Stopping Docker container..."
        docker stop $CONTAINER_NAME > /dev/null 2>&1
        docker rm $CONTAINER_NAME > /dev/null 2>&1
        echo "Container stopped and removed."
        ;;
    logs)
        echo "Displaying Logs..."
        docker logs $CONTAINER_NAME
        ;;
    help)
        print_help
        ;;
    *)
        echo "Unknown command: $1"
        print_help
        exit 1
        ;;
esac
