{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.prowlarr.enable {
  name = "Prowlarr";
  icon = "services.prowlarr";
  details.listen = mkIf config.services.prowlarr.openFirewall { text = "0.0.0.0:9696"; };
}
