#!/bin/bash

# Array of European zones with NVIDIA T4 GPU availability
european_t4_zones=(
    "europe-west1-b"
    "europe-west1-d"
    "europe-west2-a"
    "europe-west2-b"
    "europe-west3-b"
    "europe-west4-a"
    "europe-west4-b"
    "europe-west4-c"
    "europe-central2-c"
    "europe-west6-b"
    "europe-west6-c"
)

# Project ID
PROJECT_ID="german-vocab-383907"

# Loop through each zone and create an instance
for zone in "${european_t4_zones[@]}"; do
    # Set a unique instance name based on the zone
    INSTANCE_NAME="comfy-${zone//-}"

    echo "Creating instance $INSTANCE_NAME in zone $zone..."

    # Run the gcloud command to create the instance
    gcloud compute instances create "$INSTANCE_NAME" \
        --project="$PROJECT_ID" \
        --zone="$zone" \
        --machine-type=n1-standard-1 \
        --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
        --maintenance-policy=TERMINATE \
        --provisioning-model=STANDARD \
        --service-account=99135837311-compute@developer.gserviceaccount.com \
        --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
        --accelerator=count=1,type=nvidia-tesla-t4 \
        --create-disk=auto-delete=yes,boot=yes,device-name="$INSTANCE_NAME",image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20241016,mode=rw,size=150,type=pd-balanced \
        --no-shielded-secure-boot \
        --shielded-vtpm \
        --shielded-integrity-monitoring \
        --labels=goog-ec-src=vm_add-gcloud \
        --reservation-affinity=any

    # Check if the command succeeded
    if [[ $? -eq 0 ]]; then
        echo "Instance $INSTANCE_NAME created successfully in zone $zone."
    else
        echo "Failed to create instance in zone $zone. Moving to the next zone."
    fi
done