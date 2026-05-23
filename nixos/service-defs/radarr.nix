{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.radarr.enable {
  name = "Radarr";
  icon = "services.radarr";
  details.listen = mkIf config.services.radarr.openFirewall { text = "0.0.0.0:7878"; };
}
