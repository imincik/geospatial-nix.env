# Developer documentation

## How to release
* Checkout to a latest `master` branch version
```bash
git checkout master
git pull
```

* Create a version tag in `master` branch
```bash
VERSION="<VERSION>"
git tag -a "$VERSION" -m "Version $VERSION"
```

* Create a latest tag in `master` branch
```bash
git tag -f -a "latest" -m "Latest released version"
```

* Push tags
```bash
git push origin "$VERSION"
git push -f origin latest
```
