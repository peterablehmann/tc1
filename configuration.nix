{ modulesPath, lib, inputs, ... }: {
  imports = [

    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
    ./modules
  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
  };

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  boot.tmp.cleanOnBoot = true;
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  networking = {
    usePredictableInterfaceNames = lib.mkDefault false;
    hostName = "tc1";
    domain = "xnee.net";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
    };
    interfaces.eth0.useDHCP = true;
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP1Ss4ebDys/jMEzTPTv3/h9uRly37034XKQ79w9y7Yf xgwq@kee"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPwWRxjlcObusKS+fO5RCmFlz+1nASaVAZddfE3ULgP6 peter@kleeblatt.xnee.net"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIufiw/wK2tMs2Kr2kZCkdJL0KNo1Ww2wJiS+c8I0QcBz9Ed+Wd6KixXPZK2XBZL3iv0bKXf/7U7mjj6bOetCz0ZI15pdNTYkk2nldvb5JkjXybgX+METJYNxAvoy5f5irDmRHPCG0RZayWCMLqu6uFMEkL6bV8Zn/Dr+PtzJTwgOyb36AWR1lscJ2CYc8tR7EmtxX1i9mexeF+WtG1fk3r3Qxqcxu1/kpncrZkYzvfb9MzuIhr0yWzgPaOd1jKPeAka/uNeQIozvz4VdT4rN8A2MzukAiLu5Cbs3DOQq/FW84Qk8q1me3SlTQ+MCskS0oJLYoxgxhWE85jtjYHU7woT6oehl448PJJk3L9dUX2wJclMbn/dM4YnhW9XN5OTLbhgl7pIzeuAmtV9G6uVafJkUov00/3id+iUrgrycMZrFFQJnKOChF+NVPJ17pCsGD7gycaNCVoXCvwF1GiFleKolfGQsPBShyT6Pop+JyDNQBNMHsGsrFYBQwHZaHhts7ngnt0CqS90/izrOS/kF1kserqZFErMeT9gpQCFjXPrwgSCUdA3c7A+DGpimFKARYUZitOTuZvBj6I2Aj3EX8VJ2tyRZvXQ11rpo33jqahCbUBCk6JOwu+OTvSjtMywqr6jYpcbIvRDaB9L7km/JfOMSFBUkO09JHxAfdwaqx9Q== cardno:20_158_828"
    ];
  };

  system.stateVersion = "23.05";
}
