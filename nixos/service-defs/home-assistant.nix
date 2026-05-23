{ config, lib }:
let
  inherit (lib) mkIf pipe;
in
mkIf config.services.home-assistant.enable {
  name = "Home Assistant";
  icon = "services.home-assistant";
  details.listen.text = pipe config.services.home-assistant.config.http.server_host [
    (map (addr: "${addr}:${toString config.services.home-assistant.config.http.server_port}"))
    toString
  ];
}
