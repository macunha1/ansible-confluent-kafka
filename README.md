<h1 align="center">Confluent Kafka Ansible Role</h1>

<p align="center">
    <a href="https://github.com/macunha1/ansible-confluent-kafka/actions" alt="GitHub Actions build">
        <img src="https://img.shields.io/github/actions/workflow/status/macunha1/ansible-confluent-kafka/ci.yaml?branch=main" alt="GitHub Workflow Status" >
    </a>
    <a href="https://galaxy.ansible.com/macunha1/confluent_kafka" alt="Ansible Quality Score">
        <img src="https://img.shields.io/ansible/quality/53108" />
    </a>
    <a href="https://galaxy.ansible.com/macunha1/confluent_kafka" alt="Role Downloads">
        <img src="https://img.shields.io/ansible/role/d/53108" />
    </a>
</p>

<p align="center">
    <img src="http://img.shields.io/badge/platform-debian-a80030.svg?style=flat" />
    <img src="http://img.shields.io/badge/platform-fedora-4592fb.svg?style=flat" />
    <img src="http://img.shields.io/badge/platform-ubuntu-dd4814.svg?style=flat" />
    <img src="http://img.shields.io/badge/platform-redhat-cc0000.svg?style=flat" />
</p>

<p align="center">
    <a href="https://github.com/macunha1/ansible-confluent-kafka/pulls" alt="GitHub pull requests">
        <img src="https://img.shields.io/github/issues-pr-raw/macunha1/ansible-confluent-kafka"></a>
    <a href="https://github.com/macunha1/ansible-confluent-kafka/issues" alt="GitHub issues">
        <img src="https://img.shields.io/github/issues-raw/macunha1/ansible-confluent-kafka"></a>
</p>

This Ansible Role aims to install and configure Apache Kafka and Apache Zookeeper using the [Confluent package](https://www.confluent.io).

All configurations can be passed through vars, you can see the list of necessary
vars at [defaults](defaults/main.yaml) and customize them as you wish.

## Getting Started

### Prerequisites

Ansible 2.10+, Python and Pip.

```shell
pip install ansible>=2.10.0
```

After installing Ansible, you MUST install a [Java role](https://galaxy.ansible.com/list#/roles?page=1&page_size=10&autocomplete=java&order=-stargazers_count,name),
JDK is a must-have in your playbook. Kafka needs a JVM to run.

You can see the recommended version
[here](https://docs.confluent.io/current/kafka/deployment.html#jvm)) as well as
the supported Java versions and JDK implementations.

Pick your favorite from the list, set a role to install and configure it.

## Tests

The test suite is currently executing against Ansible 2.12 (as you can see [here](.github/workflows/ci.yaml)),
inside Docker containers running Ansible on Python 3, using Open JDK for the
sake of testing.

If you are curious about the status, there is a scheduled job that runs every
day, take a look at the GitHub Actions build history ;)

For further information on the Docker images being used to run containers on the CI, take a look at [docker-ansible](https://github.com/macunha1/docker-ansible/)

## Quickstart

### Example playbook

```yaml
---
- hosts: kafka,zookeeper

  vars:
    local_path: "/tmp"
    confluent_version: "5.4.0"
    confluent_distribution: "confluent-community"
    log_basepath: "/var/log"
    data_basepath: "/var/data"
    initscripts_path: "/usr/sbin"
    conf_dest: "/etc/config"

  roles:
    - macunha1.confluent_kafka
```

### Minimal playbook

```yaml
---
- hosts: kafka,zookeeper

  roles:
    - macunha1.confluent_kafka
```

### Example inventory

```toml
[kafka]
192.168.50.3

[zookeeper]
192.168.50.3
```

## Contribute

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Feel free to fill [an issue](https://github.com/macunha1/ansible-confluent-kafka/issues)
containing feature request(s), or (even better) to send me a Pull request, I
would be happy to collaborate with you.

If this role didn't work for you, or if you found some bug during the execution,
let me know.
