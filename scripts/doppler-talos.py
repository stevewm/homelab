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
    "certs.os.crt": "MACHINE_CA_CRT",
    "certs.os.key": "MACHINE_CA_KEY",
    "trustdinfo.token": "MACHINE_TOKEN",
    "certs.k8saggregator.crt": "CLUSTER_AGGREGATORCA_CRT",
    "certs.k8saggregator.key": "CLUSTER_AGGREGATORCA_KEY",
    "certs.etcd.crt": "CLUSTER_ETCD_CA_CRT",
    "certs.etcd.key": "CLUSTER_ETCD_CA_KEY",
    "secrets.secretboxencryptionsecret": "CLUSTER_SECRETBOXENCRYPTIONSECRET",
    "certs.k8sserviceaccount.key": "CLUSTER_SERVICEACCOUNT_KEY",
    "certs.k8s.crt": "CLUSTER_CA_CRT",
    "certs.k8s.key": "CLUSTER_CA_KEY",
    "cluster.id": "CLUSTER_ID",
    "cluster.secret": "CLUSTER_SECRET",
    "secrets.bootstraptoken": "CLUSTER_TOKEN",
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
