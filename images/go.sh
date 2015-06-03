#!/bin/bash
FILENAME="mesos.json"
GCE_ACCOUNT_FILE="/Users/Jaroslav/.terraform/terraform-mesos-workshop.json"
GCE_PROJECT_ID="terraform-mesos"
GCE_IMAGE_NAME="ubuntu-1404-trusty-mesos"
GCE_ZONE="europe-west1-d"
MESOS_VERSION="0.22.1"

packer validate $FILENAME
packer build \
 -var "gce_account_file=$GCE_ACCOUNT_FILE" \
 -var "gce_project_id=$GCE_PROJECT_ID" \
 -var "gce_image_name=$GCE_IMAGE_NAME" \
 -var "gce_zone=$GCE_ZONE" \
 -var "mesos_version=$MESOS_VERSION" \
 $FILENAME