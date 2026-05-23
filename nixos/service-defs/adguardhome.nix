{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.adguardhome.host or null;
  port = config.services.adguardhome.port or null;
in
mkIf config.services.adguardhome.enable {
  name = "AdGuard Home";
  icon = "services.adguardhome";
  details.listen = mkIf (address != null && port != null) { text = "${address}:${toString port}"; };
}
