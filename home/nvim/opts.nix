{ ... }:
{
	programs.nixvim.opts = {
		number = true;
		relativenumber = true;
		signcolumn = "yes";
		splitright = true;
		splitbelow = true;
		cursorline = true;
		scrolloff = 5;
		undofile = true;
		ignorecase = true;
		smartcase = true;
		gdefault = true;
		termguicolors = true;
    	};
}
