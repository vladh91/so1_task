#Task3 Implementation
To be able to run ./start.sh its supposed that kubectl and minikube is already installed.
This has been implemented in Ubuntu 18.04 using kubectl and minikube installed locally.

start.sh script pulls java-example-app, build and package using mvn, creates docker image and creates java-app with mysql kubernetes deployment.
To start it just run ./start.sh