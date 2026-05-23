{ config, lib }:
let
  inherit (lib) mkIf;
  inherit (config.services.transmission.settings) rpc-bind-address rpc-port;
in
mkIf config.services.transmission.enable {
  name = "Transmission";
  icon = "services.transmission";
  details.listen.text = "${rpc-bind-address}:${toString rpc-port}";
}
