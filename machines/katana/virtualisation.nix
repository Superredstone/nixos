{ currentSystemUser, ... }:
{
	virtualisation.podman.enable = true;
	virtualisation.podman.dockerCompat = true;

	programs.virt-manager.enable = true;
	users.groups.libvirtd.members = ["${currentSystemUser}"];
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;
}
