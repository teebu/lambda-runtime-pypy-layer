#!/bin/bash -e

VERSION=$1

source regions.sh

MD5SUM=($(md5sum pypy36.zip))
S3KEY="pypy3.6/${MD5SUM}.zip"

for region in "${PYPY36_REGIONS[@]}"; do
  bucket_name="iopipe-layers-${region}"

  echo "Deleting Lambda Layer pypy3.6 version ${VERSION} in region ${region}..."
  aws --region $region lambda delete-layer-version --layer-name pypy3.6 --version-number $VERSION
  echo "Deleted Lambda Layer pypy3.6 version ${VERSION} in region ${region}"
done
