# Home Lab Repo

This repo contains the configuration and documentation for my home infrastructure. I try to adhere to GitOps principles and automate as much as possible.

## Stack

| [Talos](https://www.talos.dev/)                                 | Kubernetes distribution                               |
| [FluxCD](https://fluxcd.io/)                                    | GitOps tool                                           |
| [Renovate](https://github.com/renovatebot/renovate)             | Version upgrade Pull Requests                         |
| [GitHub Actions](https://docs.github.com/en/actions)            | Automation                                            |
| [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) | Documentation                                         |
| [direnv](https://direnv.net/)                                   | Directory-specific environment variables              |
| [SOPS](https://github.com/getsops/sops)                         | Encrypted secrets stored in the repo                  |
| [Doppler](https://www.doppler.com/)                             | Secret management                                     |
| [Taskfile](https://taskfile.dev/)                               | Common commands that are needed when using the repo   |

## Inspiration

Inspired by [bjw-s/home-ops](https://github.com/bjw-s/home-ops), [geerlingguy/pi-cluster](https://github.com/geerlingguy/pi-cluster) and the [k8s-at-home](https://github.com/topics/k8s-at-home) community.
