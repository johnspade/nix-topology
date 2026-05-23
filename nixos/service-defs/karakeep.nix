_: {
  name = "Karakeep";
  icon = "services.karakeep";
  nixos = {
    path = "services.karakeep";
    detailsFn = _: { };
  };
  test = {
    config = {
      services.karakeep = {
        enable = true;
      };
    };
    assertions = services: [
      {
        assertion = services.karakeep.name == "Karakeep";
        message = "expected name 'Karakeep', got '${services.karakeep.name}'";
      }
    ];
  };
}
