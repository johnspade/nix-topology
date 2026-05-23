{ config, lib }:
let
  inherit (lib) mkIf;
  # TODO: remove old option when 26.11 releases
  cfg = config.services.seerr or config.services.jellyseerr;
in
mkIf cfg.enable {
  name = "Seerr";
  icon = "services.seerr";
  details.listen = mkIf cfg.openFirewall { text = "0.0.0.0:${toString cfg.port}"; };
}
