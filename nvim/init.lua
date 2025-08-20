-- Syntax highlighting
vim.cmd("syntax on")

-- Set colors and encoding
vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8" }
vim.opt.fileformats = { "unix", "mac", "dos" }

-- Indentation settings
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- UI settings
vim.opt.number = true
vim.opt.title = true
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.conceallevel = 0
vim.opt.display = "lastline"
vim.opt.clipboard:append("unnamedplus")

-- Key mappings
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-n><C-n>", "<C-\\><C-n>", { noremap = true, silent = true })

-- lazy.nvim のパスを設定
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
      -- Git の差分を左側に表示
      {
         "airblade/vim-gitgutter",
         config = function()
            vim.opt.signcolumn = "yes"
            vim.opt.updatetime = 100
         end
      },

      -- color scheme
      {
         "NLKNguyen/papercolor-theme",
         cond = (function() return not (vim.g.vscode or false) end),

         config = function()
            vim.opt.background = "light"
            vim.cmd("colorscheme PaperColor")
         end
      },
      
      -- シンタックスハイライトの拡張
      { "sheerun/vim-polyglot" },

      -- ファイラ
      {
         "lambdalisue/fern.vim",
         cond = (function() return not (vim.g.vscode or false) end),

         config = function()
            vim.api.nvim_set_keymap("n", "<C-n>", ":Fern . -reveal=%<CR>", { noremap = true, silent = true })
            vim.g["fern#default_hidden"] = 1
            local hide_dirs = [[^\%(\.git\)$]]
            local hide_files = [[\%(\.DS_Store\)\+]]
            vim.g["fern#default_exclude"] = hide_dirs .. "\\|" .. hide_files
         end
      },

      -- fern の git ステータス拡張
      {
         "lambdalisue/fern-git-status.vim",
         cond = (function() return not (vim.g.vscode or false) end),

         dependencies = { "lambdalisue/fern.vim" }
      },

      -- fzf
      {
         "junegunn/fzf",
         build = "./install --bin"
      },
      {
         "junegunn/fzf.vim",
         cond = (function() return not (vim.g.vscode or false) end),

         dependencies = { "junegunn/fzf" },
         config = function()
            vim.api.nvim_create_user_command("Rg", function(opts)
               vim.fn["fzf#vim#grep"]("rg --line-number --no-heading " .. vim.fn.shellescape(opts.args), 0,
                  vim.fn["fzf#vim#with_preview"]({ options = "--exact --reverse" }, "right:50%:wrap"))
            end, { nargs = "*" })
            vim.api.nvim_create_user_command("RgNoFilename", function(opts)
               vim.fn["fzf#vim#grep"]("rg --line-number --no-heading " .. vim.fn.shellescape(opts.args), 0,
                  vim.fn["fzf#vim#with_preview"]({ options = "--exact --reverse --delimiter : --with-nth 2.." }, "right:50%:wrap"))
            end, { nargs = "*" })
         vim.api.nvim_set_keymap("n", "<C-f>", ":Rg<CR>", { noremap = true, silent = true })
         vim.api.nvim_set_keymap("n", "<C-p>", ":RgNoFilename<CR>", { noremap = true, silent = true })
         end
      },

      -- バッファのタブ表示
      {
         "ap/vim-buftabline",

         config = function()
            vim.api.nvim_set_keymap("n", "J", ":bprev<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "K", ":bnext<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<C-w>", ":bw<CR>", { noremap = true, silent = true })
         end
      },

      -- coc.nvim
      {
         "neoclide/coc.nvim",
         cond = (function() return not (vim.g.vscode or false) end),

         branch = "release",
         config = function()
            vim.g.coc_global_extensions = { "coc-go", "coc-rust-analyzer", "coc-python" }
            vim.api.nvim_set_keymap("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", { expr = true, noremap = true, silent = true })
         end
      },

      -- tffmt
      {
         "hashivim/vim-terraform",

         config = function()
            vim.g.terraform_fmt_on_save = 1
         end
      }
})

-- ここから VSCode の場合に上書き
if vim.g.vscode then
  vim.g.coc_global_extensions = {}
end
