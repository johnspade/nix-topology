{ config, lib }:
let
  inherit (lib)
    attrNames
    flip
    head
    mapAttrsToList
    mkIf
    mkMerge
    ;
  dynCfg = config.services.traefik.dynamicConfigOptions;
in
mkIf config.services.traefik.enable {
  name = "Traefik";
  icon = "services.traefik";
  details = mkIf ((attrNames dynCfg) != [ ]) (
    let
      formatOutput = flip mapAttrsToList dynCfg.http.routers (
        routerName: routerAttrs:
        let
          getServiceUrl =
            serviceName:
            let
              service = dynCfg.http.services.${toString serviceName}.loadBalancer.servers or [ ];
            in
            if service != [ ] then (head service).url else "invalid service";
          passText = toString (getServiceUrl routerAttrs.service);
        in
        {
          ${toString routerName}.text = passText;
        }
      );
    in
    mkMerge formatOutput
  );
}
