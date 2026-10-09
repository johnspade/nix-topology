_: {
  name = "Navidrome";
  icon = "services.navidrome";
  nixos = {
    path = "services.navidrome";
    infoFn = cfg: cfg.settings.BaseUrl or null;
    detailsFn =
      cfg:
      if cfg.openFirewall then
        {
          listen = {
            text = "${cfg.settings.Address}:${toString cfg.settings.Port}";
          };
        }
      else
        { };
  };
  test = {
    config = {
      services.navidrome = {
        enable = true;
        openFirewall = true;
        settings = {
          BaseUrl = "https://music.example.com";
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
        assertion = services.navidrome.info == "https://music.example.com";
        message = "expected info 'https://music.example.com', got '${services.navidrome.info}'";
      }
      {
        assertion = services.navidrome.details.listen.text == "0.0.0.0:4533";
        message = "expected listen '0.0.0.0:4533', got '${services.navidrome.details.listen.text}'";
      }
    ];
  };
}
