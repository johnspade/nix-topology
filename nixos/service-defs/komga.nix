{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.komga.enable {
  name = "Komga";
  icon = "services.komga";
  details.listen = mkIf config.services.komga.openFirewall {
    text = "0.0.0.0:${toString config.services.komga.settings.server.port}";
  };
}
