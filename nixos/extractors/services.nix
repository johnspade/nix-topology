{ config, lib, ... }:
let
  inherit (lib)
    flip
    mapAttrs
    mkEnableOption
    mkIf
    ;

  serviceDefs = import ../service-defs { inherit config lib; };

  resticBackupServices = flip mapAttrs config.services.restic.backups (
    backupName: cfg: {
      name = "Restic backup '${backupName}'";
      icon = "services.restic";
      info = mkIf (cfg.repository != null) cfg.repository;
      details.paths.text = toString cfg.paths;
    }
  );
in
{
  options.topology.extractors.services.enable = mkEnableOption "topology service extractor" // {
    default = true;
  };

  config.topology.self.services = mkIf config.topology.extractors.services.enable (
    serviceDefs // resticBackupServices
  );
}
