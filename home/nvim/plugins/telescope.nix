{ ... }:
{	
	programs.nixvim.plugins.telescope = {
		enable = true;
		keymaps = {
			"<Space>f" = "find_files";
			"<Space>g" = "live_grep";
		};
	};
}
