#!/bin/bash

# -v for stdout and stderr of each task executed
ansible-playbook -i ./inventory/inventory.yaml ./playbooks/playbook.yaml "$@"
