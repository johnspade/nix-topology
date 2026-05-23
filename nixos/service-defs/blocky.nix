{ config, lib }:
let
  inherit (lib)
    listToAttrs
    mapAttrsToList
    mkIf
    pipe
    ;
in
mkIf config.services.blocky.enable {
  name = "Blocky";
  icon = "services.blocky";
  details = pipe config.services.blocky.settings.ports [
    (mapAttrsToList (
      n: v: {
        name = "listen.${n}";
        value.text = toString v;
      }
    ))
    listToAttrs
  ];
}
