{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.oauth2-proxy.enable {
  name = "OAuth2 Proxy";
  icon = "services.oauth2-proxy";
  info = config.services.oauth2-proxy.httpAddress;
}
