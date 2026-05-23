{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.vikunja.enable {
  name = "Vikunja";
  icon = "services.vikunja";
  info = "${config.services.vikunja.frontendScheme}://${config.services.vikunja.frontendHostname}";
  details.listen = mkIf (config.services.vikunja ? address) {
    text = "${config.services.vikunja.address}:${toString config.services.vikunja.port}";
  };
}
