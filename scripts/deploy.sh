#!/bin/bash

echo "Starting Deployment..."

cd ..

ansible-playbook -i ansible/inventory.ini ansible/setup.yml
ansible-playbook -i ansible/inventory.ini ansible/deploy.yml

echo "Deployment Completed "
