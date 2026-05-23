_: {
  name = "Alloy";
  icon = "services.alloy";
  nixos = {
    path = "services.alloy";
    detailsFn = _: { };
  };
  test = {
    config = {
      services.alloy = {
        enable = true;
      };
    };
    assertions = services: [
      {
        assertion = services.alloy.name == "Alloy";
        message = "expected name 'Alloy', got '${services.alloy.name}'";
      }
    ];
  };
}
