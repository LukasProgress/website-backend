#!/bin/bash

zip -j lambda/visitor_counter.zip lambda/visitor_counter.py
zip -j lambda/reset_weekly_counter.zip lambda/reset_weekly_counter.py
cd terraform
terraform init
terraform apply --auto-approve