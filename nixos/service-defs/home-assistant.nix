{ lib }:
let
  inherit (lib) flip map;
in
{
  name = "Home Assistant";
  icon = "services.home-assistant";
  nixos = {
    path = "services.home-assistant";
    # `config` is null when configuration.yaml is managed outside of nix
    detailsFn =
      cfg:
      if cfg.config == null then
        { }
      else
        {
          listen = {
            text = toString (
              flip map cfg.config.http.server_host (addr: "${addr}:${toString cfg.config.http.server_port}")
            );
          };
        };
  };
  test = {
    config = {
      services.home-assistant = {
        enable = true;
        config.http = {
          server_host = [
            "0.0.0.0"
            "::0"
          ];
          server_port = 8123;
        };
      };
    };
    expect = {
      name = "Home Assistant";
      details.listen = "0.0.0.0:8123 ::0:8123";
    };
  };
}
