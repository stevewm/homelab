<a name="readme-top"></a>

# Home Lab

![Kubernetes Version](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fstevewm%2Fhomelab%2Fmain%2Fkubernetes%2Fmini%2Ftalos%2Ftalconfig.yaml&query=%24.kubernetesVersion&style=for-the-badge&logo=kubernetes&label=Kubernetes) ![Talos Version](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fstevewm%2Fhomelab%2Fmain%2Fkubernetes%2Fmini%2Ftalos%2Ftalconfig.yaml&query=%24.talosVersion&style=for-the-badge&logo=kubernetes&label=talos&color=%23FA640A&link=https%3A%2F%2Ftalos.dev%2F)

This repo contains the configuration and documentation for my home infrastructure. I try to adhere to GitOps principles and automate as much as possible.

## Built With

| Name                                                            | Description                                         |
| --------------------------------------------------------------- | --------------------------------------------------- |
| [Talos](https://www.talos.dev/)                                 | Kubernetes distribution                             |
| [FluxCD](https://fluxcd.io/)                                    | GitOps tool                                         |
| [Renovate](https://github.com/renovatebot/renovate)             | Version upgrade Pull Requests                       |
| [GitHub Actions](https://docs.github.com/en/actions)            | Automation                                          |
| [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) | Documentation                                       |
| [direnv](https://direnv.net/)                                   | Directory-specific environment variables            |
| [devshell](https://github.com/numtide/devshell)                 | Repo-specific dev environment                       |
| [SOPS](https://github.com/getsops/sops)                         | Encrypted secrets stored in the repo                |
| [Doppler](https://www.doppler.com/)                             | Secret management                                   |
| [pre-commit](https://pre-commit.com/)                           | Linting and validation                              |

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgements

Inspired by [bjw-s/home-ops](https://github.com/bjw-s/home-ops), [geerlingguy/pi-cluster](https://github.com/geerlingguy/pi-cluster) and the [k8s-at-home](https://github.com/topics/k8s-at-home) community.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
