{ pkgs, ... }:
{
  # KVM/QEMU virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
  	virt-manager
  	spice-gtk  # provides clipboard integration in the viewer
  	wl-clipboard
  ];

  # virtualisation.spiceUSBRedirection.enable = true;
}
