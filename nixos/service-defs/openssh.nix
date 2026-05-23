{ config, lib }:
let
  inherit (lib) concatStringsSep mkDefault mkIf;
in
mkIf config.services.openssh.enable {
  hidden = mkDefault true; # Causes a lot of clutter
  name = "OpenSSH";
  icon = "services.openssh";
  info = "port: ${concatStringsSep ", " (map toString config.services.openssh.ports)}";
}
