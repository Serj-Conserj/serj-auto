#!/bin/bash

INVENTORY_PATH="../ansible/inventory/inventory.yaml"
PLAYBOOK_RUNNER_PATH="../ansible/run_playbook.sh"


set -o pipefail

if ! terraform validate; then
    echo "[ERROR] Terraform validation failed." >&2
    exit 1
fi

if ! terraform plan -out=tfplan; then
    echo "[ERROR] Terraform plan failed." >&2
    rm -f tfplan
    exit 1
fi

terraform apply tfplan
rm -f tfplan

terraform output -json servers | \
yq -p=json -o=yaml '{
  "all": {
    "hosts": {
      "serj_dev": {
        "ansible_host": .dev_server.public_ip
      }
    },
    "vars": {
      "ansible_user": "root"
    }
  }

}' > $INVENTORY_PATH

if [ -f "$PLAYBOOK_RUNNER_PATH" ]; then
    cd $(dirname $PLAYBOOK_RUNNER_PATH)
    bash $(basename $PLAYBOOK_RUNNER_PATH)
else
    echo "[WARNING] Playbook runner not found! Run manually."
fi
