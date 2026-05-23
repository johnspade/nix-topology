{ config, lib }:
let
  inherit (lib) mkIf;
  inherit (config.services.paperless.settings) domain;
in
mkIf config.services.paperless.enable {
  name = "Paperless-ngx";
  icon = "services.paperless-ngx";
  info = mkIf (domain != null) "https://${domain}";
  details.listen.text = "${config.services.paperless.address}:${toString config.services.paperless.port}";
}
