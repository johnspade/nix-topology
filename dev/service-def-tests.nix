{
  self,
  pkgs,
  system,
}:
let
  inherit (pkgs) lib;
  nixosSystem = import "${pkgs.path}/nixos/lib/eval-config.nix";
  serviceDefDir = ../nixos/service-defs;
  serviceFiles = lib.filterAttrs (
    n: t: t == "regular" && lib.hasSuffix ".nix" n && n != "default.nix"
  ) (builtins.readDir serviceDefDir);

  baseEval = nixosSystem {
    inherit system;
    modules = [ self.nixosModules.topology ];
  };

  optionExists = path: lib.hasAttrByPath path baseEval.options;

  mkServiceTest =
    serviceName:
    let
      serviceDef = import (serviceDefDir + "/${serviceName}.nix") { inherit lib; };
      testSpec = serviceDef.test or { };
      optionPath = serviceDef.nixos.path or [ ];

      defaultConfig = lib.setAttrByPath optionPath { enable = true; };
      serviceConfig = testSpec.config or defaultConfig;

      eval = nixosSystem {
        inherit system;
        modules = [
          self.nixosModules.topology
          {
            networking.hostName = "test-${serviceName}";
            fileSystems."/" = {
              device = "/dev/null";
              fsType = "ext4";
            };
            boot.loader.grub.device = "/dev/null";
          }
          serviceConfig
        ];
      };

      inherit (eval.config.topology.self) services;
      forced = builtins.deepSeq services services;

      assertions = if testSpec ? assertions then testSpec.assertions forced else [ ];
      failedAssertions = builtins.filter (a: !a.assertion) assertions;
      failureMessages = map (a: a.message) failedAssertions;
    in
    if !optionExists optionPath then
      pkgs.runCommandLocal "service-def-test-${serviceName}-skipped" { } ''
        echo "skipped (option not available on this nixpkgs)" > $out
      ''
    else if failedAssertions != [ ] then
      throw "Service def test '${serviceName}' failed:\n${lib.concatStringsSep "\n" failureMessages}"
    else
      pkgs.runCommandLocal "service-def-test-${serviceName}" { } ''
        echo "ok" > $out
      '';
in
lib.mapAttrs' (filename: _: {
  name = "service-def-${lib.removeSuffix ".nix" filename}";
  value = mkServiceTest (lib.removeSuffix ".nix" filename);
}) serviceFiles
