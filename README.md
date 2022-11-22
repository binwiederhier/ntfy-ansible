# ntfy-ansible
Playbook to deploy the [ntfy.sh](https://ntfy.sh) and [nopaste.net](https://nopaste.net) server. 

## Run playbook
```
ansible-playbook \
    -i inventory/dev.yml \
    -e @secrets/dev.yml \
    --ask-vault-pass \
    playbook.yml
```

## Encrypt/decrypt secrets
```
ansible-vault encrypt secrets/staging.yml
ansible-vault decrypt secrets/staging.yml
```
