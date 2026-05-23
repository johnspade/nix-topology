{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.navidrome.enable {
  name = "Navidrome";
  icon = "services.navidrome";
  info = mkIf (
    config.services.navidrome.settings ? BaseUrl
  ) config.services.navidrome.settings.BaseUrl;
  details.listen = mkIf config.services.navidrome.openFirewall {
    text = "${config.services.navidrome.settings.Address}:${toString config.services.navidrome.settings.Port}";
  };
}
