{ config, lib }:
let
  inherit (lib)
    forEach
    head
    listToAttrs
    mkIf
    removePrefix
    splitString
    tail
    ;
in
mkIf config.services.dnsmasq.enable {
  name = "Dnsmasq";
  icon = "services.dnsmasq";
  details =
    let
      addresses = config.services.dnsmasq.settings.address or [ ];
    in
    listToAttrs (
      forEach (forEach addresses (x: (splitString "/" (removePrefix "/" x)))) (x: {
        name = head x;
        value.text = head (tail x);
      })
    );
}
