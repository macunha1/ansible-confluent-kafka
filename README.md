# Confluent Kafka Ansible Role [![CircleCI](https://circleci.com/gh/macunha1/confluent-kafka-role.svg?style=svg)](https://circleci.com/gh/macunha1/confluent-kafka-role)
---

This project aims to install and configure Kafka using the Confluent package, all configurations can be passed through vars. There's a list of necessary vars at [defaults](defaults/main.yml).
It's going with [Ansiblebit Oracle Java role](https://github.com/ansiblebit/oracle-java) as a requirement, but you can use any other Java role. If, for example, ansiblebit.oracle-java aren't working for some reason (mainly the Oracle website crawling).

It's strongly recommended (as you can see [here](https://docs.confluent.io/current/kafka/deployment.html#jvm)) to run the latest version of Oracle JDK 1.8 (Java 8). BUT, IF for some reason you would like to run it with another JDK, like Open JDK, just go ahead (at your own risk).

[![Platform](http://img.shields.io/badge/platform-centos-00ff7f.svg?style=flat)](#)
[![Platform](http://img.shields.io/badge/platform-debian-a80030.svg?style=flat)](#)
[![Platform](http://img.shields.io/badge/platform-fedora-4592fb.svg?style=flat)](#)
[![Platform](http://img.shields.io/badge/platform-redhat-cc0000.svg?style=flat)](#)
[![Platform](http://img.shields.io/badge/platform-ubuntu-dd4814.svg?style=flat)](#)

## Getting Started

### Prerequisites

Ansible 2.2+, Python and Pip.

```shell
pip install ansible>=2.2.0
```

After installing Ansible, you must install a [Java role](https://galaxy.ansible.com/list#/roles?page=1&page_size=10&autocomplete=java&order=-stargazers_count,name), and run it, Kafka needs a JVM to run.

Which can be easily done through:

```shell
ansible-galaxy install -r requirements.yml
```

## Tests

| Family | Distribution | Version        | Test Status                                                                     |
| :-:    | :-:          | :-:            | :-:                                                                             |
| RedHat | CentOS       | 7              | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Debian       | 8 (Jessie)     | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Debian       | 9 (Stretch)    | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| RedHat | Fedora       | 25 Cloud       | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Ubuntu       | 16.04 (Xenial) | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Ubuntu       | 18.04 (Bionic) | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |

## Quickstart

### Example playbook

```yaml
---
- hosts: kafka,zookeeper

  vars:
    dst_path: "/opt"
    local_path: "/tmp"
    confluent_version: "3.3.0"
    confluent_url: "http://packages.confluent.io/archive/{{ confluent_version[:3] }}/confluent-oss-{{ confluent_version }}-2.11.tar.gz"
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

## Built With

* [Ansible](https://www.ansible.com/) - Simple IT Automation
* [Confluent Kafka Package](https://www.confluent.io/) - Kafka for the Enterprise

## Authors

* [**Matheus Cunha** ](https://github.com/macunha1)

See also the list of [contributors](https://github.com/macunha1/confluent-kafka-role/contributors) who participated in this project.

#### Feedback, bug-reports, suggestions, ...

Are [welcome](https://github.com/macunha1/confluent-kafka-role/issues)!
