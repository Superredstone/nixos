{ ... }:
{
	programs.nixvim.plugins.lspkind.enable = true;
	programs.nixvim.plugins.cmp-nvim-lsp-signature-help.enable = true;
	programs.nixvim.plugins.cmp = {
		enable = true;
		autoEnableSources = true;
		settings = {
			sources = [
				{ name = "nvim_lsp"; }
				{ name = "nvim_lsp_signature_help"; }
				{ name = "path"; }
				{ name = "buffer"; }
				{ name = "dap"; }
			];
			mapping = {
				"<Tab>" = "cmp.mapping.select_next_item()";
				"<S-Tab>" = "cmp.mapping.select_prev_item()";
				"<C-j>" = "cmp.mapping.scroll_docs(4)";
				"<C-k>" = "cmp.mapping.scroll_docs(-4)";
				"<C-Space>" = "cmp.mapping.complete()";
				"<C-Esc>" = "cmp.mapping.close()";
				"<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
			};
		};
	};
}
