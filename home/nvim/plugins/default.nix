{ ... }:
{
	imports = [
		./telescope.nix
		./treesitter.nix
		./comment.nix
		./lualine.nix
		./dashboard.nix
		./neotree.nix
	];

	programs.nixvim.plugins = {
		web-devicons.enable = true;
		bufferline.enable = true;
		toggleterm.enable = true;
		gitsigns.enable = true;
		which-key.enable = true;
		autoclose.enable = true;
		markview.enable = true;
		nvim-surround.enable = true;
	};
}
