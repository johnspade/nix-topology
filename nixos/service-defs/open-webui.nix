{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.open-webui.enable {
  name = "Open Webui";
  icon = "services.open-webui";
  details.listen = mkIf config.services.open-webui.openFirewall {
    text = "${config.services.open-webui.host}:${toString config.services.open-webui.port}";
  };
}
