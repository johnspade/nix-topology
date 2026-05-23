{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.static-web-server.enable {
  name = "Static Web Server";
  icon = "devices.nixos";
  details = {
    listen.text = toString config.services.static-web-server.listen;
    root.text = toString config.services.static-web-server.root;
  };
}
