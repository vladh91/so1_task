# Task3 Implementation
To be able to run ./start.sh its supposed that kubectl and minikube is already installed.
This has been implemented in Ubuntu 18.04 using kubectl and minikube installed locally.

start.sh script pulls java-example-app, build and package using mvn, creates docker image and creates java-app with mysql kubernetes deployment.
To start it just run ./start.sh


## Answers/descriptions for 5-8 points:
-  Can you do a HA of a database? Any way to keep the data persistent when pods are
  recreated?
 
 HA of a database can be done using master/slave logic and adding some scripts which can check health of master.If something went wrong script can provision slave node as a master and provide another node of database as a slave with replication.
 For persistent volumes we can use  kubernetes pvc. An example of pvc creation during deployment:
 ```
 apiVersion: v1
 kind: PersistentVolumeClaim
 metadata:
   name: mysql-pv-claim
   labels:
     app: java-app
 spec:
   accessModes:
     - ReadWriteOnce
   resources:
     requests:
       storage: 20Gi
 ```
 This part of yaml can be added to > kubeconfig/mysql-deployment.yaml which will create pvc with 20G storage and after recreation of pod data will be persistent
 
 -  Add CI to the deployment process.
 
 For this point I have created .gitlab-ci.yml assuming that repository with src files of java are located in Gitlab and its our CI/CD tool.
 You can find the file inside Task3 folder.
 
 - Split your deployment into prd/qa/dev environment.
 
 For this case we can use namespaces in Kubernetes.
 Example:
 > prod.yaml
 ```aidl
apiVersion: v1
kind: Namespace
metadata:
  name: prod
```
> kubectl create -f ./prod.yaml

The same can be done for dev/qa environments. And deployment of application can be done using this 3 different namespaces.

- Please suggest a monitoring solution for your system. How would you notify an admin
  that the resources are scarce?
 
  For me the best monitoring service for dockerized environments/kubernetes is Prometheus.
  Prometheus can natively monitor kubernetes, nodes and prometheus itself.
  It has very powerful api for custom metrics, also its provides robust query language and also built in dashboard.
  Also its ideally works with Grafana Dashboard 