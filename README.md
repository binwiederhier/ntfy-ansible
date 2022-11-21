# ntfy-ansible
Playbook to deploy the [ntfy.sh](https://ntfy.sh) and [nopaste.net](https://nopaste.net) server. 

## Run playbook
```
ansible-playbook \
    -i inventory/localhost.yml \
    -e @secrets.yml \
    --ask-vault-pass \
    playbook.yml
```

## Encrypt/decrypt secrets
```
ansible-vault encrypt secrets.yml
ansible-vault decrypt secrets.yml
```
