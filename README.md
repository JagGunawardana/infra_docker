# infrastructure docker

Useful container image to build infrastructure on GCP e.g. Kubernetes Clusters.

Has binaries for:

- Google cloud SDK
- Kubernetes
- Terraform

# Build

Controlled by a good old fashioned Makefile. It builds the Docker, and pushes to a registry.

```
make REGISTRY=reg_name
```

# TODO

Could be useful to add Helm to this bundle.
