{ config, lib }:
let
  inherit (lib) mkIf;
  hickorySettings = config.services.hickory-dns.settings;
  listIps = ips: toString (map (addr: "${addr}:${toString hickorySettings.listen_port}") ips);
in
mkIf config.services.hickory-dns.enable {
  name = "Hickory DNS";
  icon = "services.hickory-dns";
  details = {
    listen_ipv4.text = listIps hickorySettings.listen_addrs_ipv4;
    listen_ipv6.text = listIps hickorySettings.listen_addrs_ipv6;
  };
}
