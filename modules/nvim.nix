{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      rose-pine
      nvim-web-devicons               # Needed for Lualine icons
      lualine-nvim                    # The status bar
      nvim-treesitter.withAllGrammars # Rich syntax highlighting
    ];

    initLua = ''
      -- ==========================================
      -- Core Options
      -- ==========================================
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

      -- ==========================================
      -- Theme Setup
      -- ==========================================
      require("rose-pine").setup({
          styles = {
              transparency = true,
          }
      })
      vim.cmd("colorscheme rose-pine")

      local clears = {
        "Normal", "NormalNC", "NormalFloat", "FloatBorder",
        "SignColumn", "LineNr", "CursorLineNr", "EndOfBuffer",
      }
      for _, g in ipairs(clears) do
        vim.api.nvim_set_hl(0, g, { bg = "none", ctermbg = "none" })
      end
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#524f67" })

      -- ==========================================
      -- Safe Plugin Loading (No Crashes)
      -- ==========================================
      
      -- Treesitter (Syntax Highlighting)
      local ts_ok, ts = pcall(require, "nvim-treesitter.configs")
      if ts_ok then
        ts.setup({
          highlight = { enable = true },
          indent = { enable = true },
        })
      end

      -- Lualine (Status Bar)
      local lualine_ok, lualine = pcall(require, "lualine")
      if lualine_ok then
        lualine.setup({
          options = {
            theme = 'rose-pine',
            component_separators = '|',
            section_separators = { left = '', right = '' },
            globalstatus = true,
          }
        })
      end

      -- ==========================================
      -- Keymaps
      -- ==========================================
      vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save" })
      vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit" })
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
      vim.keymap.set('n', '<C-d>', '<C-d>zz')
      vim.keymap.set('n', '<C-u>', '<C-u>zz')
    '';
  };
}
