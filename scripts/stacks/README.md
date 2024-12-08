# Stack Deployer

Deploys newly defined stacks to Portainer. Does not handle deletion of stacks, but will warm of orphaned stacks. Designed to be run as a cron job.

## Configuration

Environment variables are used to configure the deployer:

- `DOPPLER_API_TOKEN`: The Doppler API token to use for fetching secrets.
- `GIT_REPO`: The (https) URL of the git repository to clone.
- `STACKS_DIR`: The directory within the repository where stacks are defined. (eg `./nas/stacks`)
- `STACK_FILE_NAME`: The name of the stack file. (default: `docker-compose.yaml`)
- `PORTAINER_HOST`: The host of the Portainer instance.
- `PORTAINER_USERNAME`: The username to use for authenticating with Portainer.
- `PORTAINER_PASSWORD`: The password to use for authenticating with Portainer.
`PORTAINER_ENVIRONMENT`: The environment to deploy the stack to. This can be found in your address bar on the Portainer dashboard when browsing the environment.

Stack Deployer expects each stack to be contained in its own folder in `STACKS_DIR`. The folder should contain the stack file (`docker-compose.yaml` by default) and an optional env template file (`env.tmpl`).

## Usage

A container image is available on GitHub Container Registry: `ghcr.io/stevewm/stack-deployer`
