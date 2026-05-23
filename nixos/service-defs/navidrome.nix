{ lib }:
let
  inherit (lib) mkIf;
in
{
  name = "Navidrome";
  icon = "services.navidrome";
  nixos = {
    path = [
      "services"
      "navidrome"
    ];
    enabled = cfg: cfg.enable or false;
    infoFn = cfg: mkIf (cfg.settings ? Address) cfg.settings.Address;
    detailsFn =
      cfg:
      mkIf cfg.openFirewall {
        listen = {
          text = "${cfg.settings.Address}:${toString cfg.settings.Port}";
        };
      };
  };
  test = {
    config = {
      services.navidrome = {
        enable = true;
        openFirewall = true;
        settings = {
          Address = "0.0.0.0";
          Port = 4533;
        };
      };
    };
    assertions = services: [
      {
        assertion = services.navidrome.name == "Navidrome";
        message = "expected name 'Navidrome', got '${services.navidrome.name}'";
      }
      {
        assertion = services.navidrome.info == "0.0.0.0";
        message = "expected info '0.0.0.0', got '${services.navidrome.info}'";
      }
      {
        assertion = services.navidrome.details.listen.text == "0.0.0.0:4533";
        message = "expected listen '0.0.0.0:4533', got '${services.navidrome.details.listen.text}'";
      }
    ];
  };
}
