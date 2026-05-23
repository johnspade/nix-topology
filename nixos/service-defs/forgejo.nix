{ config, lib }:
let
  inherit (lib) mkIf;
  inherit (config.services.forgejo.settings.server) HTTP_ADDR HTTP_PORT ROOT_URL;
in
mkIf config.services.forgejo.enable {
  name =
    if config.services.forgejo.settings ? DEFAULT.APP_NAME then
      "Forgejo (${config.services.forgejo.settings.DEFAULT.APP_NAME})"
    else
      "Forgejo";
  icon = "services.forgejo";
  info = ROOT_URL;
  details.listen.text = "${HTTP_ADDR}:${toString HTTP_PORT}";
}
