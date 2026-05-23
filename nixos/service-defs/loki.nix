{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.loki.configuration.server.http_listen_address or null;
  port = config.services.loki.configuration.server.http_listen_port or null;
in
mkIf config.services.loki.enable {
  name = "Loki";
  icon = "services.loki";
  details.listen = mkIf (address != null && port != null) { text = "${address}:${toString port}"; };
}
