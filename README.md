# show-whitespaces

Plugin simples para visualizar espaços no Neovim.

## Instalação

### Lazy.nvim

```lua
{
  "thiagochirana/show-whitespaces",
  config = function()
    require("whitespaces").setup()
  end,
}

