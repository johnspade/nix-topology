{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.mautrix-whatsapp.settings.appservice.hostname or null;
  port = config.services.mautrix-whatsapp.settings.appservice.port or null;
in
mkIf config.services.mautrix-whatsapp.enable {
  name = "mautrix-whatsapp";
  icon = "services.mautrix-whatsapp";
  details.listen.text = mkIf (address != null && port != null) "${address}:${toString port}";
}
