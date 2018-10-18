# Bosh in a Box (Container)

Build yourself a Bosh in a Box, gives you `bosh` and `bbl` cli tools inside a basic Ubuntu system.

# Latest and greatest, ignoring SHA validation

```bash
docker build .
```

# Verify binary sha and set version

```bash
docker build --build-arg CHECK_SHA=true --build-arg CHECK_SHA=true --build-arg BBL_SHA=adeccd88a9d3ac370983c8aea20f989bdca8c53c2aa08521c1ed8c5b2a3b0ad0 --build-arg BOSH_SHA=5017ea3be52a71c9c35ee015904f1e91f77cddc4a32f011e042cf4cdf33f7278 --build-arg BBL_VERSION=latest --build-arg BOSH_VERSION=v5.3.1 --build-arg BBL_VERSION=v6.10.18 .
```