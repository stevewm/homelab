#!/usr/bin/env python3

# Reads secrets from `talsecret.yaml` and push them to Doppler for use
# in bootstrapping a cluster.

import os
import sys
import yaml
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format="%(message)s")

DEBUG = os.environ.get("TALOS_SECRETS_DRYRUN", False).lower == "true"
TALSECRET = f"{os.environ.get("TALCONFIG")}/talsecret.yaml"

if DEBUG:
    logger.setLevel(logging.DEBUG)

secrets = {
    "cluster.id": "CLUSTERNAME",
    "cluster.secret": "CLUSTERSECRET",
    "secrets.bootstraptoken": "BOOTSTRAPTOKEN",
    "secrets.secretboxencryptionsecret": "AESCBCENCYPTIONKEY",
    "trustdinfo.token": "TRUSTDTOKEN",
    "certs.etcd.crt": "ETCDCERT",
    "certs.etcd.key": "ETCDKEY",
    "certs.k8s.crt": "K8SCERT",
    "certs.k8s.crt": "K8SKEY",
    "certs.k8saggregator.crt": "K8SAGGCERT",
    "certs.k8saggregator.key": "K8SAGGKEY",
    "certs.k8sserviceaccount.key": "K8SSAKEY",
    "certs.os.crt": "OSCERT",
    "certs.os.key": "OSKEY",
}

with open(TALSECRET, "r") as f:
    try:
        config = yaml.safe_load(f)
    except yaml.YAMLError as exc:
        logger.error(f"Error loading {TALSECRET}: {exc}")
        sys.exit(1)

def get_value_from_path(data, path):
    keys = path.split(".")
    for key in keys:
        data = data[key]
    return data


for path, secret_name in secrets.items():
    try:
        value = get_value_from_path(config, path)
        if not DEBUG:
            logger.info(f"Setting {secret_name}")
            os.system(f"doppler secrets set {secret_name} {value} --silent --no-interactive")
        elif DEBUG:
            logger.debug(f"DEBUG: Would set {secret_name} to: {value}")
    except KeyError as e:
        logger.error(f"Error: Path '{path}' not found in the configuration. {e}")
    except Exception as e:
        logger.error(f"An error occurred: {e}")
