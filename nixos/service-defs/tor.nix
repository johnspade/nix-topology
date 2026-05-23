{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.tor.enable {
  name = "Tor";
  icon = "services.tor";
  info = mkIf config.services.tor.relay.enable "Role: ${config.services.tor.relay.role}";
}
