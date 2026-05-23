{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.kavita.enable {
  name = "Kavita";
  icon = "services.kavita";
  details.listen.text = "0.0.0.0:${toString config.services.kavita.settings.Port}";
}
