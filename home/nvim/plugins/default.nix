{ pkgs, ... }:
{
	imports = [
		./comment.nix
		./dap.nix
		./dashboard.nix
		./guess-indent.nix
		./lualine.nix
		./neotree.nix
		./telescope.nix
		./treesitter.nix
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
