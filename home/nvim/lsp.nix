{ ... }:
{
	programs.nixvim.plugins.lsp = {
		enable = true;
		servers = {
			clangd.enable = true;
			nil_ls.enable = true;
			gopls.enable = true;
			jdtls.enable = true;
			lua_ls.enable = true;
			rust_analyzer = {
				enable = true;
				installCargo = false;
				installRustc = false;
				installRustfmt = false;
			};
			zls.enable = true;
			nim_langserver.enable = true;
			pyright.enable = true;
			emmet_language_server.enable = true;
			ts_ls.enable = true;
			docker_compose_language_service.enable = true;
			jsonls.enable = true;
			phpactor.enable = true;
		};
		keymaps = {
			lspBuf = {
				"<Space>k" = "hover";
				"<Space>r" = "rename";
				"<Space>a" = "code_action";
			};
		};
	};
}
