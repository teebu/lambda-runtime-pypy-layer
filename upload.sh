#!/bin/bash -e

source regions.sh

MD5SUM=($(md5sum pypy36.zip))
S3KEY="pypy3.6/${MD5SUM}.zip"

for region in "${PYPY36_REGIONS[@]}"; do
  bucket_name="pypy-iopipe-layers-${region}"

  echo "Uploading pypy36.zip to s3://${bucket_name}/${S3KEY}"

  aws --region $region s3 cp pypy36.zip "s3://${bucket_name}/${S3KEY}"
done