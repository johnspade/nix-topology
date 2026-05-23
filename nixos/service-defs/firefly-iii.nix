{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.firefly-iii.settings.APP_URL or null;
in
mkIf config.services.firefly-iii.enable {
  name = "Firefly III";
  icon = "services.firefly-iii";
  info = mkIf (address != null) address;
}
