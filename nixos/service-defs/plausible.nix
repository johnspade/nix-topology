{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.plausible.enable {
  name = "Plausible";
  icon = "services.plausible";
  info = config.services.plausible.server.baseUrl;
  details.listen.text = "${config.services.plausible.server.listenAddress}:${toString config.services.plausible.server.port}";
}
