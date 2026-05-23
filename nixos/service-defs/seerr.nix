_: {
  name = "Seerr";
  icon = "services.seerr";
  nixos = {
    path = "services.seerr";
    detailsFn =
      cfg:
      if cfg.openFirewall or false then
        {
          listen = {
            text = "0.0.0.0:${toString cfg.port}";
          };
        }
      else
        { };
  };
  test = {
    # Via the deprecated `jellyseerr` alias, which must not show up as a separate service
    config = {
      services.jellyseerr = {
        enable = true;
        openFirewall = true;
        port = 5055;
      };
    };
    expect = {
      name = "Seerr";
      details.listen = "0.0.0.0:5055";
    };
    assertions = services: [
      {
        assertion = !(services ? jellyseerr);
        message = "enabling the deprecated 'services.jellyseerr' alias must not also register a separate 'jellyseerr' entry (duplicate of 'seerr')";
      }
    ];
  };
}
