{ config, lib }:
let
  serviceFiles = lib.filterAttrs (
    n: t: t == "regular" && lib.hasSuffix ".nix" n && n != "default.nix"
  ) (builtins.readDir ./.);
in
lib.mapAttrs' (filename: _: {
  name = lib.removeSuffix ".nix" filename;
  value = import ./${filename} { inherit config lib; };
}) serviceFiles
