{ config, lib }:
let
  inherit (lib) mkIf;
in
mkIf config.services.i2pd.enable {
  name = "I2P";
  icon = "services.i2p";
}
