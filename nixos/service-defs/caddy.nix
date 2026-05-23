{ config, lib }:
let
  inherit (lib)
    concatStringsSep
    filter
    genAttrs
    hasPrefix
    mapAttrsToList
    mkIf
    pipe
    removePrefix
    removeSuffix
    splitString
    ;
in
mkIf config.services.caddy.enable {
  name = "Caddy";
  icon = "services.caddy";
  details = genAttrs (mapAttrsToList (name: _: name) config.services.caddy.virtualHosts) (name: {
    text = pipe config.services.caddy.virtualHosts.${name}.extraConfig [
      # Separate lines of string into list
      (splitString "\n")
      # Filter out lines that don't start with reverse_proxy
      (filter (line: hasPrefix "reverse_proxy " line))
      # Remove the prefix and suffix, so only the list of hosts are left
      (map (line: removePrefix "reverse_proxy " (removeSuffix " {" line)))
      # Turn the (possibly multiple) strings in the list into a single string
      (concatStringsSep " ")
    ];
  });
}
