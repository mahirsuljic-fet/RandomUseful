## Websites

### Configs
https://nvchad.com/docs/quickstart/install/ \
https://github.com/nvim-lua/kickstart.nvim/

### NvChad helpful
https://blog.spoonconsulting.com/getting-started-with-neovim-using-nvchad-a-developers-guide-f97d81e85d60

### Plugins
https://github.com/rockerBOO/awesome-neovim

### Custom snippets 
https://www.youtube.com/watch?v=FmHhonPjvvA \
https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md \
https://sbulav.github.io/vim/neovim-setting-up-luasnip/


## FILES AND DIRECTORIES (NvChad) |

Snippets:           `~/.local/share/nvim/lazy/LuaSnip/plugin/`
clangd LSP:         `~/.local/share/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations/clangd.lua`
Custom settings:    `~/.config/nvim/lua/options.lua`     (svi set-ovi su unutar `vim.o` objekta (`vim.o.NAME = VALUE`, npr. `vim.o.relativenumber = true`))


## Problems

### NvChad warning multiple different client offset solution (clangd LSP)

`~/.local/share/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations/clangd.lua`

``` lua
...
local default_capabilities = {
  textDocument = {
    completion = {
      editsNearCursor = true,
    },
  },
  offsetEncoding = { 'utf-8', 'utf-16' }, -- <<<<<<<<<<
}
...
```
