{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.libretranslate.enable {
  name = "Libretranslate";
  icon = "services.libretranslate";
  details.listen.text = "${config.services.libretranslate.host}:${toString config.services.libretranslate.port}";
}
