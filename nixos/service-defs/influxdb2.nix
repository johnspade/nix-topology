{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.influxdb2.enable {
  name = "InfluxDB v2";
  icon = "services.influxdb2";
  details.listen.text = config.services.influxdb2.settings.http-bind-address or "localhost:8086";
}
