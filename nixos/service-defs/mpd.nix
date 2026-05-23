{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.mpd.enable {
  name = "MPD";
  icon = "services.mpd";
  details.listen.text = "${
    if (config.services.mpd.settings.bind_to_address == "any") then
      "0.0.0.0"
    else
      config.services.mpd.settings.bind_to_address
  }:${toString config.services.mpd.settings.port}";
}
