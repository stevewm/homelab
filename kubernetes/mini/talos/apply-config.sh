#!/bin/bash


talosctl apply-config --insecure --nodes 192.168.1.51 --file ./clusterconfig/mini-control01.yaml
talosctl apply-config --insecure --nodes 192.168.1.52 --file ./clusterconfig/mini-control02.yaml
talosctl apply-config --insecure --nodes 192.168.1.53 --file ./clusterconfig/mini-control03.yaml
talosctl apply-config --insecure --nodes 192.168.1.54 --file./clusterconfig/mini-worker01.yaml
