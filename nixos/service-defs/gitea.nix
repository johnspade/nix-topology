{ config, lib }:
let
  inherit (lib) mkIf;
  inherit (config.services.gitea.settings.server) HTTP_ADDR HTTP_PORT ROOT_URL;
in
mkIf config.services.gitea.enable {
  name =
    if config.services.gitea.settings ? DEFAULT.APP_NAME then
      "gitea (${config.services.gitea.settings.DEFAULT.APP_NAME})"
    else
      "gitea";
  icon = "services.gitea";
  info = ROOT_URL;
  details.listen.text = "${HTTP_ADDR}:${toString HTTP_PORT}";
}
