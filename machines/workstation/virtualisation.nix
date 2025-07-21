{ currentSystemUser, ... }:
{
	# virtualisation.podman.enable = true;
	# virtualisation.podman.dockerCompat = true;
	virtualisation.docker.enable = true;

	programs.virt-manager.enable = true;
	users.groups.libvirtd.members = ["${currentSystemUser}"];
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;
}
