# Lumi Assessment

There are a few empty files and directories included in the project as it was part of the rails scaffolding when I ran the rails server command for the first time.

In this project, I chose to use Docker to containerize the application as I wanted to have an isolated environment for development.

## Table of Contents

- [Requirements](#requirements)
- [Setup](#setup)
- [Running the Project](#running-the-project)
- [Database Setup](#database-setup)
- [Running Migrations](#running-migrations)
- [Useful Docker Commands](#useful-docker-commands)

---

## Requirements

- **Docker**: Ensure Docker is installed on your machine. You can download it from [Docker's official website](https://www.docker.com/get-started).
- **Docker Compose**: This project uses Docker Compose to manage multi-container configurations. Docker Compose comes pre-installed with Docker Desktop on Windows and macOS.

## Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/ongkhooi/lumi-assessment.git
   ```

2. **Environment Variables**

   Since this project is purely for development and presentation purposes, I have hardcoded the default environment variables in the `docker-compose.yml` file for convenience.

3. **Build Docker Images**

   ```bash
   docker-compose build
   ```

   This will download and install all required dependencies.

## Database Setup

1. **Create the Database**

   If this is the first time setting up the project, create the database:

   ```bash
   docker-compose run web rails db:create
   ```

2. **Run Migrations**

   To run database migrations:

   ```bash
   docker-compose run web rails db:migrate
   ```

3. **Seed the Database**

   This will populate the publishers (SAYS, Utusan, Berita Harian) into the database:

   ```bash
   docker-compose run web rails db:seed
   ```

## Running the Project

1. **Start the Containers**

   Start the application and its services (web, database, redis, sidekiq) using Docker Compose:

   ```bash
   docker-compose up
   ```

   This command will start the application and output logs for each service in the terminal. You can access the Rails application at `http://localhost:3000`.

2. **Run in Detached Mode**

   To run the containers in the background, add the `-d` flag:

   ```bash
   docker-compose up -d
   ```

   You can stop the services later with:

   ```bash
   docker-compose down
   ```

3. **Endpoints**

   You can access the list of publishers at `http://localhost:3000/publishers` as well as fetch the article feed at the root index or `http://localhost:3000/news`. The article feed will show it being empty if you ran it for the first time. As specified in the requirements, the crawler is supposed to run every hour and I used a cron scheduler to do this, so the crawler will only scrape the articles at the next 0th hour after you set up the containers.

## Useful Docker Commands

- **View logs**:

  ```bash
  docker-compose logs -f
  ```

- **Open a Rails console**:

  ```bash
  docker-compose run web rails console
  ```

- **Open a bash shell in the web container**:

  ```bash
  docker-compose run web bash
  ```

- **Stop and remove all containers**:

  ```bash
  docker-compose down
  ```

- **Rebuild containers after making changes to the Dockerfile**:

  ```bash
  docker-compose build
  ```

---

Feel free to reach out if you encounter issues not covered in this README.