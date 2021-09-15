---
title: "Configuration Management"
subtitle: "Infrastructure Automation<br/>HOGENT applied computer science"
author: Bert Van Vreckem
date: 2021-2022
---

# Configuration management

## Learning goals

- Understanding the concept of cfg mgmt systems
    - declarative, idempotent
    - advantages over scripting
- Setting up network services with Ansible
    - applying basic concepts: playbooks, variables, modules, roles
    - writing playbooks
    - using existing roles

## What's wrong with scripting?

```bash
dnf install -y httpd
systemctl enable --now httpd
firewall-cmd --add-service http --permanent
firewall-cmd --add-service https --permanent
firewall-cmd --reload
```

## Adding a user

```bash
adduser admin
```

Run this script twice:

```console
$ sudo ./configure.sh
$ sudo ./configure.sh
useradd: user 'admin' already exists
```

## What about...

- small changes between hosts?
- maintaining config files?
- maintaining a large Bash code base?
- configuration drift?

## Bash doesn't scale!

## Enter configuration management

- 1993: CFEngine by Mark Burgess
- Declarative
- Idempotent

## Declarative

- Describe the desired state of the system
    - DSL, existing language
- Cfg mgmt system brings system to desired state
    - independent of initial state
    - in one pass
    - abort on fail

## Example: CFEngine DSL

Domain Specific Language (DSL)

```cfengine
body common control {
    bundlesequence => { "install_packages" };
    inputs => { "libraries/cfengine_stdlib.cf" };
}

bundle agent install_packages {
    vars:
        "desired_packages"
            slist => { "httpd", "mod_ssl" };
    packages:
        "$(desired_packages)"
            package_policy => "add",
            package_method => generic;
}
```

## Example: Puppet manifest (DSL)

```puppet
package { 'httpd':
  ensure => installed,
}

service { 'httpd':
  ensure => running,
}
```

## Example: Chef recipe (Ruby)

```ruby
packages = ["httpd", "mod_ssl"]

packages.each do |pkg|
  package pkg do
    action: install
  end
end

service "httpd" do
  action [:start, :enable]
end
```

## Example: Ansible playbook (YAML)

```yaml
- hosts: srv001
  vars:
    packages:
      - httpd
      - mod_ssl
  tasks:
    - name: Ensure packages are installed
      package:
        name: "{{ packages }}"
        state: installed
    - name: Ensure the service is running
      service:
        name: httpd
        state: started
        enabled: true
```

## Idempotence

- Single pass
- End state is guaranteed
    - or run aborted!
- Only necessary changes

## Advantages

- Easier to reuse
- Readable
- Scaleable
- Config file templates
- Manage configuration drift
- Cfg mgmt = disaster recovery plan!

## Recommendation

- Manage your entire infrastructure using a config management system
- Use revision control system!
- Never make manual changes to a production system!

# Ansible demo

## Demo environment

<https://github.com/HoGentTIN/infra-demo/>

```console
git clone https://github.com/HoGentTIN/infra-demo
cd infra-demo/cfgmgmt
vagrant up srv001
```

## Main playbook

```yaml
# ansible/site.yml
---

- hosts: all
  roles: []
```

Let's try out the example playbook!

## Running a playbook (Vagrant)

```console
$ vagrant provision srv001
==> srv001: Running provisioner: ansible...
    srv001: Running ansible-playbook...

PLAY [srv001] ******************************************************************

TASK [Ensure packages are installed] *******************************************
changed: [srv001]

TASK [Ensure the service is running] *******************************************
changed: [srv001]

PLAY RECAP *********************************************************************
srv001                     : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

## Play it again, Sam!

```console
$ vagrant provision srv001
==> srv001: Running provisioner: ansible...
    srv001: Running ansible-playbook...

PLAY [srv001] ******************************************************************

TASK [Ensure packages are installed] *******************************************
ok: [srv001]

TASK [Ensure the service is running] *******************************************
ok: [srv001]

PLAY RECAP *********************************************************************
srv001                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

## Roles: reusable playbooks

<https://galaxy.ansible.com/>

```console
# ansible/site.yml
---
- hosts: srv001
  roles:
    - bertvv.httpd
```

Then, execute the role-deps script:

```console
./scripts/role-deps.sh
```

## Variables

First, add the role `bertvv.rh-base`

```console
# ansible/site.yml
---
- hosts: srv001
  roles:
    - bertvv.rh-base
    - bertvv.httpd
```

Check which variables are available:

<https://github.com/bertvv/ansible-role-rh-base>

## Initialising variables

- In the playbook
- `host_vars/srv001.yml`
- `group_vars/all.yml`

```yaml
# ansible/host_vars/srv001.yml
---
rhbase_install_packages:
  - bind-utils
  - tree
```

## That's enough for now!

## Resources

- [Ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/)
- [Ansible directory layout](https://docs.ansible.com/ansible/latest/user_guide/sample_setup.html)
- Recommended books:
    - Geerling, J. (2020) [*Ansible for Devops*](https://leanpub.com/ansible-for-devops)
    - Sesto, V. (2021) [*Practical Ansible*](https://link.springer.com/book/10.1007%2F978-1-4842-6485-0)

## Now, get started with the lab assignment!

(you may destroy this demo environment)

```console
$ vagrant destroy -f
==> srv001: Forcing shutdown of VM...
==> srv001: Destroying VM and associated drives...
```
