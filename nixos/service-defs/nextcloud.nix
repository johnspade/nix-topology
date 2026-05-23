{ config, lib }:
let
  inherit (lib) mkIf optionalString;
in
mkIf config.services.nextcloud.enable {
  name = "Nextcloud";
  icon = "services.nextcloud";
  info = "http${optionalString config.services.nextcloud.https "s"}://${config.services.nextcloud.hostName}";
}
