{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.mastodon.enable {
  name = "Mastodon";
  icon = "services.mastodon";
  info = "https://${config.services.mastodon.localDomain}";
}
