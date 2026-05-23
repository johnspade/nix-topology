{ config, lib }:
let
  inherit (lib) mkIf;
in
# TODO: Remove old options when 26.11 is released
mkIf (config.services.kanidm.server.enable or config.services.kanidm.enableServer) {
  name = "Kanidm";
  icon = "services.kanidm";
  info =
    config.services.kanidm.server.settings.origin or config.services.kanidm.serverSettings.origin;
  details.listen.text =
    config.services.kanidm.server.settings.bindaddress
      or config.services.kanidm.serverSettings.bindaddress;
}
