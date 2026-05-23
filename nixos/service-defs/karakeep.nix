{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.karakeep.enable {
  name = "Karakeep";
  icon = "services.karakeep";
}
