{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.radicale.enable {
  name = "Radicale";
  icon = "services.radicale";
  details.listen = mkIf (config.services.radicale.settings ? server.hosts) {
    text = toString config.services.radicale.settings.server.hosts;
  };
}
