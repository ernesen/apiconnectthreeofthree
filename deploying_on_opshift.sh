#!/bin/sh

ENV=development
STRATEGY=docker
MONGODB_PASSWORD=password
MONGODB=mongodb
DATABASE=mongodb://admin:$MONGODB_PASSWORD@$MONGODB:27017
URL=https://github.com/ernesen/apiconnectthreeofthree.git
LABEL="microservice=apisvc"
OPENSHIFT_SERVER=localhost


oc new-project banking-api --description="API Lifecycle and Governance in the Enterprise" --display-name="Banking API"

# Create a MongoDB database
oc delete all -l app=mongodb
oc new-app --name mongodb --env MONGODB_USER=mongouser --env MONGODB_PASSWORD=$MONGODB_PASSWORD --env MONGODB_DATABASE=$MONGODB --env MONGODB_ADMIN_PASSWORD=password registry.access.redhat.com/rhscl/mongodb-36-rhel7 -l $LABEL

### Create accounts
oc delete all -l app=accounts
oc new-app --name accounts  --strategy=$STRATEGY $URL --context-dir=/accounts --env BASE_PATH=$OPENSHIFT_SERVER --env NODE_ENV=$ENV --env MONGO_URL=$DATABASE -l $LABEL

### Create authentication
oc delete all -l app=authentication
oc new-app --name authentication --strategy=$STRATEGY $URL --context-dir=/authentication --env BASE_PATH=$OPENSHIFT_SERVER --env NODE_ENV=$ENV --env MONGO_URL=$DATABASE -l $LABEL

### Create bills
oc delete all -l app=bills
oc new-app --name bills --strategy=$STRATEGY $URL --context-dir=/bills --env BASE_PATH=$OPENSHIFT_SERVER --env NODE_ENV=$ENV --env MONGO_URL=$DATABASE -l $LABEL

### Create support
oc delete all -l app=support
oc new-app --name support --strategy=$STRATEGY $URL --context-dir=/support --env BASE_PATH=$OPENSHIFT_SERVER --env NODE_ENV=$ENV --env MONGO_URL=$DATABASE -l $LABEL

### Create transactions
oc delete all -l app=transactions
oc new-app --name transactions --strategy=$STRATEGY $URL --context-dir=/transactions --env BASE_PATH=$OPENSHIFT_SERVER --env NODE_ENV=$ENV --env MONGO_URL=$DATABASE -l $LABEL

### Create userbase
oc delete all -l app=userbase
oc new-app --name userbase --strategy=$STRATEGY $URL --context-dir=/userbase --env BASE_PATH=$OPENSHIFT_SERVER --env NODE_ENV=$ENV --env MONGO_URL=$DATABASE -l $LABEL

### Create portal
oc delete all -l app=portal
oc new-app --name portal --strategy=$STRATEGY $URL --context-dir=/portal --env BASE_PATH=$OPENSHIFT_SERVER --env NODE_ENV=$ENV --env MONGO_URL=$DATABASE -l $LABEL
oc expose svc/portal 
