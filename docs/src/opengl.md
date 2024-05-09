# OpenGL support

By default, OpenGL drivers are not available to programs in Geospatial NIX.env
environments. Geospatial NIX provides
[NixGL wrapper](https://github.com/nix-community/nixGL) which allows to run
OpenGL programs with correctly compiled Intel, AMD and Nouveau GPU drivers using
Mesa OpenGL implementation.


Add following line to the configuration to enable OpenGL support

```
nixgl.enable = true;
```

and run the program with `nixGLIntel` prefix

```
nixGLIntel <program>
```

For example
```
nixGLIntel qgis
```
