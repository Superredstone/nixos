{ pkgs, ... }:
{
	imports = [
		./opts.nix	
		./lsp.nix
		./cmp.nix
		./keymaps.nix
		./plugins
	];

	programs.nixvim = {
	 	enable = true;
		colorschemes.catppuccin.enable = true;
		extraPackages = with pkgs; [
			wl-clipboard
		];	
		clipboard.register = "unnamedplus";
		clipboard.providers.wl-copy.enable = true;	
		clipboard.providers.wl-copy.package = pkgs.wl-clipboard;
		clipboard.providers.xclip.enable = true;
		clipboard.providers.xclip.package = pkgs.xclip;
	};
}
