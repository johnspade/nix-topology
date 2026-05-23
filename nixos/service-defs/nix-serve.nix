{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.nix-serve.enable {
  name = "Nix Serve";
  icon = "devices.nixos";
  details.listen.text = "${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
}
