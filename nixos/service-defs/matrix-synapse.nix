{ config, lib }:
let
  inherit (lib) mkIf;
  address = config.services.matrix-synapse.settings.public_baseurl;
  listener = builtins.head config.services.matrix-synapse.settings.listeners;
in
mkIf config.services.matrix-synapse.enable {
  name = "Matrix (Synapse)";
  icon = "services.matrix";
  info = mkIf (address != null) address;
  details.listen.text = mkIf (
    listener != null
  ) "${builtins.head listener.bind_addresses}:${toString listener.port}";
}
