---
title: "Basic commands for Enterprise Linux 8"
subtitle: "Infrastructure Automation<br/>HOGENT applied computer science"
author: Bert Van Vreckem
date: 2021-2022
---

# Intro

## What is Enterprise Linux?

- [RedHat](https://www.redhat.com/en)-compatible Linux distro
    - RHEL = RedHat Enterprise Linux
- [AlmaLinux](https://almalinux.org/)
- [CentOS](https://centos.org/)
- [Oracle Linux](https://www.oracle.com/linux/)
- [Rocky Linux](https://rockylinux.org/)
- [Scientific Linux](https://scientificlinux.org/)
- ...

## RedHat family tree

![](https://upload.wikimedia.org/wikipedia/commons/a/a3/Redhat_family_tree_11-06.png)

## RedHat development stream

**Fedora → CentOS → RedHat → AlmaLinux/Rocky**

- **Fedora**: release elke 6m
- **CentOS**: rolling release
- **RedHat**: stabiele releases, meerdere jaren
    - Support-contract verplicht!
- **AlmaLinux/Rocky**: community-projecten
    - Byte-compatible
    - Zonder support (gratis)

## Agenda

- Network settings (`ip`)
- Managing services (`systemctl`)
- Show system logs (`journalctl`)
- Show sockets (`ss`)
- Firewall configuration (`firewalld`)

**Interrupt me if you have remarks/questions!**

## Demo environment

Code: see <https://github.com/HoGentTIN/infra-demo/>

| Host  | IP            | Service            |
| :---  | :---          | :---               |
| `web` | 192.168.56.72 | webserver (Apache) |
| `db`  | 192.168.56.73 | MariaDB database   |
| `ns1` | 192.168.56.10 | DNS server (BIND)  |
| `ns2` | 192.168.56.11 | DNS server         |

## For now, only start `db`

```console
$ git clone https://github.com/HoGentTIN/infra-demo.git
$ cd infra-demo/troubleshooting
$ vagrant status
Current machine states:

db                        not created (virtualbox)
web                       not created (virtualbox)
ns1                       not created (virtualbox)
ns2                       not created (virtualbox)
fs                        not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
$ vagrant up db
[...]
$ vagrant ssh db
```

# Network settings

## `ip`

| Task                | Command              |
| :---                | :---                 |
| NIC status          | `ip link`            |
| IP addresses        | `ip address`, `ip a` |
| for specific device | `ip a show dev em1`  |
| Routing info        | `ip route`, `ip r`   |

## Example

```console
$ ip l
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:54:3d:f0 brd ff:ff:ff:ff:ff:ff
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:f3:ff:26 brd ff:ff:ff:ff:ff:ff
```

---

```console
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:54:3d:f0 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic enp0s3
       valid_lft 86285sec preferred_lft 86285sec
    inet6 fe80::bb30:a03:db03:2918/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:f3:ff:26 brd ff:ff:ff:ff:ff:ff
    inet 192.168.56.73/24 brd 192.168.56.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fef3:ff26/64 scope link 
       valid_lft forever preferred_lft forever
```

## Configuration

- Config files: `/etc/sysconfig/network-scripts/ifcfg-*`
- After change, restart `network.service` (see below)

---

```bash
# /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
ONBOOT=yes
BOOTPROTO=dhcp
```

```bash
# /etc/sysconfig/network-scripts/ifcfg-eth1
DEVICE=eth1
ONBOOT=yes
BOOTPROTO=none
IPADDR=192.168.56.73
NETMASK=255.255.255.0
```

# Managing services with `systemctl`

## `systemctl`

`systemctl COMMAND [OPTION]... NAME`

| Task                | Command                    |
| :---                | :---                       |
| Status service      | `systemctl status NAME`    |
| Start service       | `systemctl start NAME`     |
| Stop service        | `systemctl stop NAME`      |
| Restart service     | `systemctl restart NAME`   |
| Start at boot       | `systemctl enable NAME`    |
| Don't start at boot | `systemctl disable NAME`   |

Usually, *root permissions* required (`sudo`)

---

Default command: `list-units`

| Task              | Command                     |
| :---              | :---                        |
| List all services | `systemctl --type=service`  |
| Running services  | `systemctl --state=running` |
| Failed services   | `systemctl --failed`        |

# Show open sockets/ports

## Show sockets: `ss`

- `netstat` is obsolete, replaced by `ss`
    - `netstat` uses `/proc/net/tcp`
    - `ss` directly queries the kernel
- Similar options

## Options

| Task                 | Command                |
| :---                 | :---                   |
| Show server sockets  | `ss -l`, `--listening` |
| Show TCP sockets     | `ss -t`, `--tcp`       |
| Show UDP sockets     | `ss -u`, `--udp`       |
| Show port numbers(*) | `ss -n`, `--numeric`   |
| Show process(†)      | `ss -p`, `--processes` |

(*) instead of service names from `/etc/services`

(†) *root permissions* required

## Example

```console
$ sudo ss -tlnp
State   Recv-Q Send-Q Local Address:Port Peer Address:Port
LISTEN  0      128                *:22              *:*    users:(("sshd",pid=1290,fd=3))
LISTEN  0      100        127.0.0.1:25              *:*    users:(("master",pid=1685,fd=13))
LISTEN  0      128               :::80             :::*    users:(("httpd",pid=4403,fd=4),("httpd",pid=4402,fd=4),("httpd",pid=4401,fd=4),("httpd",pid=4400,fd=4),("httpd",pid=4399,fd=4),("httpd",pid=4397,fd=4))
LISTEN  0      128               :::22             :::*    users:(("sshd",pid=1290,fd=4))
LISTEN  0      100              ::1:25             :::*    users:(("master",pid=1685,fd=14))
LISTEN  0      128               :::443            :::*    users:(("httpd",pid=4403,fd=6),("httpd",pid=4402,fd=6),("httpd",pid=4401,fd=6),("httpd",pid=4400,fd=6),("httpd",pid=4399,fd=6),("httpd",pid=4397,fd=6))
```

# System logs with `systemd-journald`

## `journalctl`

- `journalctl` requires *root permissions*
    - Or, add user to group `adm` or `systemd-journal`
- Some "traditional" text-based log files still exist (for now?):
    - `/var/log/messages` (gone in Fedora!)
    - `/var/log/httpd/access_log` and `error_log`
    - ...

## Options

| Action                               | Command                                   |
| :---                                 | :---                                      |
| Show latest log and wait for changes | `journalctl -f`, `--follow`               |
| Show only log of SERVICE             | `journalctl -u SERVICE`, `--unit=SERVICE` |
| Match executable, e.g. `dhclient`    | `journalctl /usr/sbin/dhclient`           |
| Match device node, e.g. `/dev/sda`   | `journalctl /dev/sda`                     |
| Show auditd logs                     | `journalctl _TRANSPORT=audit`             |

---

| Action                         | Command                               |
| :---                           | :---                                  |
| Show log since last boot       | `journalctl -b`, `--boot`             |
| Kernel messages (like `dmesg`) | `journalctl -k`, `--dmesg`            |
| Reverse output (newest first)  | `journalctl -r`, `--reverse`          |
| Show only errors and worse     | `journalctl -p err`, `--priority=err` |
| Since yesterday                | `journalctl --since=yesterday`        |

---

Filter on time (example):

```
journalctl --since=2018-06-00 \
           --until="2018-06-07 12:00:00"
```

Much more options in the man-page!

# Firewall configuration with `firewalld`

## Zones

- Zone = list of rules to be applied in a specific situation
    - e.g. public (default), home, work, ...
- NICs are assigned to zones
- For a server, `public` zone is probably sufficient

---

| Task                         | Command                              |
| :---                         | :---                                 |
| List all zones               | `firewall-cmd --get-zones`           |
| Current active zone          | `firewall-cmd --get-active-zones`    |
| Add interface to active zone | `firewall-cmd --add-interface=IFACE` |
| Show current rules           | `firewall-cmd --list-all`            |

`firewall-cmd` requires *root permissions*

## Configuring firewall rules

| Task                     | Command                            |
| :---                     | :---                               |
| Allow predefined service | `firewall-cmd --add-service=http`  |
| List predefined services | `firewall-cmd --get-services`      |
| Allow specific port      | `firewall-cmd --add-port=8080/tcp` |
| Reload rules             | `firewall-cmd --reload`            |
| Block all traffic        | `firewall-cmd --panic-on`          |
| Turn panic mode off      | `firewall-cmd --panic-off`         |

## Persistent changes

- `--permanent` option is not applied immediately!
- Two methods:
    1. Execute command once without, once with `--permanent`
    2. Execute command with `--permanent`, reload rules


```console
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
```

# That's it!
