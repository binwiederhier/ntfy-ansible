# ntfy-ansible
Playbook to deploy the [ntfy.sh](https://ntfy.sh) server. 

## Run playbook
```
ansible-playbook \
    -i inventory/dev.yml \
    -e @secrets/dev.yml \
    playbook.yml
```
