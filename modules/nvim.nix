{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    initLua = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true

      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.autoindent = true

      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = false
      vim.opt.incsearch = true

      vim.opt.mouse = 'a'
      vim.opt.clipboard = 'unnamedplus'
      vim.opt.scrolloff = 8
      vim.opt.sidescrolloff = 8
      vim.opt.wrap = false
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.signcolumn = 'yes'
      vim.opt.cursorline = true
      vim.opt.showmode = false

      vim.opt.undofile = true
      vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'

      local clears = {
        "Normal", "NormalNC", "NormalFloat", "FloatBorder",
        "SignColumn", "LineNr", "CursorLineNr", "EndOfBuffer",
      }
      for _, g in ipairs(clears) do
        vim.api.nvim_set_hl(0, g, { bg = "none", ctermbg = "none" })
      end
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#524f67" })

      vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save" })
      vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit" })
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
      vim.keymap.set('n', '<C-d>', '<C-d>zz')
      vim.keymap.set('n', '<C-u>', '<C-u>zz')
    '';
  };
}
