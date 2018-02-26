# Confluent Kafka Ansible Role

This project aims to install and configure Kafka using the Confluent package, all configurations can be passed through [vars](vars/main.yml) or [defaults](defaults/main.yml).

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

After installing Ansible, you must install [Ansiblebit Oracle Java role](https://github.com/ansiblebit/oracle-java), necessary to the JVM for Kafka.

Which can be easily done through:

```shell
ansible-galaxy install -r requirements.yml
```

## Tests

| Family | Distribution | Version | Test Status |
|:-:|:-:|:-:|:-:|
| RedHat | CentOS  | 6         | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| RedHat | CentOS  | 7         | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Debian  | Jessie    | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Debian  | Stretch   | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| RedHat | Fedora  | 25 Cloud  | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Ubuntu  | Trusty    | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |
| Debian | Ubuntu  | Xenial    | [![x86_64](http://img.shields.io/badge/x86_64-passed-006400.svg?style=flat)](#) |

## Example Playbook

```yaml
- hosts: kafka

  vars:
    dst_path: "/opt"
    local_path: "/tmp"
    confluent_version: "3.3.0"
    confluent_url: "http://packages.confluent.io/archive/{{ confluent_version[:3] }}/confluent-oss-{{ confluent_version }}-2.11.tar.gz"
    log_basepath: "/var/log"
    data_basepath: "/var/data"
    initscripts_path: "/usr/sbin"
    conf_dest: "/etc/config"
    # Oracle Java necessary vars
    oracle_java_set_as_default: yes
    oracle_java_version: 8

  roles:
    - ansiblebit.oracle-java
    - matheuscunha.confluent-kafka
```

## Built With

* [Ansible](https://www.ansible.com/) - Simple IT Automation
* [Confluent Kafka Package](https://www.confluent.io/) - Kafka for the Enterprise

## Authors

* [**Matheus Cunha** ](https://github.com/matheuscunha)

See also the list of [contributors](https://github.com/matheuscunha/confluent-kafka-role/contributors) who participated in this project.
