{
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [ jq ];
  sops.secrets."environment/apitoken" = {
    sopsFile = "${inputs.self}/secrets/environment.yaml";
  };
  sops.secrets."environment/zoneid" = {
    sopsFile = "${inputs.self}/secrets/environment.yaml";
  };
  sops.secrets."environment/recordid" = {
    sopsFile = "${inputs.self}/secrets/environment.yaml";
  };
  environment.variables = { 
    apitoken = config.sops.secrets."environment/apitoken".path;
    zoneid = config.sops.secrets."environment/zoneid".path;
    recordid = config.sops.secrets."environment/recordid".path;
  };
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * * [ $(ip -6 a | grep \"scope global dynamic mngtmpaddr noprefixroute\" | grep \"2003:\" | cut -d \" \" -f 6 | sed \'s/.\{3\}$//\') = $(curl -s \"https://dns.hetzner.com/api/v1/records/$recordid\" -H \"Auth-API-Token: $apitoken\" | jq \".record.value\" | tr -d \'\"\') ] || curl -s -X \"PUT\" \"https://dns.hetzner.com/api/v1/records/$recordid\" -H \'Content-Type: application/json\' -H \"Auth-API-Token: $apitoken\" -d $\'{\"value\": \"$(ip -6 a | grep \"scope global dynamic mngtmpaddr noprefixroute\" | grep \"2003:\" | cut -d \" \" -f 6 | sed \'s/.\{3\}$//\')\",\"ttl\": 0,\"type\": \"AAAA\",\"name\": \"tc1\",\"zone_id\": \"$zoneid\"}\'"
    ];
  };
}
