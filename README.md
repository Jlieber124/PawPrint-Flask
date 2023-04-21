ReadMe

Project: PawPrint Animal Shelter Application

Project Description:  PawPrint is an easy to use app for animal shelters. Created to fix the problem of miscommunication and loss of vital data within animal shelters. PawPrints fixes this problem by using a centralized database for all operations with easy access of data in real-time. We wish to help ensure the safety and well-being of the sheltered animals. 

Project Details: Uses App Smith user interface pages for the caretaker and operations volunteer. Python Flask is used to connect the user interface to the database. 

Video:  https://youtu.be/mVL78g5UU9s 


# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 
