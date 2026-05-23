{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.alloy.enable {
  name = "Alloy";
  icon = "services.alloy";
}
