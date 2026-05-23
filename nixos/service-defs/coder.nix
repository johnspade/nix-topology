{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.coder.enable {
  name = "Coder";
  icon = "services.coder";
  info = config.services.coder.accessUrl;
  details.listen.text = config.services.coder.listenAddress;
}
