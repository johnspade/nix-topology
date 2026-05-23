{ config, lib }:
let
  inherit (lib) mkIf;
  mqttServer = config.services.zigbee2mqtt.settings.mqtt.server or null;
  address = config.services.zigbee2mqtt.settings.frontend.host or null;
  port = config.services.zigbee2mqtt.settings.frontend.port or null;
  listen =
    if address == null then
      null
    else if port == null then
      address
    else
      "${address}:${toString port}";
in
mkIf config.services.zigbee2mqtt.enable {
  name = "Zigbee2MQTT";
  icon = "services.zigbee2mqtt";
  details = {
    listen = mkIf (listen != null) { text = listen; };
    mqtt = mkIf (mqttServer != null) { text = mqttServer; };
  };
}
