{
  config,
  pkgs,
  hostname,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./plymouth.nix
    # ./printing.nix
  ];

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    bluez
    bluez-alsa
    bluez-tools
    networkmanagerapplet
    libimobiledevice
    razergenie
  ];

  # dual booting with windows boot loader mounted on /efi
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = ["intel_iommu=on" "quiet" "systemd.show_status=0" "loglevel=4" "rd.systemd.show_status=auto" "rd.udev.log-priority=3"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
      systemd-boot = {enable = true;};
    };
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    swraid.enable = false;
  };

  # networking
  networking.hostName = hostname;
  networking.interfaces."wlp0s20f3" = {useDHCP = false;};
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  # iphone tethering
  services.usbmuxd.enable = true;
  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.plymouth = {
    enable = false;
    themeName = "seal";
  };

  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.displayManager.startx.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.emptty = {
    enable = true;
    configuration = {
      DEFAULT_USER = username;
      DBUS_LAUNCH = false;
    };
  };

  services.xserver = {
    videoDriver = "intel";

    config = ''
      Section "ServerFlags"
          Option      "AutoAddDevices"         "false"
      EndSection
    '';
  };
}
