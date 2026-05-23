{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.mealie.enable {
  name = "Mealie";
  icon = "services.mealie";
  details.listen.text = "${config.services.mealie.listenAddress}:${toString config.services.mealie.port}";
}
