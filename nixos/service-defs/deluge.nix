{ config, lib }:
let
  inherit (lib) mkIf;
  daemonPort = config.services.deluge.config.daemon_port or 58846;
  webPort = config.services.deluge.web.port or null;
in
mkIf config.services.deluge.enable {
  name = "Deluge";
  icon = "services.deluge";
  details = {
    listen.text = "0.0.0.0:${toString daemonPort}";
    webUI = mkIf (config.services.deluge.web.enable && webPort != null) {
      text = "0.0.0.0:${toString webPort}";
    };
  };
}
