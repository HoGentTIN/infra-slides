---
title: "1. Continuous Integration/ Deployment with Jenkins"
subtitle: "Infrastructure Automation<br/>HOGENT applied computer science"
author: Bert Van Vreckem & Thomas Parmentier
date: 2024-2025
---

# Intro

## Traditional release

- Weeks/months apart
- Lots of changes!
- ⇒ Lots of bugs...
    - Wait for vN.1?
- Releases are painful, high-risk events

## How e.g. Facebook does it

- "If it hurts, do it more often"
- Dozens of releases per day!
- Small, incremental changes go into production
- ⇒ Reduced risk

Read more: [Rapid release at massive scale](https://engineering.fb.com/2017/08/31/web/rapid-release-at-massive-scale/)

## Continuous Integration/Delivery

![CI vs CD. ([Redhat, 2020](https://www.redhat.com/en/topics/devops/what-is-continuous-delivery))](assets/ci-cd-flow-desktop_edited.png)

## Typical tasks (1)

- Linting: code style checks
- Static analysis (e.g. shellcheck)
- Compilation
- Unit tests
- Code coverage analysis
- Packaging

## Typical tasks (2)

- Release to package repository
- Deploy in acceptance environment
- Integration/acceptance/load-tests...
- Deploy to production

# CI/CD tooling

## Overview

- Open source
    - [Concourse](https://concourse-ci.org/)
    - [Jenkins](https://www.jenkins.io/)
    - [Spinnaker](https://spinnaker.io/)
- Commercial on-prem
    - [Atlassian Bamboo](https://www.atlassian.com/software/bamboo)
    - [Jetbrains TeamCity](https://www.jetbrains.com/teamcity/)

---

- Commercial, hosted
    - [AWS CodePipeline](https://aws.amazon.com/getting-started/hands-on/set-up-ci-cd-pipeline/)
    - [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/)
    - [CircleCI](https://circleci.com/)
    - [Codeship](https://www.cloudbees.com/products/codeship)
    - [Github Actions](https://github.com/features/actions)
    - [GitLab CI](https://docs.gitlab.com/ee/ci/)
    - [Travis CI](https://travis-ci.org/)

## Jenkins

<https://www.jenkins.io/>

- Open source
- Mature
- Most flexibility
    - on-prem/private/public cloud
    - rich feature set

---

![Jenkins Example output ([Wikipedia](https://upload.wikimedia.org/wikipedia/commons/8/8d/Ansible-playbook-output-jenkins.png))](assets/Ansible-playbook-output-jenkins.png)

## A Github Actions case

This slide deck was built on Github Actions & deployed to Github Pages!

<https://github.com/HoGentTIN/infra-slides>

## Working with Github Actions

- Go to Actions, New workflow
- Or create `.github/workflows/workflow-name.yml`
- [RTFM](https://docs.github.com/en/actions)

## Example workflow

<https://github.com/HoGentTIN/infra-slides/blob/main/.github/workflows/compile.yml>

```yaml
---
name: compile
on:
  push:
    branches:
      - main
jobs:
  convert_via_pandoc:
    runs-on: ubuntu-18.04
    steps:
      - name: Configure Git for Github
        run: |
          git config --global user.name "${GITHUB_ACTOR}"
          git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
      - uses: actions/checkout@v2
      - uses: r-lib/actions/setup-pandoc@v1
        with:
          pandoc-version: '2.9'
      - name: Publish Site
        env:
          REPOSITORY: "https://${{ secrets.GITHUB_PAT }}@github.com/${{ github.repository }}.git"
        run: ./publish.sh
```

## Another case: testing Ansible roles

<https://github.com/bertvv/ansible-role-bind/blob/master/.github/workflows/ci.yml>

- Ansible role `bertvv.bind`
- Installs ISC BIND (a DNS server) on several Linux distros
- ~40 contributors, dozens of PRs
- Contributed code may break the role!

## Testing Ansible roles in Gitlab CI

- On each push/PR:
    - Spin up Docker container for each supported distro
    - Apply role, use (most) functionality
    - Run acceptance tests (= DNS queries)

# Get started with the lab assignment!

## Jenkins lab assignment

```console
$ cd dockerlab
$ vagrant up
$ vagrant ssh
```

Follow the steps in the assignment <https://github.com/HoGentTIN/infra-labs/blob/main/assignment/2-cicd.md>

Jenkins UI resides at <http://192.168.56.20:8080/>

## Setup

- Jenkins runs in a Docker container
- Default installation, minimal configuration required
- Launch demo application in another Docker container
- Make change, rebuild & deploy!

# Reflection

## Lab setup vs reality

- Complete build server
    - Physical system or "traditional" VM
    - Worker nodes
- Central repo + build tools

## Change in discipline needed!

- code coverage ⟶ 100%
- [feature flags](https://martinfowler.com/articles/feature-toggles.html)
- [canary deployment](https://martinfowler.com/bliki/CanaryRelease.html)
- [blue/green deployment](https://martinfowler.com/bliki/BlueGreenDeployment.html)
- [trunk-based development](https://martinfowler.com/articles/branching-patterns.html)

## Canary deployments

![Canary deployments ([Sato, 2014](https://martinfowler.com/bliki/images/canaryRelease/canary-release-2.png))](assets/canary-release-2.png)

## Blue-Green Deployment

![Acceptance/Prod swap places ([Fowler, 2010](https://martinfowler.com/bliki/BlueGreenDeployment.html))](assets/blue_green_deployments.png)

## Trunk-based development

![Branches considered harmful! ([Fowler, 2020](https://martinfowler.com/articles/branching-patterns.html))](assets/leroy-branch.jpg)
