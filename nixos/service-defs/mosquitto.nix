{ config, lib }:
let
  inherit (lib)
    forEach
    imap0
    listToAttrs
    mkIf
    pipe
    ;
  listeners = forEach config.services.mosquitto.listeners (l: rec {
    address = l.address or "[::]";
    listen = if l.port == 0 then address else "${address}:${toString l.port}";
  });
in
mkIf config.services.mosquitto.enable {
  name = "Mosquitto";
  icon = "services.mosquitto";
  details = pipe listeners [
    (imap0 (
      i: l: {
        name = "listen[${toString i}]";
        value.text = l.listen;
      }
    ))
    listToAttrs
  ];
}
