#!/bin/bash -e

source regions.sh

MD5SUM=($(md5sum pypy36.zip))
S3KEY="pypy3.6/${MD5SUM}.zip"

for region in "${PYPY36_REGIONS[@]}"; do
  bucket_name="pypy-iopipe-layers-${region}"

  echo "Publishing Lambda Layer pypy3.6 in region ${region}..."
  version=$(aws lambda publish-layer-version \
      --layer-name pypy36 \
      --description "PyPy 3.6 Lambda Runtime" \
      --content "S3Bucket=${bucket_name},S3Key=${S3KEY}" \
      --compatible-runtimes provided \
      --license-info "MIT" \
      --output text \
      --query Version \
      --region $region)
  echo "Published Lambda Layer pypy3.6 in region ${region} version ${version}"

  echo "Setting public permissions on Lambda Layer pypy3.6 version ${version} in region ${region}..."
  aws lambda add-layer-version-permission \
      --layer-name pypy36 \
      --version-number $version \
      --statement-id public \
      --action lambda:GetLayerVersion \
      --principal "*" \
      --region $region \
      > /dev/null
  echo "Public permissions set on Lambda Layer pypy3.6 version ${version} in region ${region}"
done