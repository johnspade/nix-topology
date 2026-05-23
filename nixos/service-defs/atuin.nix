{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.atuin.enable {
  name = "Atuin";
  icon = "services.atuin";
  details.listen = mkIf config.services.atuin.openFirewall {
    text = "${config.services.atuin.host}:${toString config.services.atuin.port}";
  };
}
