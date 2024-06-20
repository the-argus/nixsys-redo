# This file defines common packages installed on all hosts
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    htop
    git
    home-manager
    zip
    unzip
    wget
    curl
    file
    killall
    pam_u2f
    polkit
    usbutils
    alsa-utils
    pciutils
    inetutils
  ];
}
