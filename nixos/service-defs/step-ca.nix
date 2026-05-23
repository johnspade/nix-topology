{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.step-ca.enable {
  name = "step-ca";
  icon = "services.step-ca";
  details.listen = mkIf config.services.step-ca.openFirewall {
    text = "${config.services.step-ca.address}:${toString config.services.step-ca.port}";
  };
}
