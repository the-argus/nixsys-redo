{
  config,
  lib,
  ...
}: {
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  # enableRedistributableFirmware disables these, re-enable the ones we want
  # here
  hardware.firmware = [
    linux-firmware
    sof-firmware
    # intel2200BGFirmware
    # rtl8192su-firmware
    # rt5677-firmware
    # rtl8761b-firmware
    # rtw88-firmware
    # zd1211fw
    # alsa-firmware
    # libreelec-dvb-firmware
  ];

  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/NIXHOME";
    fsType = "btrfs";
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-label/WINBOOT";
    fsType = "vfat";
  };

  swapDevices = [{device = "/dev/disk/by-label/SWAP";}];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
