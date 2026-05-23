{ config, lib }:
let
  inherit (lib)
    filterAttrs
    listToAttrs
    mapAttrsToList
    mkIf
    pipe
    ;
  instances = filterAttrs (_: v: v.enable) config.services.authelia.instances;
in
mkIf (instances != { }) {
  name = "Authelia";
  icon = "services.authelia";
  details = pipe instances [
    (mapAttrsToList (
      name: v: {
        inherit name;
        value.text = "${lib.strings.removeSuffix "/" (
          lib.strings.removePrefix "tcp://" v.settings.server.address
        )}";
      }
    ))
    listToAttrs
  ];
}
