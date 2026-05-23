{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.zipline.enable {
  name = "Zipline";
  icon = "services.zipline";
  details.listen.text = "${config.services.zipline.settings.CORE_HOSTNAME}:${toString config.services.zipline.settings.CORE_PORT}";
}
