---
title: Infrastructure Automation
subtitle: HOGENT toegepaste informatica
author: Bert Van Vreckem
date: 2021-2022
---

# Intro

## Woensdag 10 maart, 01:31

[Inuits](https://inuits.eu/) on-call team merkt dat VMs uitvallen

## Dit zijn productie-systemen!

## Ze komen niet meteen terug...

## Woensdag 10 maart, 03:42

<center><blockquote class="twitter-tweet"><p lang="en" dir="ltr">We have a major incident on SBG2. The fire declared in the building. Firefighters were immediately on the scene but could not control the fire in SBG2. The whole site has been isolated which impacts all services in SGB1-4. We recommend to activate your Disaster Recovery Plan.</p>&mdash; Octave Klaba (@olesovhcom) <a href="https://twitter.com/olesovhcom/status/1369478732247932929?ref_src=twsrc%5Etfw">March 10, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></center>

## De situatie

- [OVHcloud](https://www.ovhcloud.com/nl/) is een cloud provider
- 32 datacenters over 4 continenten
- o.a. in Straatsburg (SBG)

---

![](https://static.reuters.com/resources/r/?m=02&d=20210310&t=2&i=1554440499&r=LYNXMPEH290XD&w=2048)

---

![](https://static.reuters.com/resources/r/?m=02&d=20210310&t=2&i=1554440500&r=LYNXMPEH290XE&w=2048)

---

![](https://static.reuters.com/resources/r/?m=02&d=20210310&t=2&i=1554440501&r=LYNXMPEH290XF&w=2048)

---

![](https://cdn.eu.tz.nl/wp-content/uploads/2021/03/20210310-ovhcloud-brand-1284x856.jpg)

## Je servers zijn *weg*. Wat nu?

## Wat is er gebeurd?

- Wellicht gefaalde Uninterruptible Power Source (UPS)
- 3,6M websites, 464K domeinen weg
- Effect op bedrijven én overheden
- Geen disaster recovery plan? Weg data!

## De situatie bij Inuits

- 130 VMs over 12 servers weg
- Meeste opgevangen door automatische failover naar andere datacenters
- Enkele "probleemgevallen"

## Casus 1

- VIP klant, failover faalt
- DNS manueel aanpassen, ander IP voor loadbalancer
- 1u tijd verloren: klant moest zelf ook domein aanpassen

## Casus 2

- Klant verspreid over 2 DC's
- Vóór 09:00 volledige infra gereconstrueerd bij andere ISP
- Zonder verwittiging zou klant niets gemerkt hebben...

## Impact voor Inuits

- **Geen dataverlies!**
- Meeste problemen opgelost tegen start kantooruren

## Hoe komt dit?

- **Infrastructure as Code**
    - Configuration Management
    - Build pipelines voor alles
- Cloud native
    - Bezitten geen HW
    - Multi-cloud, cloud-agnostic
- High Availability ingebouwd

## Referenties

- Buytaert, K. (2020-06-17) [Help, my datacenter is on fire!](https://www.slideshare.net/KrisBuytaert/help-my-datacenter-is-on-fire). StackConf 2021. <https://youtu.be/zDfH0DpHT3s>
- Rosemain, M. & Satter, R. (2021-03-10) [Millions of websites offline after fire at French cloud services firm](https://www.reuters.com/article/us-france-ovh-fire-idUSKBN2B20NU). Reuters
- Witteman, E. (2021-03-15) [OVH fire may be caused by faulty UPS](https://www.techzine.eu/news/infrastructure/56935/ovh-fire-may-be-caused-by-faulty-ups/)

# Infrastructure Automation

## Infrastructure Automation

of ook:

- Infrastructure as Code
- GitOps
- DevOps

## Levenscyclus van een server

Wat zijn de verschillende fasen in het "leven" van een server(-VM)?

## Levenscyclus van een server: tooling (1/3)

- **Provisioning:** lege machine → JEOS
    - Packer, Docker, ...
- **Configuration Management:** JEOS → klaar voor productie
    - Ansible, Puppet, Chef, CFEngine, SaltStack, ...

## Levenscyclus van een server: tooling (2/3)

- **Software Delivery**/Release engineering
    - CI/CD: Jenkins, Travis CI, Circle CI, Gitlab CI, Github Actions, ...
    - Packaging: rpmbuild, dpkg-deb, fpm
    - Package mgmt: RPM, deb, npm, RubyGems, pip, Helm, Chocolatey, NuGet, ...
    - Repository management: Pulp

## Levenscyclus van een server tooling (3/3)

- **Orchestration:** systemen in productie beheren
    - Ansible, SaltStack, ...
- **Monitoring:**
    - Traditioneel: Icinga, Nagios, ...
    - Time Series DB: Prometheus, collectd, Cacti, ...
    - Logging: Elastic stack, Splunk, Fluentd, ...

# Studiewijzer

## Studiewijzer

Zie <https://hogenttin.github.io/infra-syllabus/#studiewijzer>

## Cursus binnen het curriculum

![](assets/infra-plaats-curriculum.png)

## Leerdoelen en competenties

- **Configuration Management Systems**
    - Ansible
- **Reproduceerbare virtuele omgevingen** opzetten
    - Vagrant, Docker, Docker-compose
- **Orchestratie**
    - Ansible, Docker-compose, (Kubernetes)
- **Monitoring, logs**
    - Cockpit, Portainer, journalctl

<span style="color:red">**Let op: 2021-2022 is overgangsjaar**</span>

## Leerinhoud

- Inleiding, opzetten werkomgeving
- M1. Containervirtualisatie
- M2. Continuous Integration/Delivery
- M3. Bottom-up troubleshooting
- M4. Configuration Management

## Leermateriaal

- Start op Chamilo, overzicht in cursus intro
- Github: [syllabus](https://hogenttin.github.io/infra-syllabus/), [slides](https://hogenttin.github.io/infra-slides/), [demo](https://github.com/HoGentTIN/infra-demo), [labo-taken](https://github.com/HoGentTIN/infra-labs)
- Online handleidingen gebruikte software
- (Boeken - zie [studiewijzer](https://hogenttin.github.io/infra-syllabus/#aanbevolen-boeken))

## Nodige software

```console
PS> choco install git
PS> choco install vscode
PS> choco install virtualbox
PS> choco install vagrant
```

(Mac, Linux: zie [studiewijzer](https://hogenttin.github.io/infra-syllabus/#software))

## Software (vervolg)

- VSCode: installeer plugins (zie studiewijzer)
- VirtualBox: Extension Pack!
- Git client: installeer ook Git Bash!

## Werkvormen

- Klassikale instructie, demonstratie
- Labo-opdrachten

## Contactmomenten

- Code <span style="color:green;font-weight:bold">groen</span>: op de campus, zie lesrooster
- Code <span style="color:yellow;font-weight:bold">geel</span>/<span style="color:orange;font-weight:bold">oranje</span>/<span style="color:red;font-weight:bold">rood</span>: via Teams

## Studiebegeleiding

- Individuele begeleiding voor labo-opdrachten
- Stel vragen *tijdens contactmomenten*
- Buiten contactmomenten: *algemeen Teams-kanaal*
- Enkel bij persoonlijke vragen: *e-mail/Teams chat*

## Planning

1. Inleiding, installatie, M1. (Containers)
2. (vervolg)
3. M2. Continuous Integration/Delivery
4. M3. Bottom-up Troubleshooting
5. Troubleshooting-labo 1
6. (vervolg)

## Planning (vervolg)

7. M4. Configuration management
8. (vervolg)
9. (vervolg)
10. (vervolg)
11. (vervolg)
12. Troubleshooting-labo 2
13. Optioneel: inhaalsessie

## Evaluatie

- **Portfolio**:
    - Github repo met broncode, verslagen
- **Demonstratie**:
    - Tijdens semester (minstens 3x)
    - Eindresultaat

## 2e examenkans

Persoonlijke opdracht, zonder begeleiding

- verder werken aan labo's
- extra labo-opdracht (Kubernetes)

## Vragen?
