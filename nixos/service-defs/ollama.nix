{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.ollama.enable {
  name = "Ollama";
  icon = "services.ollama";
  details.listen = mkIf config.services.ollama.openFirewall {
    text = "${config.services.ollama.host}:${toString config.services.ollama.port}";
  };
}
