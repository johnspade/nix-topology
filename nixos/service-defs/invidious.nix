{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.invidious.enable {
  name = "Invidious";
  icon = "services.invidious";
  details.listen.text = "${config.services.invidious.address}:${toString config.services.invidious.port}";
}
