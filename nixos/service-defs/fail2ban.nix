{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.fail2ban.enable {
  name = "Fail2Ban";
  icon = "services.fail2ban";
}
