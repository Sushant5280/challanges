---
Title: microservice deploying on containerization platform
Author: Sushant Patil
Date: 29-09-2021

### Overview ###

- Written java spring-boot code to create the sample microservice application which is given output in json format.
- For Packaging this application used two different ways, Common dockerfile and multistage dockerfile
- The `Dockerfile` file contains the definitions for the coping the jar file and run on containerization platform.
- The `Dockerfile-multistage` file first build the jar using mavan build tools then oopy the jar file in next stage.
- The `microservice.yml` file contains the pod definitions and configurations to the run the docker container.
- The `service.yml` route the traffic from pod to outside.

The following steps describe each of these steps in detail:

### Pre-requisites ###
* docker: Install docker on windows using https://docs.docker.com/desktop/windows/install/
* docker: Install docker on linux using https://docs.docker.com/engine/install/centos/ 
* minikube: Install minikube for run docker container on k8s platform as per the installation instructions https://kubernetes.io/docs/setup/minikube/#installation

### Step 1: Create java spring-boot microservice as per the given challenge 

I have used Spring Boot to create stand-alone Java applications that can be started using java -jar and Create the build using mavan build tool.
The following command used to build the application jar file >> mvn -f pom.xml clean package

### Step 2: Build the Docker image

1. Once jar get build using Dockerfile we can build the docker image with below command
   docker build -t your-docker-account/reponame:tag .
   Push  docker image to the docker hub
   docker login  username then give the password
   docker push your-docker-account/reponame:tag

2. If you want build the jar using dockerfile then use Dockerfile-multistage file.
   docker build -f Dockerfile-multistage -t your-docker-account/reponame:tag .
   
### Step 3: Run the docker image 
  We can directly run the docker images for the application using below command, i have already push image in my public repository.
  docker pull docker pull psushant/demo:1.0 # Common docker image
  docker pull psushant/demo:multistage-1.0  # multistage docker image
  docker run -it -p 80:8080 psushant/demo:1.0
  Type the localhost in browser.
  
### Step 4: Deploy the docker image on k8s 
  Just the the below command to deploy manifest file on minikube.
  kubectl apply -f microservice.yml
  kubectl apply -f service.yml
  

   









