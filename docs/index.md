# ⚒️ Intro

## Setup

This repository uses [mise](https://mise.jdx.dev/) to configure a self-contained development environment with all the required tools.

Requires [homebrew](https://brew.sh/), [Brew-file](https://github.com/rcmdnk/homebrew-file) and Visual Studio Code to be installed.

1. Run `brew file install --file .github/Brewfile` to install `mise` and `go-task` if you don't have them already.
2. Run `task repo:setup` to set up the development environment. This can also be run again to update.

## ☁️ Cloud Dependencies

The homelab depends on a few cloud services to provide essential functionality.

| Service                                              | Purpose               |
| ---------------------------------------------------- | --------------------- |
| [Doppler](https://doppler.com/)                      | Secret management     |
| [GitHub Actions](https://docs.github.com/en/actions) | CI/CD workflows       |
| [Cloudflare](https://cloudflare.com)                 | DNS and web tunneling |
| [Playit](https://playit.gg)                          | TCP/UDP tunneling     |
| [ProtonMail](https://mail.proton.me)                 | Email                 |
