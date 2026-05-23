{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.tabby.enable {
  name = "Tabby";
  icon = "services.tabby";
  details.listen.text = "${config.services.tabby.host}:${toString config.services.tabby.port}";
}
