#!/usr/bin/env bash

ds_lab_host=$(cd terraform; terraform output ds-lab-dns)
(cd ansible; ansible-playbook update_inventory.yml --extra-vars "ds_lab_host=$ds_lab_host")