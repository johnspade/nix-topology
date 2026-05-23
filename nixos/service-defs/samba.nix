{ config, lib }:
let
  inherit (lib) attrNames concatLines mkIf;
in
mkIf config.services.samba.enable {
  name = "Samba";
  icon = "services.samba";
  details.shares =
    let
      shares = lib.remove "global" (attrNames config.services.samba.settings);
    in
    mkIf (shares != [ ]) { text = concatLines shares; };
}
