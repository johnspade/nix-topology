{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.postgresql.enable {
  name = "PostgreSQL";
  icon = "services.postgresql";
  details.listen = mkIf config.services.postgresql.enableTCPIP {
    text = "0.0.0.0:${toString config.services.postgresql.settings.port}";
  };
}
