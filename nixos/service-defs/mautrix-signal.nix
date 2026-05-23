{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.mautrix-signal.settings.appservice.hostname or null;
  port = config.services.mautrix-signal.settings.appservice.port or null;
in
mkIf config.services.mautrix-signal.enable {
  name = "mautrix-signal";
  icon = "services.mautrix-signal";
  details.listen.text = mkIf (address != null && port != null) "${address}:${toString port}";
}
