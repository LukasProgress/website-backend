#!/bin/bash

echo "ZIP the lambda functions"
zip -j lambda/visitor_counter.zip lambda/visitor_counter.py
zip -j lambda/reset_weekly_counter.zip lambda/reset_weekly_counter.py

echo "intitialize terraform"
cd terraform
terraform init

echo "apply changes, deploy"
terraform apply --auto-approve