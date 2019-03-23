#!/usr/bin/env bash

# Script file which will do build of application Docker image and build application to kubernetes/minikube

# Clone application resources
echo "<--- Cloning application sources: --->"
git clone https://github.com/TechPrimers/docker-mysql-spring-boot-example.git

# Build application with mvn
#APP_DIR = "docker-mysql-spring-boot-example"
echo "<--- Pulling docker image for mvn build --->"
docker pull maven:3.3.9
echo "<--- Running applicaton build and package inside image --->"

cd docker-mysql-spring-boot-example

docker run --rm -v $(pwd):/workspace maven:3.3.9 /bin/bash -c  'cd  /workspace && mvn -B clean && mvn -B compile && mvn -B package'

# Using minikube as docker registry
# In this script I am not pushing builded docker image to public registry.Instead I am using minikube server as docker registry
# This is needed to be able to get the image from kubeconfig/java-app-deployment.yaml

eval $(minikube docker-env)
# Since we are building to kubernetes we will build application only locally and use it in kube config
echo "<--- Building docker image for application --->"
docker build -t java-example-app .

echo "<--- Build finished--->"

# Clean up app directory
cd ../
rm -rf docker-mysql-spring-boot-example/
echo "Clean up finished"

echo "<--- Create mysql root secret password --->"
kubectl create secret generic mysql-root-pass --from-literal=password=Aa1234567!
echo "<--- Create mysql sa user password --->"
kubectl create secret generic mysql-user-pass --from-literal=password=password

echo "<--- Create mysql pod --->"

kubectl create -f kubeconfig/mysql-deployment.yaml
echo "Waiting 30 seconds for mysql pod get running..."
sleep 30

echo "<--- Starting java application --->"
kubectl create -f kubeconfig/java-app-deployment.yaml

sleep 30
kubectl get pods