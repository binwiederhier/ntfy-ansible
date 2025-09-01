# ntfy-ansible
Ansible playbooks to deploy [ntfy.sh](https://ntfy.sh) server and related infrastructure.

## Available Playbooks
- `ntfy.yml` - Deploy ntfy server
- `repo.yml` - Deploy aptly debian package repository

## Run playbooks
Using the helper script:
```bash
./play.sh [dev|staging|prod] [ntfy|repo]
```

Or directly with ansible-playbook:
```bash
# Deploy ntfy server
ansible-playbook -i inventory/dev.yml -e @secrets/dev.yml playbooks/ntfy.yml

# Deploy package repository
ansible-playbook -i inventory/dev.yml -e @secrets/dev.yml playbooks/repo.yml
```

## Package Repository Management
After deploying the repository with `repo.yml`, you can manually add packages by:

1. SSH into the server
2. Copy your .deb file to `/opt/aptly/upload/`
3. Run `/opt/aptly/add-package.sh /opt/aptly/upload/your-package.deb`

The repository will be available at `http://your-server/` with automatic nginx serving.
