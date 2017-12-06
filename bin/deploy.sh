#!/usr/bin/env bash

(cd terraform; terraform init)
(cd terraform; terraform apply)
ds_lab_host=$(cd terraform; terraform output ds-lab-dns)
(cd ansible; ansible-playbook update_inventory.yml --extra-vars "ds_lab_host=$ds_lab_host")
(cd ansible; ansible-playbook setup.yml)