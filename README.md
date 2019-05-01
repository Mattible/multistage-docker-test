# Multistage Docker - GoLang
A simple http app built in GoLang then wrapped up in a multi-stage docker file for reduced attack surface and smaller foot print.

# Overview

    1.  Getting Started
    2.  Docker
      2.1 Requirements
      2.2 Running Docker
    3.  Improvements
  
# 1. Getting Started

The following are instructions to run a small golang application in a cached multistage docker.

# 2. Docker

### 2.1 Requirements

  - Docker 17.05+
  
### 2.2 Running Docker

Build the docker image:

`Make build`

Run the docker image:

`Make run`


The docker image is tagged as `anz-webapp:latest` and will have the following endpoints:
  - http://localhost:8000/
  - http://localhost:8000/go
  - http://localhost:8000/opt
  
# 3. Improvements

The following are a list of changes/improvements made over the original in order to optimize the docker image:

  - Updated http server address in main.go to allow for use inside/outside of docker containers:
    - `Addr:         "127.0.01:8000",`   --->   `Addr:         ":8000",`
  - Changed the Dockerfile into 3 stages:
    - `goLang_Download` - Responsible for downloading and caching the GoLang Dependancies.
    - `packager` - Responsible for compiling then packaging the GoLang application.
    - Stage 3 - For running our application as the resulting image
  
  
  
  
