#!/usr/bin/env python3
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "pyyaml",
#     "requests",
# ]
# ///

# Reads secrets from `talsecret.yaml` and push them to Doppler for use
# in bootstrapping a cluster.

import os
import sys
import yaml
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format="%(message)s")

DEBUG = os.environ.get("TALOS_SECRETS_DRYRUN", "false").lower() == "true"
TALSECRET = f"{os.environ.get('TALOS_SECRETS_DIR')}/secrets.yaml"

if DEBUG:
    logger.setLevel(logging.DEBUG)

secrets = {
    "cluster.id": "CLUSTER_ID",
    "cluster.secret": "CLUSTER_SECRET",
    "secrets.bootstraptoken": "BOOTSTRAP_TOKEN",
    "secrets.secretboxencryptionsecret": "SECRETBOX_ENCRYPTION_SECRET",
    "trustdinfo.token": "TRUSTDINFO_TOKEN",
    "certs.etcd.crt": "ETCD_CERT",
    "certs.etcd.key": "ETCD_KEY",
    "certs.k8s.crt": "K8S_CERT",
    "certs.k8s.key": "K8S_KEY",
    "certs.k8saggregator.crt": "K8S_AGGREGATOR_CERT",
    "certs.k8saggregator.key": "K8S_AGGREGATOR_KEY",
    "certs.k8sserviceaccount.key": "K8S_SERVICEACCOUNT_KEY",
    "certs.os.crt": "OS_CERT",
    "certs.os.key": "OS_KEY",
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

count = len(secrets)
success_count = 0
logger.info(f"Processing {count} secrets from {TALSECRET}...")
for path, secret_name in secrets.items():
    try:
        value = get_value_from_path(config, path)
        if not DEBUG:
            logger.info(f"Setting {secret_name}")
            os.system(
                f"doppler secrets set {secret_name} '{value}' --silent --no-interactive --project talos"
            )
            success_count += 1
        elif DEBUG:
            logger.debug(f"DEBUG: Would set {secret_name} to: [REDACTED]")
    except KeyError as e:
        logger.error(f"Error: Path '{path}' not found in the configuration. {e}")
    except Exception as e:
        logger.error(f"An error occurred: {e}")

logger.info(f"Successfully processed {success_count}/{count} secrets.")
