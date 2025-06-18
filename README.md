# serj-auto
The repository contains ConSerj basic IaC declaratives (Terraform and Ansible).

## Terraform
- `main.tf` contains the configuration
- `variables.tf` contains variable definitions. Sensitive data is declared at terraform.tfvars which is out of scope naturally
- `inventory.sh` performs validate, plan and apply of the configuration, outputs the IP address of the server to an ansible inventory template, executes the ansible playbook.

## Ansible

- Common tasks are united in roles, subsequently executed by `playbook.yaml`. All the information required for role execution is stored in system folders within it
- `run-playbook.sh` shortens playbook call.

```
ansible/
├── inventory/
│   └── inventory.yaml
├── playbooks/
│   └── playbook.yaml
├── roles/
│   ├── common/
│   │   └── tasks/
│   │       └── main.yaml
│   ├── delete_apache/
│   │   └── tasks/
│   │       └── main.yaml
│   ├── docker/
│   │   ├── defaults/
│   │   │   └── main.yaml
│   │   └── tasks/
│   │       └── main.yaml
│   ├── drone_runner_exec/
│   │   ├── files/
│   │   │   └── config
│   │   └── tasks/
│   │       └── main.yaml
│   ├── git/
│   │   └── tasks/
│   │       └── main.yaml
│   └── seri_files/
│       ├── defaults/
│       │   └── main.yaml
│       ├── files/
│       │   └── id_ed25519
│       ├── tasks/
│       │   └── main.yaml
│       └── vars/
│           └── main.yaml
├── .ansible-lint
├── ansible.cfg
└── run_playbook.sh
```
