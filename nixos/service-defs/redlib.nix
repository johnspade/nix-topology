{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.redlib.enable {
  name = "Redlib";
  icon = "services.redlib";
  details.listen = mkIf config.services.redlib.openFirewall {
    text = "${config.services.redlib.address}:${toString config.services.redlib.port}";
  };
}
