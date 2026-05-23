{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.anki-sync-server.enable {
  name = "Anki";
  icon = "services.anki";
  details.listen = mkIf config.services.anki-sync-server.openFirewall {
    text = "${config.services.anki-sync-server.address}:${toString config.services.anki-sync-server.port}";
  };
}
