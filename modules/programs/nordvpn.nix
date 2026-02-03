{ pkgs, nur, ... } @ inputs: 
{
	imports = [
		inputs.nur.modules.nixos.default
    		inputs.nur.legacyPackages.x86_64-linux.repos.wingej0.modules.nordvpn
	];

	nixpkgs.overlays = [
		(final: prev: {
			nordvpn = pkgs.nur.repos.wingej0.nordvpn;
		})
	];
}
