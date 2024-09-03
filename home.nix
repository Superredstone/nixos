{ config, pkgs, ... }:
{
	home.username = "r3ddy";
	
	programs.git = {
		enable = true;
		userName = "Superredstone";
		userEmail = "patrickcanal3@gmail.com";
	};

	programs.home-manager.enable = true;
	home.stateVersion = "24.11";
}
