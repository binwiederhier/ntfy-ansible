#!/bin/bash

if [ -z "$1" ]; then
	echo "Syntax: $0 [dev|staging|prod]"
	exit 1
fi

export env="$1"
ansible-playbook \
    -i "inventory/$env.yml" \
    -e "@secrets/$env.yml" \
    --ask-vault-pass \
    playbook.yml
