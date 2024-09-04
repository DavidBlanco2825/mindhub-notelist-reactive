# Note List Application

**Author:** [David Fernando Blanco](https://github.com/DavidBlanco2825)

## Overview

This project is a microservices-based application that allows users to manage notes and tasks. It consists of the following microservices:

- **User Service**: Manages users (CRUD operations, user data management).
- **Task Service**: Manages tasks (CRUD operations, task lifecycle, etc.).
- **Eureka Server**: Provides service discovery for the microservices.
- **Gateway Service**: Routes requests to the appropriate microservices using Spring Cloud Gateway.

Each service is built using **Spring WebFlux** and **R2DBC** for reactive programming and non-blocking database operations with **PostgreSQL**.

## Features

- Full CRUD functionality for Users, and Tasks.
- Service discovery using Eureka.
- Gateway for routing API requests.
- Reactive programming using Spring WebFlux.
- Integration with PostgreSQL for persistent data storage.

## Requirements

To run this application, you need Docker installed on your system:

- Docker Engine 20.10.7 or higher
- Docker Compose 1.29.2 or higher

## Setup

### Prerequisites

1. **Docker Engine:**
   - Download and install Docker Engine from the [Docker website](https://docs.docker.com/engine/install/).

2. **Docker Compose:**
   - Download and install Docker Compose from the [Docker website](https://docs.docker.com/compose/install/).

### Clone the Repository

```sh
git clone https://github.com/DavidBlanco2825/mindhub-notelist-reactive.git
cd mindhub-notelist-reactive
```

### Project Structure

```sh
mindhub-notelist-reactive/
│
├── user-service         # Manages users
├── task-service         # Manages tasks
├── gateway-service      # API Gateway routing requests to services
└── eureka-server        # Service registry for service discovery
```

### Running the Application

To run the entire application with Docker, follow these steps:

1. **Build and run the application** using Docker Compose:

```sh
   docker compose -f docker-compose.yml up --build -d
```

1. **Access the microservices**:
    - **User Service**: `http://localhost:8081/api/users`
    - **Task Service**: `http://localhost:8082/api/tasks`
    - **Gateway Service**: `http://localhost:8080/` (Gateway routes all API requests)

2. **Swagger API Documentation**:
    - **User Service Swagger UI**: `http://localhost:8081/webjars/swagger-ui/index.html`
    - **Task Service Swagger UI**: `http://localhost:8082/webjars/swagger-ui/index.html`

3. **Eureka Server**: The Eureka server can be accessed at:
    - `http://localhost:8761` to view registered services.

### Stopping the Application

To stop the running containers, use the following command:

```sh
docker-compose down
```

### Release all resources

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
