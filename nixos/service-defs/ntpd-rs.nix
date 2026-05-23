{ config, lib }:
let
  inherit (lib)
    flip
    imap1
    listToAttrs
    mkIf
    ;
  ntpServers = config.services.ntpd-rs.settings.server or [ ];
in
mkIf (config.services.ntpd-rs.enable && ntpServers != [ ]) {
  name = "NTPd-rs";
  icon = "services.ntpd-rs";
  details = listToAttrs (
    flip imap1 ntpServers (
      i: server: {
        name = "server ${toString i} listen";
        value.text = server.listen;
      }
    )
  );
}
