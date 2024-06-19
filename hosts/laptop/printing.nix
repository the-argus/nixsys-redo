{...}: {
  services.printing.enable = true;
  services.avahi.enable = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
}
