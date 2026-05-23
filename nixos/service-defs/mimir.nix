{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.mimir.configuration.server.http_listen_address or null;
  port = config.services.mimir.configuration.server.http_listen_port or null;
in
mkIf config.services.mimir.enable {
  name = "Mimir";
  icon = "services.mimir";
  details.listen = mkIf (address != null && port != null) { text = "${address}:${toString port}"; };
}
