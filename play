#!/bin/bash

if [ -z "$1" ]; then
	echo "Syntax: $0 [dev|staging|prod] [playbook]"
	echo "Available playbooks: ntfy, repo"
	exit 1
fi

export env="$1"
export playbook="${2:-ntfy}"
ansible-playbook -i "inventory/$env.yml" -e "@secrets/$env.yml" "playbooks/$playbook.yml"
