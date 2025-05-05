{ pkgs, ... }:
{
	programs.nixvim.plugins = {
		dap = {
			enable = true;
			adapters = {
				executables = {
					gdb = { 
						command = "gdb";
						args = [
							"-i"
							"dap"
						];
					};
					lldb = {
						command = "lldb";
					};
				};
				servers = {
					codelldb = {
						port = 13000;
						executable = {
							command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
							args = [
								"--port"
								"13000"
							];
						};
					};
				};
			};
			configurations = {
				cpp = [
					{
						name = "Launch GDB";
						type = "gdb";
						request = "launch";
						program.__raw = ''
							function() 
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end'';
					}
					{
						name = "Launch LLDB";
						type = "lldb";
						request = "launch";
						program.__raw = ''
							function()
								return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
							end'';
					}
					{
						name = "Launch CodeLLDB";
						type = "codelldb";
						request = "launch";
						program.__raw = ''
							function()
								return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
							end'';
					}
				];
			};
		};
		dap-ui.enable = true;
	};
}
