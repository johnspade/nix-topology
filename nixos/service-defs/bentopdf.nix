{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf (config.services.bentopdf.enable or false) {
  name = "BentoPDF";
  icon = "services.bentopdf";
  info = "https://${config.services.bentopdf.domain}";
}
