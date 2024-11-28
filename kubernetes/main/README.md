# 'main' cluster

<!--include-start-->
This cluster consists of three i5 Minisforum MS-01 nodes.

## folders

- `/apps`: applications deployed the cluster
- `/flux`: flux configuration
- `/core`: core cluster components that `apps` depend upon (controllers, etc)
- `/talos`: talos configuration and bootstrapping

## bootstrapping

Once nodes are up and running with Talos, run `bootstrap.sh` in the cluster's root directory to bootstrap the cluster with flux.
<!--include-end-->
