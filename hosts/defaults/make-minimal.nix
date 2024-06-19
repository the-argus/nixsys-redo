{
  lib,
  modulesPath,
  ...
}: {
  # disable some package installation ------------------------------------------
  environment.defaultPackages = lib.mkDefault [];

  # disable xdg sounds/icons etc, disable udisk, documentation + man pages, xlibs
  imports = [
    (modulesPath + "/profiles/minimal.nix")
  ];

  # disable some kernel modules and firmware -----------------------------------
  boot.initrd.includeDefaultModules = lib.mkDefault false;

  # NOTE: Default modules look like this (from nixpkgs/nixos/modules/system/boot/kernel.nix):
  # # Some SATA/PATA stuff
  # "ahci"
  # "sata_nv"
  # "sata_via"
  # "sata_sis"
  # "sata_uli"
  # "ata_piix"
  # "pata_marvell"
  # # Standard SCSI stuff
  # "sd_mod"
  # "sr_mod"
  # # SD cards and internal eMMC drives
  # "mmc_block"
  # # USB keyboards
  # "uhci_hcd"
  # "ehci_hcd"
  # "ehci_pci"
  # "ohci_hcd"
  # "ohci_pci"
  # "xhci_hcd"
  # "xhci_pci"
  # "usbhid"
  # "hid_generic" "hid_lenovo" "hid_apple" "hid_roccat"
  # "hid_logitech_hidpp" "hid_logitech_dj" "hid_microsoft" "hid_cherry"

  disabledModules = [
    (modulesPath + "/profiles/all-hardware.nix")
    (modulesPath + "/profiles/base.nix")
  ];

  # stuff disabled by disabling the above modules:
  #
  # hardware.enableRedistributableFirmware = true;
  #
  # kernel modules:
  # "vmw_vmci" "vmwgfx" "vmw_vsock_vmci_transport"
  # "hv_storvsc"
  # "ahci"
  # "ata_piix"
  # "sata_inic162x" "sata_nv" "sata_promise" "sata_qstor"
  # "sata_sil" "sata_sil24" "sata_sis" "sata_svw" "sata_sx4"
  # "sata_uli" "sata_via" "sata_vsc"
  # "pata_ali" "pata_amd" "pata_artop" "pata_atiixp" "pata_efar"
  # "pata_hpt366" "pata_hpt37x" "pata_hpt3x2n" "pata_hpt3x3"
  # "pata_it8213" "pata_it821x" "pata_jmicron" "pata_marvell"
  # "pata_mpiix" "pata_netcell" "pata_ns87410" "pata_oldpiix"
  # "pata_pcmcia" "pata_pdc2027x" "pata_qdi" "pata_rz1000"
  # "pata_serverworks" "pata_sil680" "pata_sis"
  # "pata_sl82c105" "pata_triflex" "pata_via"
  # "pata_winbond"
  # "3w-9xxx" "3w-xxxx" "aic79xx" "aic7xxx" "arcmsr" "hpsa"
  # "uas"
  # "sdhci_pci"
  # "nvme"
  # "ohci1394" "sbp2"
  # "virtio_net" "virtio_pci" "virtio_mmio" "virtio_blk" "virtio_scsi" "virtio_balloon" "virtio_console"
  # "mptspi" "vmxnet3" "vsock"

  # profiles/base.nix enables a ton of filesystems, here are the ones we always want
  # NOTE: zfs disabled, zfs hostId missing
  boot.supportedFilesystems = lib.mkDefault ["btrfs" "ext4" "ntfs" "vfat"];

  # re-enable some modules for everybody
  boot.initrd.availableKernelModules = [
    # all my systems use nvme
    "nvme"
  ];

  # disable redistributable firmware and then only enable the ones we want, per-host
  enableRedistributableFirmware = false;
}
