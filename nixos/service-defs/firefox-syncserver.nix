{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.firefox-syncserver.enable {
  name = "Firefox Syncserver";
  icon = "services.firefox-syncserver";
  info = mkIf config.services.firefox-syncserver.singleNode.enable config.services.firefox-syncserver.singleNode.url;
  details.listen.text = "${
    config.services.firefox-syncserversettings.host or "127.0.0.1"
  }:${toString config.services.firefox-syncserver.settings.port}";
}
