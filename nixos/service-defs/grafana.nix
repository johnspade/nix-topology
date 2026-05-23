{ config, lib }:
let
  inherit (lib) concatLines mkIf;
  inherit (config.services.grafana.settings.server) http_addr http_port root_url;
  plugins = config.services.grafana.declarativePlugins;
in
mkIf config.services.grafana.enable {
  name = "Grafana";
  icon = "services.grafana";
  info = root_url;
  details = {
    listen.text = "${http_addr}:${toString http_port}";
    plugins = mkIf (plugins != null) { text = concatLines (map (p: p.name) plugins); };
  };
}
