# nvim-whitespaces

Plugin simples para visualizar espaços no Neovim.

## Instalação

### Lazy.nvim

```lua
{
  "seuuser/nvim-whitespaces",
  config = function()
    require("whitespaces").setup()
  end,
}

