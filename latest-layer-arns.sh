#!/bin/bash -e

source regions.sh

for region in "${PYPY36_REGIONS[@]}"; do
    latest_arn=$(aws --region $region lambda list-layer-versions --layer-name pypy36 --output text --query "LayerVersions[0].LayerVersionArn")
    echo "* ${region}: \`${latest_arn}\`"
done
