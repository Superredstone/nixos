{ config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		settings.user = {
			name = "Superredstone";	
			email = "patrickcanal3@gmail.com";
		};
	};
}
