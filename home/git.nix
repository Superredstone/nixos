{ config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName = "Superredstone";
		userEmail = "patrickcanal3@gmail.com";
	};
}
