{ config, lib }:
let
  inherit (lib)
    listToAttrs
    mapAttrsToList
    mkIf
    optionalAttrs
    pipe
    ;
in
mkIf config.services.jellyfin.enable {
  name = "Jellyfin";
  icon = "services.jellyfin";
  details =
    pipe
      {
        http = 8096;
        https = 8920;
        service-discovery = 1900;
        client-discovery = 7359;
      }
      [
        (optionalAttrs config.services.jellyfin.openFirewall)
        (mapAttrsToList (
          n: v: {
            name = "listen.${n}";
            value.text = "0.0.0.0:${toString v}";
          }
        ))
        listToAttrs
      ];
}
