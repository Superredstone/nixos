{ ... }:
{
	programs.nixvim.plugins.comment = {
		enable = true;
		settings.toggler = {
			block = "<C-x>";
			line = "<C-c>";
		};
	};
}
