return {
    cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    { '.luarc.json', '.luarc.jsonc' },
    '.git',
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      -- TODO: This is nvim specific, it should be in a luarc file in the project repo
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        ignoreSubmodules = true,
        -- Make the server aware of Neovim runtime files
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}
