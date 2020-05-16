<h1 align="center">Confluent Kafka Ansible Role</h1>

<p align="center">
    <a href="https://circleci.com/gh/macunha1/confluent-kafka-role" alt="CircleCI build">
        <img src="https://img.shields.io/circleci/build/github/macunha1/confluent-kafka-role" /></a>
    <a href="https://galaxy.ansible.com/macunha1/confluent-kafka" alt="Ansible Quality Score">
        <img src="https://img.shields.io/ansible/quality/24090" /></a>
    <a href="https://galaxy.ansible.com/macunha1/confluent-kafka" alt="Role Downloads">
        <img src="https://img.shields.io/ansible/role/d/24090" /></a>
</p>

<p align="center">
    <img src="http://img.shields.io/badge/platform-centos-00ff7f.svg?style=flat" />
    <img src="http://img.shields.io/badge/platform-debian-a80030.svg?style=flat" />
    <img src="http://img.shields.io/badge/platform-fedora-4592fb.svg?style=flat" />
    <img src="http://img.shields.io/badge/platform-redhat-cc0000.svg?style=flat" />
    <img src="http://img.shields.io/badge/platform-ubuntu-dd4814.svg?style=flat" />
</p>

<p align="center">
    <a href="https://github.com/macunha1/confluent-kafka-role/pulls" alt="GitHub pull requests">
        <img src="https://img.shields.io/github/issues-pr-raw/macunha1/confluent-kafka-role"></a>
    <a href="https://github.com/macunha1/confluent-kafka-role/issues" alt="GitHub issues">
        <img src="https://img.shields.io/github/issues-raw/macunha1/confluent-kafka-role"></a>
</p>

This Ansible Role aims to install and configure Apache Kafka and Apache Zookeeper using the [Confluent package](https://www.confluent.io).

All configurations can be passed through vars, you can see the list of necessary
vars at [defaults](defaults/main.yaml) and customize them as you wish.

The requirements include [Ansiblebit Oracle Java role](https://github.com/ansiblebit/oracle-java),
but you can use any other Java role. If, for example, ansiblebit.oracle-java
isn't working for some reason (mainly the Oracle website crawling for Java 8).

It's strongly recommended (as you can see [here](https://docs.confluent.io/current/kafka/deployment.html#jvm)) to run the latest version of Oracle JDK 1.8 (Java 8) or Java 11.
BUT, IF for some reason you would like to run it with another JDK, like OpenJDK, just go ahead (at your own risk).

## Getting Started

### Prerequisites

Ansible 2.2+, Python and Pip.

```shell
pip install ansible>=2.2.0
```

After installing Ansible, you must install a [Java role](https://galaxy.ansible.com/list#/roles?page=1&page_size=10&autocomplete=java&order=-stargazers_count,name),
and use it in your playbook. Kafka needs a JVM to run.

Which can be easily done through:

```shell
ansible-galaxy install -r requirements.yaml
```

## Tests

The test suite is currently executing against Ansible 2.9.6 (as you can see [here](.circleci/config.yaml#L8)),
inside Docker containers running both major Python versions (2 and 3).

For further information on the Docker images being used to run containers on the CI, take a look at [docker-ansible](https://github.com/macunha1/docker-ansible/)

<div align="center">

| Family | Distribution |    Version     |                                   Test Status                                   |
| :----: | :----------: | :------------: | :-----------------------------------------------------------------------------: |
| Alpine | Alpine Linux |      3.8+      | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| RedHat |    CentOS    |       6        | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| RedHat |    CentOS    |       7        | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian |    Debian    |   8 (Jessie)   | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian |    Debian    |  9 (Stretch)   | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian |    Debian    |  10 (Buster)   | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| RedHat |    Fedora    |    25 Cloud    | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian |    Ubuntu    | 16.04 (Xenial) | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian |    Ubuntu    | 18.04 (Bionic) | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian |    Ubuntu    | 20.04 (Bionic) | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |

</div>

## Quickstart

### Example playbook

```yaml
---
- hosts: kafka,zookeeper

  vars:
    dst_path: "/opt"
    local_path: "/tmp"
    confluent_version: "5.4.0"
    scala_version: "2.12"
    confluent_distribution: "confluent-community"
    confluent_url: "http://packages.confluent.io/archive/{{ confluent_version[:3] }}/{{ confluent_distribution }}-{{ confluent_version }}-{{ scala_version }}.tar.gz"
    log_basepath: "/var/log"
    data_basepath: "/var/data"
    initscripts_path: "/usr/sbin"
    conf_dest: "/etc/config"
    # Oracle Java necessary vars. IF you are using ansiblebit.oracle-java
    oracle_java_set_as_default: yes
    oracle_java_version: 8

  roles:
    - ansiblebit.oracle-java
    - macunha1.confluent-kafka
```

### Minimal playbook

```yaml
---
- hosts: kafka,zookeeper

  roles:
    - ansiblebit.oracle-java
    - macunha1.confluent-kafka
```

### Example inventory

```toml
[kafka]
192.168.50.3

[zookeeper]
192.168.50.3
```

## Feedback and further development

If this role didn't work for you, or if you found some bug during the execution,
let me know. 

Feel free to open a [feature request, an issue](https://github.com/macunha1/confluent-kafka-role/issues), or to send me a Pull request, I will be happy to colaborate.

## Built With

- [Ansible](https://www.ansible.com/) - Simple IT Automation
- [Confluent Kafka Package](https://www.confluent.io/) - Kafka for the Enterprise

## Authors

- [**Matheus Cunha** ](https://github.com/macunha1)

See also the list of [contributors](https://github.com/macunha1/confluent-kafka-role/contributors) who participated in this project.
