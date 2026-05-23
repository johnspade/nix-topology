{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.hydra.enable {
  name = "Hydra";
  icon = "devices.nixos";
  info = config.services.hydra.hydraURL;
  details.listen.text = "${config.services.hydra.listenHost}:${toString config.services.hydra.port}";
}
