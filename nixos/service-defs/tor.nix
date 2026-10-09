_: {
  name = "Tor";
  icon = "services.tor";
  nixos = {
    path = "services.tor";
    infoFn = cfg: if cfg.relay.enable or false then "Role: ${cfg.relay.role}" else null;
    detailsFn = _: { };
  };
  test = {
    config = {
      services.tor = {
        enable = true;
        relay = {
          enable = true;
          role = "relay";
        };
      };
    };
    assertions = services: [
      {
        assertion = services.tor.name == "Tor";
        message = "expected name 'Tor', got '${services.tor.name}'";
      }
      {
        assertion = services.tor.info == "Role: relay";
        message = "expected info 'Role: relay', got '${services.tor.info}'";
      }
    ];
  };
}
