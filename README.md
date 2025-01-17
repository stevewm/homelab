# Homelab

Welcome to the repository for my home infrastructure, otherwise known as my homelab.

![Kubernetes Version](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fstevewm%2Fhomelab%2Fmain%2Fkubernetes%2Fmain%2Ftalos%2Ftalconfig.yaml&query=%24.kubernetesVersion&style=for-the-badge&logo=kubernetes&label=K8S)
![Talos Version](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fstevewm%2Fhomelab%2Fmain%2Fkubernetes%2Fmain%2Ftalos%2Ftalconfig.yaml&query=%24.talosVersion&style=for-the-badge&logo=talos&label=talos&color=%23FA640A&link=https%3A%2F%2Ftalos.dev%2F)

![Nodes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkg.cfg.sh%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_node_count&style=for-the-badge&logo=kubernetes&label=Nodes)
![Pods](https://img.shields.io/endpoint?url=https%3A%2F%2Fkg.cfg.sh%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_pod_count&style=for-the-badge&logo=talos&label=Pods)
![CPU Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkg.cfg.sh%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_cpu_usage&style=for-the-badge&logo=kubernetes&label=CPU)
![Memory Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkg.cfg.sh%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_memory_usage&style=for-the-badge&logo=kubernetes&label=Memory)
![Cluster Age](https://img.shields.io/endpoint?url=https%3A%2F%2Fkg.cfg.sh%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_age_days&style=for-the-badge&logo=kubernetes&label=Age)
![Uptime](https://img.shields.io/endpoint?url=https%3A%2F%2Fkg.cfg.sh%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_uptime_days&style=for-the-badge&logo=kubernetes&label=Uptime)

## 📚 Docs

Documentation can be found [here](https://stevewm.github.io/homelab/).

## 🛠️ Built With

| Name                                                            | Purpose                                  |
| --------------------------------------------------------------- | ---------------------------------------- |
| [Talos](https://www.talos.dev/)                                 | Kubernetes distribution                  |
| [FluxCD](https://fluxcd.io/)                                    | GitOps                                   |
| [Renovate](https://github.com/renovatebot/renovate)             | Automated dependency upgrades            |
| [GitHub Actions](https://docs.github.com/en/actions)            | Automation                               |
| [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) | Documentation                            |
| [direnv](https://direnv.net/)                                   | Directory-specific environment variables |
| [Doppler](https://www.doppler.com/)                             | Secrets management                       |
| [pre-commit](https://pre-commit.com/)                           | Linting and validation                   |
| [go-task](https://github.com/go-task/task)                      | Task runner                              |

## 🤝 Acknowledgements

Inspired by [bjw-s/home-ops](https://github.com/bjw-s-labs/home-ops), [geerlingguy/pi-cluster](https://github.com/geerlingguy/pi-cluster) and the [k8s-at-home](https://github.com/topics/k8s-at-home) community.
