_: {
  name = "Mastodon";
  icon = "services.mastodon";
  nixos = {
    path = "services.mastodon";
    infoFn = cfg: "https://${cfg.localDomain}";
    detailsFn = _: { };
  };
  test = {
    minimalConfig = {
      services.mastodon = {
        enable = true;
        localDomain = "social.example.com";
        smtp.fromAddress = "noreply@example.com";
      };
    };
    config = {
      services.mastodon = {
        enable = true;
        localDomain = "social.example.com";
        configureNginx = false;
        smtp.fromAddress = "noreply@example.com";
      };
    };
    assertions = services: [
      {
        assertion = services.mastodon.name == "Mastodon";
        message = "expected name 'Mastodon', got '${services.mastodon.name}'";
      }
      {
        assertion = services.mastodon.info == "https://social.example.com";
        message = "expected info 'https://social.example.com', got '${services.mastodon.info}'";
      }
    ];
  };
}
