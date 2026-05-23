{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.prometheus.enable {
  name = "Prometheus";
  icon = "services.prometheus";
  details.listen.text = "${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
}
