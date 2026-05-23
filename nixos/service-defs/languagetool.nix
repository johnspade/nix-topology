{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.languagetool.enable {
  name = "Languagetool";
  icon = "services.languagetool";
  details.listen.text = "127.0.0.1:${toString config.services.languagetool.port}";
}
