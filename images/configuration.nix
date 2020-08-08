{ config, pkgs }:

{
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.version = 2;
  boot.initrd.kernelModules = [ "dm-crypt" "ehci_hcd" "ahci" "ums_realtek" "usb_storage" ];
  boot.initrd.luks.devices = [{name = "root"; device = "/dev/sda2"; allowDiscards = true; }];
  boot.kernelModules = [ "kvm-intel" "tp_smapi" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.tp_smapi ];
  boot.kernelPackages = pkgs.linuxPackages_3_11;
  boot.blacklistedKernelModules = [ "pcspkr" ];
  hardware.enableAllFirmware = true;
  nix.maxJobs = 4;

  fileSystems = [
    { mountPoint = "/"; label = "root"; options = "noatime"; }
    { mountPoint = "/boot"; label = "boot"; options = "noatime"; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = "nosuid,nodev,relatime"; }
  ];

  time.timeZone = "America/LosAngeles";

  environment.systemPackages = with pkgs; [
    curl
    gitFull
    zsh
  ];

  programs.zsh.enableCompletion = true;

  environment.interactiveShellInit = ''
    echo "Welcome to NixoS!"
  '';

  services = {
    nixosManual.showManual = true;
    locate.enable = true;
  };

  users.extraUsers.lucperkins = rec {
    name = "lucperkins";
    group = "lucperkins";
    uid = 420;
    createHome = true;
    extraGroups = [ "wheel" ];
    home = "/home/${name}";
    shell = "/run/current-system/sw/bin/zsh";
  };

  users.extraGroups.lucperkins = {
    gid = 500;
  };
}