# 'mini' cluster

This cluster consists of four miniPCs from Dell and HP. Each PC has the same specification:

- **CPU**: Intel i5 7500T
- **RAM**: 32GB DDR4
- **SSD**: 240GB M.2 (talos)
- **SSD**: 1TB SATA (data)

## folders

- `/apps`: applications deployed the cluster
- `/flux`: flux configuration
- `/infrastructure`: cluster infrastructure that apps depend upon (controllers, etc)
- `/talos`: talos configuration and bootstrapping

## bootstrapping

Once nodes are up and running with Talos, run `bootstrap.sh` in the cluster's root directory to bootstrap the cluster with flux.
