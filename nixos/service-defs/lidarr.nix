{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.lidarr.enable {
  name = "Lidarr";
  icon = "services.lidarr";
  details.listen = mkIf config.services.lidarr.openFirewall { text = "0.0.0.0:8686"; };
}
