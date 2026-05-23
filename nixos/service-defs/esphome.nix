{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.esphome.enable {
  name = "ESPHome";
  icon = "services.esphome";
  details.listen.text =
    if config.services.esphome.enableUnixSocket then
      "/run/esphome/esphome.sock"
    else
      "${config.services.esphome.address}:${toString config.services.esphome.port}";
}
