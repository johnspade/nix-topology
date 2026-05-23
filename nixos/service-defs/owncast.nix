{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.owncast.enable {
  name = "Owncast";
  icon = "services.owncast";
  details.listen = mkIf config.services.owncast.openFirewall {
    text = "${config.services.owncast.listen}:${toString config.services.owncast.port}";
  };
}
