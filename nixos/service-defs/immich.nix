{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.immich.enable {
  name = "Immich";
  icon = "services.immich";
  details.listen = mkIf config.services.immich.openFirewall {
    text = "${config.services.immich.host}:${toString config.services.immich.port}";
  };
}
