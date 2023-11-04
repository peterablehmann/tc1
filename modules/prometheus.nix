{
  services.prometheus = {
    enable = true;
    port = 9001;
    checkConfig = "syntax-only";
    scrapeConfigs = [
      {
        job_name = "node-exporter";
        scrape_interval = "20s";
        scheme = "http";
        static_configs = [{
          targets = [ "localhost:9100" ];
        }];
      }
    ];
    exporters.node = {
      enable = true;
      listenAddress = "127.0.0.1";
    };
  };


}
