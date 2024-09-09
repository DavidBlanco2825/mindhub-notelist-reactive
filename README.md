# Note List Application

**Author:** [David Fernando Blanco](https://github.com/DavidBlanco2825)

## Overview

This project is a microservices-based application that allows users to manage notes and tasks. It consists of the following microservices:

- **User Service**: Manages users (CRUD operations, user data management).
- **Task Service**: Manages tasks (CRUD operations, task lifecycle, etc.).
- **Eureka Server**: Provides service discovery for the microservices.
- **Gateway Service**: Routes requests to the appropriate microservices using Spring Cloud Gateway. All API requests should go through the Gateway Service at `http://localhost:8080`.

Each service is built using **Spring WebFlux** and **R2DBC** for reactive programming and non-blocking database operations with **PostgreSQL**.

## Features

- Full CRUD functionality for Users and Tasks.
- Service discovery using Eureka.
- Gateway for routing API requests.
- Reactive programming using Spring WebFlux.
- Integration with PostgreSQL for persistent data storage.
- **JWT Authentication** for securing endpoints.

## Requirements

To run this application, you need Docker installed on your system:

- Docker Engine 20.10.7 or higher
- Docker Compose 1.29.2 or higher
- **Java 17**: The application is built using Java 17, so ensure it's installed.
- **Maven 3.6** or higher: The microservices use Maven for building and dependency management.

## Setup

### Prerequisites

1. **Docker Engine**:
   - Download and install Docker Engine from the [Docker website](https://docs.docker.com/engine/install/).

2. **Docker Compose**:
   - Download and install Docker Compose from the [Docker website](https://docs.docker.com/compose/install/).

3. **Git Bash**: If you're using a Windows machine, we recommend using **Git Bash** to run the commands in this section. Git Bash provides a Unix-style terminal on Windows and can be installed from the official [Git for Windows](https://gitforwindows.org/) site.

### Clone the Repository

```sh
git clone https://github.com/DavidBlanco2825/mindhub-notelist-reactive.git
cd mindhub-notelist-reactive
```

### .env File

The `.env` file contains environment variables used to configure the services. Variables such as database credentials, JWT secret keys, and token expiration times should be defined here. Make sure to fill in this file before running the application.

Example `.env` file contents:

```sh
EXP_TIME=60000
SECRET_KEY=your_secret_key
```

For security reasons, ensure this file is not included in version control.

### Project Structure

The current structure of the project looks like this:

```sh
mindhub-notelist-reactive/
│
├── .env                                # Environment variables for the application
├── clone_and_run.sh                    # Script to clone the repositories and start the application
├── docker-compose.yml                  # Docker Compose file to orchestrate the services
├── NoteListApp.postman_collection.json # Postman collection for testing the API
├── README.md                           # Project documentation
├── task-service                        # (To be created) Manages tasks
├── user-service                        # (To be created) Manages users
├── gateway-service                     # (To be created) API Gateway routing requests to services
└── eureka-server                       # (To be created) Service registry for service discovery
```

#### Important Note

The directories for `task-service`, `user-service`, `gateway-service`, and `eureka-server` are not present initially. These directories will be created when you run the `clone_and_run.sh` script.

### Running the Application

The project includes a script, `clone_and_run.sh`, which automates the following tasks:

- Cloning the repositories for the **User Service**, **Task Service**, **Gateway Service**, and **Eureka Server** from their respective GitHub repositories.
- Pulling the latest changes from those repositories if they already exist.
- Running `docker-compose` to build and start all the microservices and required PostgreSQL instances.

Here’s how to use it:

1. **Run the script** using Git Bash (or any Bash shell):

    ```sh
    ./clone_and_run.sh
    ```

   If you’re on Windows and using **Git Bash**, ensure you are in the project root directory where the `clone_and_run.sh` file is located, then execute the command.

   The script will:
   - Clone all the necessary repositories into their respective directories.
   - Build Docker images for the services.
   - Start the services using Docker Compose.

1. **Access the microservices**:
   - **User Service**: `http://localhost:8080/api/users` (via Gateway)
   - **Task Service**: `http://localhost:8080/api/tasks` (via Gateway)

2. **Swagger API Documentation**:
    - **User Service Swagger UI**: `http://localhost:8081/webjars/swagger-ui/index.html`
    - **Task Service Swagger UI**: `http://localhost:8082/webjars/swagger-ui/index.html`

3. **Eureka Server**: The Eureka server can be accessed at:
    - `http://localhost:8761` to view registered services.

#### Understanding the `clone_and_run.sh` Script

The `clone_and_run.sh` script is designed to simplify the process of setting up the project. Here’s what it does:

- **Cloning Repositories**: It clones the latest version of each microservice from its respective GitHub repository (User Service, Task Service, Gateway Service, and Eureka Server).
- **Pulling Updates**: If the repositories already exist locally, the script pulls the latest changes instead of re-cloning them.
- **Running Docker Compose**: Once all repositories are cloned or updated, the script runs `docker-compose` to build and start the Docker containers for the application.

#### Understanding the `docker-compose.yml` File

The `docker-compose.yml` file orchestrates the various microservices and their dependencies. Here’s what it defines:

- **PostgreSQL Instances**: Two separate PostgreSQL instances are set up—one for the **User Service** and another for the **Task Service**.
- **Microservices**: The `user-service`, `task-service`, `gateway-service`, and `eureka-server` services are built and run in separate containers.
- **Service Discovery**: The **Eureka Server** is included for service discovery, allowing microservices to register themselves and discover each other.
- **Environment Variables**: Each service has its own environment variables, including database connection details and security configurations (e.g., token expiration time and secret key).

By using Docker Compose, all the services are built and started together, ensuring a consistent environment.

### Postman Collection for Testing

To make it easier to test the API endpoints of the application, we've provided a Postman collection in the root directory of this project. The collection contains pre-configured requests for all available endpoints of the **User Service**, **Task Service**, **Gateway Service**, and more.

#### How to Use the Postman Collection

1. **Download Postman**:
   - If you haven't already, download and install [Postman](https://www.postman.com/downloads/).

2. **Import the Postman Collection**:
   - Open Postman.
   - Click on the "Import" button in the upper-left corner of Postman.
   - Select the `NoteListApp.postman_collection.json` file located in the root directory of this project.
   - Click "Open" to import the collection.

3. **Run the Requests**:
   - Once the collection is imported, you can start testing the endpoints.
   - Each service's endpoints are already defined in the collection for **User Service**, and **Task Service**.
   - Simply select a request from the collection, ensure that the application is running (via Docker Compose), and hit "Send" to see the response.

4. **Endpoints Included in the Postman Collection**:
    - **Auth Service**: `http://localhost:8080/api/auth`
    - **User Service**: `http://localhost:8080/api/users`
    - **Task Service**: `http://localhost:8080/api/tasks`

    Each of these endpoints includes examples for:
    - **GET**: Fetching data.
    - **POST**: Creating new records.
    - **PUT**: Updating existing records.
    - **DELETE**: Deleting records.

### Stopping the Application

To stop the running containers, use the following command:

```sh
docker-compose down
```

### Removing All Resources

To stop the containers and remove all associated resources (containers, networks, volumes, and images created by `up`), use the following command:

```sh
docker-compose down --volumes --rmi all
```

### Application Ports

The services are exposed on the following ports:

- **User Service**: `8081`
- **Task Service**: `8082`
- **Gateway Service**: `8080`
- **Eureka Server**: `8761`

## Additional Information

Each microservice uses **PostgreSQL** as its database. Two PostgreSQL instances are set up in Docker for `user-service` and `task-service`. The environment variables for database credentials are managed in the `docker-compose.yml` file.

If you encounter any issues or need further assistance, feel free to raise an issue or reach out via the [GitHub repository](https://github.com/DavidBlanco2825/mindhub-notelist-reactive.git).
