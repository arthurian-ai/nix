{ pkgs, ... }:
{
  # KVM/QEMU virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
  	virt-manager
  	spice-gtk  # provides clipboard integration in the viewer
  	wl-clipboard
	dnsmasq
  ];

# Define the network if it doesn't exist
  systemd.services.libvirtd.postStart = ''
	  ${pkgs.libvirt}/bin/virsh net-list --all | grep -q default || \
	  ${pkgs.libvirt}/bin/virsh net-define ${pkgs.libvirt}/etc/libvirt/qemu/networks/default.xml || true
	  ${pkgs.libvirt}/bin/virsh net-autostart default || true
	  ${pkgs.libvirt}/bin/virsh net-start default || true
  '';

  # virsh net-start default
  # virsh net-autostart default

  # systemd.services.libvirtd.postStart = ''
  #  ${pkgs.libvirt}/bin/virsh net-start default || true
  # '';

  # virtualisation.spiceUSBRedirection.enable = true;
}
