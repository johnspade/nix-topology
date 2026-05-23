{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.mautrix-telegram.settings.appservice.hostname or null;
  port = config.services.mautrix-telegram.settings.appservice.port or null;
in
mkIf config.services.mautrix-telegram.enable {
  name = "mautrix-telegram";
  icon = "services.mautrix-telegram";
  details.listen.text = mkIf (address != null && port != null) "${address}:${toString port}";
}
