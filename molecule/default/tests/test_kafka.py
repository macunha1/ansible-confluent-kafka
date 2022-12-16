#!/usr/bin/env python3

import os
import pytest

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


@pytest.mark.parametrize('hostname,interface,port_number', [
    ("localhost", None, "2181"), # Zookeeper default port
    (None, "eth0", "9092"), # Kafka plain-text port (non-SSL)
    (None, "eth0", "9093"), # Kafka SSL port
    (None, "eth0", "8081"), # Schema Registry port
    (None, "eth0", "8082"), # Kafka REST port
])
def test_pkg(host, hostname, interface, port_number):
    if not hostname:
        hostname = host.interface(interface).addresses[0]

    localhost = host.addr(hostname)
    assert localhost.port(port_number).is_reachable


@pytest.mark.parametrize('svc', [
    'zookeeper',
    'kafka',
    'kafka-rest',
    'schema-registry',
])
def test_svc(host, svc):
    service = host.service(svc)

    assert service.is_running
    assert service.is_enabled
