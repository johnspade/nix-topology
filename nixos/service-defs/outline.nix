{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.outline.enable {
  name = "Outline";
  icon = "services.outline";
  details.listen.text = "${config.services.outline.publicUrl}";
}
