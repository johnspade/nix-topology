{ config, lib }:
let
  inherit (lib) mkIf;
  domain =
    config.services.vaultwarden.config.domain or config.services.vaultwarden.config.DOMAIN or null;
  address =
    config.services.vaultwarden.config.rocketAddress
      or config.services.vaultwarden.config.ROCKET_ADDRESS or null;
  port =
    config.services.vaultwarden.config.rocketPort or config.services.vaultwarden.config.ROCKET_PORT
      or null;
in
mkIf config.services.vaultwarden.enable {
  name = "Vaultwarden";
  icon = "services.vaultwarden";
  info = mkIf (domain != null) domain;
  details.listen = mkIf (address != null && port != null) { text = "${address}:${toString port}"; };
}
