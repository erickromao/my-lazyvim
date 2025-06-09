-- ~/.config/nvim/lua/plugins/lsp_config.lua

----CSHARP
--return {
--  {
--    "neovim/nvim-lspconfig",
--    -- A configuração do LSP vai na função 'config' do plugin
--    config = function()
--      local lspconfig = require("lspconfig")
--
--      -- Configuração específica do csharp_ls
--      lspconfig.csharp_ls.setup({
--        -- As configurações do servidor vão dentro da tabela 'settings'
--        settings = {
--          Formatting = {
--            SpaceAfterComma = false,
--            SpaceAfterDot = false,
--            SpaceBeforeDot = false,
--            SpaceAroundBinaryOperators = false,
--            SpaceWithinParentheses = false,
--          },
--          -- Se houver outras configurações que você sabe que precisa, coloque-as aqui.
--          -- Ex: DotnetSolutionPath = "caminho/para/sua/solution.sln",
--        },
--        -- Você pode querer manter um on_attach básico se quiser mapear alguma tecla no futuro,
--        -- mas para o seu pedido atual de 'minimalista e sem instalar nada', vamos omitir.
--        -- Se quiser os mapeamentos de teclado, reative o 'on_attach' e 'capabilities'
--        -- conforme a resposta anterior.
--      })
--    end,
--  },
--}

-- ~/.config/nvim/lua/plugins/lsp_config.lua

return {
  {
    "neovim/nvim-lspconfig",
    -- As dependências do Mason são importantes para a instalação dos LSPs,
    -- mas não precisam da 'cmp_nvim_lsp' se você não quer mapeamentos.
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Opcional, para formatadores/linters via Mason
      { "j-hui/fidget.nvim", opts = {} }, -- Opcional, para barra de status de LSP
      -- Removido: "hrsh7th/cmp-nvim-lsp", -- Não necessário se não usar as 'capabilities' padrão do CMP
    },
    -- A configuração do LSP vai na função 'config' do plugin
    config = function()
      local lspconfig = require("lspconfig")

      -- REMOVIDO: capabilities (não necessário sem cmp-nvim-lsp ou mapeamentos específicos)
      -- REMOVIDO: on_attach function (não necessário se não quiser mapeamentos de teclado)

      -- Configuração específica do csharp_ls (mantido como está, mas sem on_attach/capabilities)
      lspconfig.csharp_ls.setup({
        settings = {
          Formatting = {
            SpaceAfterComma = false,
            SpaceAfterDot = false,
            SpaceBeforeDot = false,
            SpaceAroundBinaryOperators = false,
            SpaceWithinParentheses = false,
          },
        },
        -- REMOVIDO: on_attach = on_attach,
        -- REMOVIDO: capabilities = capabilities,
      })

      -- ********** NOVOS LSPs QUE VOCÊ QUER ADICIONAR (SEM KEYMAPS) **********

      -- Configuração para CSS
      lspconfig.cssls.setup({
        -- REMOVIDO: on_attach = on_attach,
        -- REMOVIDO: capabilities = capabilities,
      })

      -- Configuração para TypeScript/JavaScript
      lspconfig.tsserver.setup({
        -- REMOVIDO: on_attach = on_attach,
        -- REMOVIDO: capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = "all",
              parameterTypes = true,
              variableTypes = true,
              propertyDeclarations = true,
              functionLikeReturnTypes = true,
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = "all",
              parameterTypes = true,
              variableTypes = true,
              propertyDeclarations = true,
              functionLikeReturnTypes = true,
            },
          },
        },
      })

      -- Configuração para Angular
      lspconfig.angular_language_server.setup({
        -- REMOVIDO: on_attach = on_attach,
        -- REMOVIDO: capabilities = capabilities,
        filetypes = { "html", "typescript", "json", "yaml", "xml" },
      })

      -- ** IMPORTANTE: Se você estiver usando o Mason para instalar LSPs,
      --    você também precisa garantir que o mason-lspconfig esteja configurado para
      --    instalar automaticamente esses servidores e vinculá-los ao lspconfig. **
      --    Isso geralmente é feito em outro arquivo no LazyVim (lsp.lua padrão)
      --    ou se este é seu único arquivo de configuração de LSP,
      --    você pode precisar de um bloco `mason-lspconfig.setup_handlers` aqui,
      --    mas sem a parte de `on_attach`/`capabilities` nos handlers.

      -- Exemplo de como o mason-lspconfig.setup_handlers pode ser sem mapeamentos:
      -- (Se você não tiver um lsp.lua padrão do LazyVim, considere adicionar isso)
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          -- Apenas configura o servidor sem mapeamentos ou capacidades específicas
          -- Lspconfig irá usar as capacidades padrão.
          lspconfig[server_name].setup({})
        end,
      })
      -- OU, se você preferir a abordagem do opts.servers do LazyVim (recomendado para simplicidade):
      -- require("mason-lspconfig").setup({
      --   ensure_installed = {
      --     "csharp_ls", "cssls", "tsserver", "angular_language_server"
      --   },
      -- })
    end,
  },
}
