{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf
  (config.services.harmonia.cache.enable or config.services.harmonia-dev.cache.enable
    or config.services.harmonia.enable or false
  )
  {
    name = "Harmonia";
    icon = "services.not-available";
  }
