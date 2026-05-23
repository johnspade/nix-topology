{ lib }:
let
  inherit (lib) mkIf;
in
{
  name = "Paperless-ngx";
  icon = "services.paperless-ngx";
  nixos = {
    path = [
      "services"
      "paperless"
    ];
    enabled = cfg: cfg.enable or false;
    infoFn =
      cfg:
      let
        url = cfg.settings.PAPERLESS_URL or null;
      in
      mkIf (url != null) url;
    detailsFn = cfg: {
      listen = {
        text = "${cfg.address}:${toString cfg.port}";
      };
    };
  };
  test = {
    config = {
      services.paperless = {
        enable = true;
        address = "0.0.0.0";
        port = 8000;
        settings.PAPERLESS_URL = "https://paperless.example.com";
      };
    };
    assertions = services: [
      {
        assertion = services.paperless-ngx.name == "Paperless-ngx";
        message = "expected name 'Paperless-ngx', got '${services.paperless-ngx.name}'";
      }
      {
        assertion = services.paperless-ngx.info == "https://paperless.example.com";
        message = "expected info 'https://paperless.example.com', got '${services.paperless-ngx.info}'";
      }
      {
        assertion = services.paperless-ngx.details.listen.text == "0.0.0.0:8000";
        message = "expected listen '0.0.0.0:8000', got '${services.paperless-ngx.details.listen.text}'";
      }
    ];
  };
}
