{ config, pkgs, ... }:
{
	programs.zoxide = {
		enable = true;
		enableFishIntegration= true;
		options = [
			"--cmd cd"
		];
	};
}
