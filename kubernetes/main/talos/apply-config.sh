#!/bin/bash

talosctl apply-config --nodes 192.168.1.51 --file ./clusterconfig/main-control01.yaml --insecure
talosctl apply-config --nodes 192.168.1.52 --file ./clusterconfig/main-control02.yaml --insecure
talosctl apply-config --nodes 192.168.1.53 --file ./clusterconfig/main-control03.yaml --insecure
