#!/usr/bin/env python3
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "pyyaml",
#     "requests",
# ]
# ///

# Stack Deployer
#
# Creates a stack if it doesn't exist on the target Portainer instance.
# The script doesn't handle deletion of stacks, but will warn of orphaned stacks you should probably delete.
#
import sys
import yaml
import os
from stacks import Stack, auth, create_stack, get_stacks
import logging

logger = logging.getLogger(__name__)

STACK_FILE_NAME = os.getenv("STACK_FILE_NAME", "docker-compose.yaml")
STACKS_DIR = os.getenv("STACKS_DIR")  # ./nas/stacks
GIT_REPO = os.getenv("GIT_REPO")  # https://github.com/stevewm/homelab

PORTAINER_USERNAME = os.getenv("PORTAINER_USERNAME")
PORTAINER_PASSWORD = os.getenv("PORTAINER_PASSWORD")
PORTAINER_ENVIRONMENT = os.getenv("PORTAINER_ENVIRONMENT")


def load_var_file(file_path: str) -> dict:
    try:
        with open(file_path, "r") as f:
            try:
                return yaml.safe_load(f)
            except yaml.YAMLError as e:
                logger.error(f"Error loading {file_path}: {e}")
                return {}
    except FileNotFoundError:
        logger.warning(f"Env file not found: {file_path}")
        return {}


def get_stack_files(STACKS_DIR: str) -> list[Stack]:
    stacks = []
    for root, _, files in os.walk(STACKS_DIR):
        for file in files:
            if file == STACK_FILE_NAME:
                stack_name = os.path.basename(root)
                stack_path = os.path.relpath(
                    os.path.join(root, file), start=os.getcwd()
                )
                env = load_var_file(os.path.join(root, ".env"))
                env = [{"name": k, "value": v} for k, v in env.items()]
                stack = Stack(
                    name=stack_name,
                    compose_file=stack_path,
                    repository=GIT_REPO,
                    env=env,
                )
                stacks.append(stack)
    if len(stacks) == 0:
        logger.error(
            f"No stack files found in {STACKS_DIR}. Are you sure you're in the right directory?"
        )
        sys.exit(1)
    return stacks


def main():
    token = auth(PORTAINER_USERNAME, PORTAINER_PASSWORD)

    deployed_stacks = get_stacks(token)
    logger.info(f"Found {len(deployed_stacks)} deployed stacks")

    stack_files = get_stack_files(STACKS_DIR)
    logger.info(f"Found {len(stack_files)} stack files")

    new_stacks = [stack for stack in stack_files if stack not in deployed_stacks]
    if len(new_stacks) == 0:
        logger.info("No new stacks to deploy")
        sys.exit(0)

    # stacks deployed with no corresponding file in the repo
    orphaned_stacks = [stack for stack in deployed_stacks if stack not in stack_files]

    if len(orphaned_stacks) > 0:
        logger.warning("Orphaned stacks found:")
        for stack in orphaned_stacks:
            logger.warning(f"- {stack.name}")

    if len(new_stacks) > 0:
        logger.info(f"Found {len(new_stacks)} new stacks to deploy")
        for stack in new_stacks:
            logger.info(f"Deploying stack: {stack.name}")
            create_stack(
                stack=stack, endpoint_id=PORTAINER_ENVIRONMENT, access_token=token
            )


if __name__ == "__main__":
    main()
