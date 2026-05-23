{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.searx.settings.server.bind_address or null;
  port = config.services.searx.settings.server.port or null;
in
mkIf config.services.searx.enable {
  name = "SearXNG";
  icon = "services.searxng";
  details.listen = lib.mkIf (address != null && port != null) {
    text = "${address}:${toString port}";
  };
}
