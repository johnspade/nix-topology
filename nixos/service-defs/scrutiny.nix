{ config, lib }:
let
  inherit (lib) mkIf;
  inherit (config.services.scrutiny.settings) web;
in
mkIf config.services.scrutiny.enable {
  name = "Scrutiny";
  icon = "services.scrutiny";
  details.listen = lib.mkIf config.services.scrutiny.openFirewall {
    text = "${web.listen.host}:${toString web.listen.port}";
  };
}
