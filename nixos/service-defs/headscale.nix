{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.headscale.enable {
  name = "Headscale";
  icon = "services.headscale";
  info = config.services.headscale.settings.server_url;
  details.listen.text = "${config.services.headscale.address}:${toString config.services.headscale.port}";
}
