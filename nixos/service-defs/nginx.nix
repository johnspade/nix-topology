{ config, lib }:
let
  inherit (lib)
    attrNames
    flatten
    flip
    mapAttrsToList
    mkIf
    mkMerge
    optional
    replaceStrings
    ;
in
mkIf config.services.nginx.enable {
  name = "NGINX";
  icon = "services.nginx";
  details =
    let
      reverseProxies = flatten (
        flip mapAttrsToList config.services.nginx.virtualHosts (
          server: vh:
          flip mapAttrsToList vh.locations (
            path: location:
            let
              upstreamName = replaceStrings [ "http://" "https://" ] [ "" "" ] location.proxyPass;
              passTo =
                if config.services.nginx.upstreams ? ${upstreamName} then
                  toString (attrNames config.services.nginx.upstreams.${upstreamName}.servers)
                else
                  location.proxyPass;
            in
            optional (path == "/" && location.proxyPass != null) { ${server}.text = passTo; }
          )
        )
      );
    in
    mkMerge reverseProxies;
}
