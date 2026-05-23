{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.sonarr.enable {
  name = "Sonarr";
  icon = "services.sonarr";
  details.listen = mkIf config.services.sonarr.openFirewall { text = "0.0.0.0:8989"; };
}
