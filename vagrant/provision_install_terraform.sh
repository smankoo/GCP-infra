#!/bin/bash

wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip -P /tmp/
unzip /tmp/terraform_0.11.8_linux_amd64.zip -d /tmp
sudo mv /tmp/terraform /usr/bin/terraform
