# Run Pet Management API in docker 

This project is a simple RESTful API for managing pets running inside a docker container. It allows users to create, read, update, and delete pet records.

It is to demonstrate usage of docker in SDLC , pets data is not persisted and only stored in container application memory. 

## Table of Contents

- [Pre-requisites](#prereqs)
- [Setup](#setup)
   - Clone repo
   - Build docker image 
   - Start application docker container
   - Stop application docker container
- [API Endpoints](#api-endpoints)
- [Usage](#usage)
- [Testing](#testing)

## Pre-requisites

Before you begin, ensure you have the following installed on your system:

- Docker: The application can be run in a Docker container. 
   Install Docker from [Docker desktop](https://www.docker.com/products/docker-desktop/) or [ Rancher desktop ](https://docs.rancherdesktop.io/getting-started/installation)
- Node.js: Version 18 or later. You can download it from [https://nodejs.org/](https://nodejs.org/)
- npm: This comes installed with Node.js

The application uses the following main dependencies:
- Express: Web application framework
- TypeScript: Typed superset of JavaScript
- UUID: For generating unique identifiers

These dependencies will be installed automatically when you follow the setup instructions.


## Setup

1. Clone the repository:

```bash
    git clone https://github.com/nsvijay04b1/docker-pets-api.git
    cd docker-pets-api
```


2. Build docker image:

multi-stage builds provide a cleaner, more efficient way to create Docker images. They reduce image size, enhance security, improve build performance, and contribute to better maintainability. By leveraging these advantages, developers can create streamlined, efficient applications that are easier to deploy and manage.

```
# Multi stage build - *** Recommended ***

docker build -t pets-api-docker-multistage -f ./Dockerfile_multi_stage_sample .


# Single stage build

docker build -t pets-api-docker-singlestage -f ./Dockerfile_single_stage_sample .

```
Multi stage built images are slim 

[image-size-multi-VS-singleStage-docker-build](./images/multi_stage_docker_builds_image_size_difference.jpg)

3. Start application docker container:

```bash
    docker run --rm -p 3000:3000 --name pets-api -d pets-api-docker-multistage
```

or

```bash
    ./startApp.sh
```

3. Stop application docker container:

```bash
    docker stop pets-api
```

or

```bash
    ./stopApp.sh
```


The server will start running on `http://localhost:3000`.

## API Endpoints

- `GET /pets`: Retrieve all pets
- `GET /pets/:id`: Retrieve a specific pet by ID
- `POST /pets`: Create a new pet
- `PUT /pets/:id`: Update an existing pet
- `DELETE /pets/:id`: Delete a pet

## Usage

### Get all pets

```bash
curl http://localhost:3000/pets
```

### Get a specific pet by id

```bash
curl http://localhost:3000/pets/<pet-id>
```

### Create a new pet

```bash
curl -X POST -H "Content-Type: application/json" \
     -d '{"name": "Bella", "age": 2, "type": "dog"}' \
     http://localhost:3000/pets
```

### Update a pet

```bash
curl -X PUT -H "Content-Type: application/json" \
     -d '{"name": "Bella", "age": 3, "type": "dog"}' \
     http://localhost:3000/pets/<pet-id>
```

### Delete a pet

```bash
curl -X DELETE http://localhost:3000/pets/<pet-id>
```

