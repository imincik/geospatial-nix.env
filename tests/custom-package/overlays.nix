{
  custom = final: prev: {
    gdal = prev.gdal.overrideAttrs (
      old: {
        version = "1000.0.0";
        postPatch = ''
          sed -i "s|Usage:|Usage (patched):|" apps/argparse/argparse.hpp
        '';
        doInstallCheck = false;
      }
    );
  };
}
