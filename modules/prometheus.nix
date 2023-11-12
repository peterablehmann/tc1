{
  networking.firewall.allowedTCPPorts = [ 9100 ];
  services.prometheus.exporters.node = {
      enable = true;
      listenAddress = "192.168.10.10";
      enabledCollectors = [
        "systemd"
        "ethtool"
      ];
  };


}
