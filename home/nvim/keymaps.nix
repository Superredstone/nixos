{ ... }:
{
	programs.nixvim.keymaps = [
		{
			action = ":bnext<CR>";
			key = "<A-l>";
			options = { 
				silent = true; 
				desc = "Next tab";
			};
			mode = "n";
		}
		{
			action = ":bprevious<CR>";
			key = "<A-h>";
			options = { 
				silent = true; 
				desc = "Previous tab";
			};
			mode = "n";
		}
		{
			action = ":bdelete<CR>";
			key = "<S-q>";
			options = { 
				silent = true; 
				desc = "Next tab";
			};
			mode = "n";
		}
		{
			action = "<C-\\><C-n>";
			key = "<Esc>";
			options = { 
				silent = true; 
				desc = "Exit terminal insert mode";
			};
			mode = "t";
		}
		{
			action = ":w<CR>";
			key = "<C-s>";
			options = { 
				silent = true; 
				desc = "Save";
			};
			mode = "n";
		}
		{
			action = ":lua vim.lsp.buf.format()<CR>";
			key = "<C-f>";
			options = {
				silent = true;
				desc = "Format buffer";
			};
			mode = "n";
		}
		{
			action = ":q<CR>";
			key = "<C-q>";
			options = { 
				silent = true; 
				desc = "Quit";
			};
			mode = "n";
		}
		{
			action = ":wincmd l<CR>";
			key = "<Space>wl";
			options = { 
				silent = true; 
				desc = "Go to left panel";
			};
			mode = "n";
		}
		{
			action = ":wincmd k<CR>";
			key = "<Space>wk";
			options = { 
				silent = true; 
				desc = "Go to upper panel";
			};
			mode = "n";
		}
		{
			action = ":wincmd j<CR>";
			key = "<Space>wj";
			options = { 
				silent = true; 
				desc = "Go to down panel";
			};
			mode = "n";
		}
		{
			action = ":wincmd h<CR>";
			key = "<Space>wh";
			options = { 
				silent = true; 
				desc = "Go to left panel";
			};
			mode = "n";
		}
		{
			action = "$";
			key = "gl";
			options = { 
				silent = true; 
				desc = "Go to end line";
			};
			mode = [ "n" "v" ];
		}
		{
			action = "^";
			key = "gh";
			options = { 
				silent = true; 
				desc = "Go to start line";
			};
			mode = [ "n" "v" ];
		}
		# Neotree
		{
			action = ":Neotree toggle<CR>";
			key = "<Space>e";
			options = { 
				silent = true; 
				desc = "Toggle file explorer";
			};
			mode = "n";
		}
		# ToggleTerm
		{
			action = ":ToggleTerm direction=float<CR>";
			key = "<Space>t";
			options = { 
				silent = true; 
				desc = "Toggle terminal";
			};
			mode = "n";
		}
		# Dap 
		{
			action.__raw = ''
			function() 
				require("dap").toggle_breakpoint()
			end
			'';
			key = "<Space>b";
			mode = "n";
			options = {
				silent = true;
				desc = "Toggle breakpoint";
			};
		}
		{
			action.__raw = ''
			function() 
				require("dapui").toggle()
			end
			'';
			key = "<Space>y";
			mode = "n";
			options = {
				silent = true;
				desc = "Toggle debugger";
			};
		}
	];
}
