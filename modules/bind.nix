{
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
  services.bind = {
    enable = true;

    forward = "first";
    forwarders = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
    cacheNetworks = [
      "127.0.0.0/8"
      "192.168.10.0/23"
      "fd00::/64"
    ];
  };
}
