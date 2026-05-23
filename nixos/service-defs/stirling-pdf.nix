{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.stirling-pdf.environment.SERVER_HOST or null;
  port = config.services.stirling-pdf.environment.SERVER_PORT or null;
in
mkIf config.services.stirling-pdf.enable {
  name = "Stirling-PDF";
  icon = "services.stirling-pdf";
  details.listen = mkIf (address != null && port != null) { text = "${address}:${toString port}"; };
}
