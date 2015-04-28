#! /bin/bash

set -e

source config.sh

echo
echo "PROJECT_ID: ${PROJECT_ID}"
echo "Opening firewall for tcp:8080 to ${VM_NAME}"
gcloud compute firewall-rules create ${VM_NAME}-www \
  --allow tcp:8080 \
  --target-tags ${VM_NAME} || echo "Probably the firewall/rule already exists? Let's move on..."

echo
echo "Creating VM: ${VM_NAME}"
gcloud compute instances create ${VM_NAME} \
  --tags ${VM_NAME}-www \
  --zone ${ZONE} \
  --machine-type ${MACHINE_TYPE} \
  --image https://www.googleapis.com/compute/v1/projects/google-containers/global/images/container-vm \
  --metadata-from-file google-container-manifest=manifest.yaml  || echo "Probably the VM instance already exists? Let's move on..."

#wait_vm_ready