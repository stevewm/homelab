# Specifications

## Nodes

This cluster is a single-node cluster using a Minisforum MS-01 i5 with:

- 96GB RAM
- 256GB NVMe SSD (boot)
- 2TB NVMe SSD (data)

## Folder Structure

The cluster's folder structure is:

- `/.archive`: applications no longer deployed but preserved for future use by myself (or others via kubesearch)
- `/.bootstrap`: cluster bootstrapping resources
- `/apps`: applications deployed the cluster
- `/core`: core cluster components that `apps` depend upon (storage, operators, etc)
- `/flux`: flux configuration and components
- `/talos`: talos configuration
