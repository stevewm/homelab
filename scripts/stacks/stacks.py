# Configuration:
# - STACKS_DIR:          Directory to watch for stack files
# - GIT_REPO:           Git repository that contains the stack files
# - PORTAINER_HOST:     Portainer host
#

import os
from typing import List
import logging
import requests

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")

PORTAINER_HOST = os.getenv("PORTAINER_HOST")  # https://localhost:19943
PORTAINER_STACK_API = f"{PORTAINER_HOST}/api/stacks"


class Stack:
    def __init__(
        self, name, compose_file, repository, update_interval="5m", env: dict = {}
    ):
        self.name = name
        self.file = compose_file
        self.repository = repository
        self.update_interval = update_interval
        self.env = env  # { "name": "name", "value": "value" }

    def __repr__(self):
        return f"Stack(name={self.name}, file={self.file}, repository={self.repository}, env_keys={self.env})"

    def __eq__(self, other):
        return self.name == other.name and self.file == other.file

    # Returns the payload used to create a stack
    def to_dict(self):
        return {
            "name": self.name,
            "composeFile": self.file,
            "repositoryURL": self.repository,
            "env": self.env,
            "autoupdate": {
                "interval": self.update_interval,
            },
        }


def auth(username: str, password: str) -> str:
    response = __make_request(
        "POST",
        f"{PORTAINER_HOST}/api/auth",
        data={"Username": username, "Password": password},
    )
    return response.get("jwt")


def get_stacks(access_token: str) -> List[Stack]:
    response = __make_request("GET", PORTAINER_STACK_API, token=access_token)
    if response is None:
        return []

    stacks = []
    for stack_data in response:
        stack = Stack(
            name=stack_data.get("Name"),
            compose_file=stack_data.get("EntryPoint"),
            repository=stack_data.get("RepositoryURL", ""),
            env=stack_data.get("Env", {}),
        )
        stacks.append(stack)
    return stacks


def create_stack(stack: Stack, endpoint_id: int, access_token: str):
    return __make_request(
        "POST",
        f"{PORTAINER_STACK_API}/create/standalone/repository",
        params={"endpointId": endpoint_id},
        data=stack.to_dict(),
        token=access_token,
    )


def __make_request(method, url, params=None, token=None, data=None):
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }
    try:
        match method.upper():
            case "GET":  # TODO: Switch verification back on
                resp = requests.get(url, verify=False, headers=headers, params=params)
            case "POST":
                resp = requests.post(
                    url, verify=False, headers=headers, params=params, json=data
                )
            case _:
                raise ValueError(f"Unsupported HTTP method: {method}")

        resp.raise_for_status()

        try:
            return resp.json()
        except ValueError as e:
            logger.error(f"Error decoding JSON response: {e}")
            logger.error(f"Response content: {resp.text}")
            return None

    except requests.exceptions.RequestException as e:
        logger.error(
            f"HTTP request failed: {e}"
        )  # TODO: Better handle if Portainer is down
        return None
