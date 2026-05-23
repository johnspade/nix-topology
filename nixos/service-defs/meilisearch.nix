{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.meilisearch.enable {
  name = "Meilisearch";
  icon = "services.meilisearch";
  details.listen.text = "${config.services.meilisearch.listenAddress}:${toString config.services.meilisearch.listenPort}";
}
