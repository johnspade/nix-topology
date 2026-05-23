{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.code-server.enable {
  name = "Code Server";
  icon = "services.code-server";
  details.listen.text = "${config.services.code-server.host}:${toString config.services.code-server.port}";
}
