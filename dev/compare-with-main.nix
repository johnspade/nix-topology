# The services in the topology for each service def's test configs, as evaluated
# with the nix-topology source `src`. compare-with-main.sh evaluates every case
# with main and with this branch, one process per side, and compares the results.
{
  pkgs,
  system ? builtins.currentSystem,
}:
let
  inherit (pkgs) lib;
  nixosSystem = import "${pkgs.path}/nixos/lib/eval-config.nix";
  serviceDefDir = ../nixos/service-defs;
  serviceFiles = lib.filterAttrs (
    n: t: t == "regular" && lib.hasSuffix ".nix" n && n != "default.nix"
  ) (builtins.readDir serviceDefDir);

  # Same test configs as service-def-tests.nix
  defCases = lib.concatMapAttrs (
    filename: _:
    let
      id = lib.removeSuffix ".nix" filename;
      def = import (serviceDefDir + "/${filename}") { inherit lib; };
      defaultConfig = lib.setAttrByPath (lib.splitString "." def.nixos.path) { enable = true; };
    in
    {
      "${id}" = def.test.config or defaultConfig;
      "${id}-minimal" = def.test.minimalConfig or defaultConfig;
    }
  ) serviceFiles;

  extraCases = {
    no-services = { };
    restic = {
      services.restic.backups.daily = {
        repository = "/backup";
        paths = [ "/home" ];
        passwordFile = "/dev/null";
      };
    };
  };

  cases = defCases // extraCases;

  servicesOf =
    src: case:
    let
      host = nixosSystem {
        inherit system;
        modules = [
          (src + "/nixos/module.nix")
          {
            networking.hostName = "test-host";
            fileSystems."/" = {
              device = "/dev/null";
              fsType = "ext4";
            };
            boot.loader.grub.device = "/dev/null";
          }
          cases.${case}
        ];
      };
      topology = import src {
        inherit pkgs;
        modules = [ { nixosConfigurations.test-host = host; } ];
      };
    in
    lib.mapAttrs (_: s: {
      inherit (s) name info hidden;
      icon = if s.icon == null then null else toString s.icon;
      details = lib.mapAttrs (_: d: d.text) s.details;
    }) topology.config.nodes.test-host.services;
in
{
  caseNames = lib.attrNames cases;
  inherit servicesOf;
}
