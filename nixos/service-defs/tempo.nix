{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.tempo.settings.server.http_listen_address or null;
  port = config.services.tempo.settings.server.http_listen_port or null;
in
mkIf config.services.tempo.enable {
  name = "Tempo";
  icon = "services.tempo";
  details.listen = mkIf (address != null && port != null) { text = "${address}:${port}"; };
}
