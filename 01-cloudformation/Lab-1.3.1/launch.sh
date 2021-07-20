#!/bin/bash
# Use this script as a quick execute shim for testing cfn stacks

REGIONFILE="regions.json"
REGIONS="$(cat $REGIONFILE | jq '.Regions[].RegionName' | grep us-)"
SCRIPT="./s3cfnTool.sh"

getRegions() {
    echo
    echo "Attempting to invoke $SCRIPT."
    for region in $REGIONS; do
        /bin/bash -c "$SCRIPT describe $region"
    done
}

main() {
    # local cmd=$1
    # if [[ -n $cmd ]]; then
        getRegions
    # fi
}

main "$@"
