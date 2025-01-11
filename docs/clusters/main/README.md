# Intro

This cluster consists of three Minisforum MS-01 nodes with:

- i5-12900H
- 96GB RAM
- 1TB NVMe SSD (boot disk)
- 3.92TB U.2 SSD (data disk)

## Folder Structure

The cluster's folder structure is:

- `/.archive`: Applications no longer deployed but preserved for future use by myself (or others via kubesearch)
- `/apps`: applications deployed the cluster
- `/core`: core cluster components that `apps` depend upon (controllers, etc)
- `/flux`: flux configuration
- `/templates`: Reusable templates for the cluster (eg VolSync)
- `/talos`: talos configuration and bootstrapping
