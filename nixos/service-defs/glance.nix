{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.glance.enable {
  name = "Glance";
  icon = "services.glance";
  details.listen = mkIf config.services.glance.openFirewall {
    text = "${config.services.glance.settings.server.host}:${toString config.services.glance.settings.server.port}";
  };
}
