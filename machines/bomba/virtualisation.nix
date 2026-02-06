{ ... }:
{
	virtualisation = {
		docker.enable = true;
		spiceUSBRedirection.enable = true;
		libvirtd = {
			enable = true;
			package = pkgs.qemu_kvm;
		};
	};
}
