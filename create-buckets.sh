#!/bin/bash -e

source regions.sh

for region in "${PYPY36_REGIONS[@]}"; do
  bucket_name="pypy-iopipe-layers-${region}"

  echo "Creating bucket ${bucket_name}..."

  aws s3 mb s3://$bucket_name --region $region
done
