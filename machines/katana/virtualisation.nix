{ currentSystemUser, ... }:
{
	programs.virt-manager.enable = true;
	users.groups.libvirtd.members = ["${currentSystemUser}"];
	virtualisation = {
		docker.enable = true;
		libvirtd.enable = true;
		spiceUSBRedirection.enable = true;
	};
}
