{ lib }:
let
  inherit (lib) mkIf;
in
{
  name = "PostgreSQL";
  icon = "services.postgresql";
  nixos = {
    path = [
      "services"
      "postgresql"
    ];
    enabled = cfg: cfg.enable or false;
    detailsFn =
      cfg:
      let
        port = cfg.settings.port or null;
      in
      mkIf (port != null) {
        listen = {
          text = "0.0.0.0:${toString port}";
        };
      };
  };
  test = {
    config = {
      services.postgresql = {
        enable = true;
        settings.port = 5432;
      };
    };
    assertions = services: [
      {
        assertion = services.postgresql.name == "PostgreSQL";
        message = "expected name 'PostgreSQL', got '${services.postgresql.name}'";
      }
      {
        assertion = services.postgresql.details.listen.text == "0.0.0.0:5432";
        message = "expected listen '0.0.0.0:5432', got '${services.postgresql.details.listen.text}'";
      }
    ];
  };
}
