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
vim.g.mapleader = " "
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })
-- 左の画面へ
vim.api.nvim_set_keymap("n", "<leader>h", "<C-w>h", { noremap = true, silent = true })
-- 右の画面へ
vim.api.nvim_set_keymap("n", "<leader>l", "<C-w>l", { noremap = true, silent = true })

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
            -- 検索除外
            local rg_excludes = {
               ".git/",
               ".DS_Store",
               "node_modules/",
               "*.swp",
               "*.pyc",
               "__pycache__/",
            }
            local rg_opts = "--hidden"
            for _, pattern in ipairs(rg_excludes) do
               rg_opts = rg_opts .. " --glob '!" .. pattern .. "'"
            end
            
            -- Rg
            vim.api.nvim_create_user_command("Rg", function(opts)
               vim.fn["fzf#vim#grep"]("rg " .. rg_opts .. " --line-number --no-heading " .. vim.fn.shellescape(opts.args), 0,
                  vim.fn["fzf#vim#with_preview"]({ options = "--exact --reverse" }, "right:50%:wrap"))
            end, { nargs = "*" })
            -- RgNoFilename
            vim.api.nvim_create_user_command("RgNoFilename", function(opts)
               vim.fn["fzf#vim#grep"]("rg " .. rg_opts .. " --line-number --no-heading " .. vim.fn.shellescape(opts.args), 0,
                  vim.fn["fzf#vim#with_preview"]({ options = "--exact --reverse --delimiter : --nth 3.." }, "right:50%:wrap"))
            end, { nargs = "*" })

         -- Rg
         vim.api.nvim_set_keymap("n", "<C-f>", ":Rg<CR>", { noremap = true, silent = true })
         -- RgNoFilename
         vim.api.nvim_set_keymap("n", "<C-p>", ":RgNoFilename<CR>", { noremap = true, silent = true })
         end
      },

      -- バッファのタブ表示
      {
         "akinsho/bufferline.nvim",
         version = "*",
         config = function()
            require("bufferline").setup({
            })
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
      },

      -- sidekick.nvim
      {
         "folke/sidekick.nvim",
         opts = {
            cli = {
               mux = {
                  backend = "tmux",
                  enabled = true,
               },
            },
         },
         keys = {
            {
               "<tab>",
               function()
                  -- if there is a next edit, jump to it, otherwise apply it if any
                  if not require("sidekick").nes_jump_or_apply() then
                     return "<Tab>" -- fallback to normal tab
                  end
               end,
               expr = true,
               desc = "Goto/Apply Next Edit Suggestion",
            },
            {
               "<c-.>",
               function() require("sidekick.cli").toggle() end,
               desc = "Sidekick Toggle",
               mode = { "n", "t", "i", "x" },
            },
            {
               "<leader>aa",
               function() require("sidekick.cli").toggle() end,
               desc = "Sidekick Toggle CLI",
            },
            {
               "<leader>as",
               function() require("sidekick.cli").select() end,
               -- Or to select only installed tools:
               -- require("sidekick.cli").select({ filter = { installed = true } })
               desc = "Select CLI",
            },
            {
               "<leader>ad",
               function() require("sidekick.cli").close() end,
               desc = "Detach a CLI Session",
            },
            {
               "<leader>at",
               function() require("sidekick.cli").send({ msg = "{this}" }) end,
               mode = { "x", "n" },
               desc = "Send This",
            },
            {
               "<leader>af",
               function() require("sidekick.cli").send({ msg = "{file}" }) end,
               desc = "Send File",
            },
            {
               "<leader>av",
               function() require("sidekick.cli").send({ msg = "{selection}" }) end,
               mode = { "x" },
               desc = "Send Visual Selection",
            },
            {
               "<leader>ap",
               function() require("sidekick.cli").prompt() end,
               mode = { "n", "x" },
               desc = "Sidekick Select Prompt",
            },
            {
               "<leader>ac",
               function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
               desc = "Sidekick Toggle Claude",
            },
         },
      },
      {
         "max397574/better-escape.nvim",
         -- event = { "BufReadPre", "BufWritePre", "BufNewFile" },
         opts = {
            timeout = 100,
            default_mappings = false,
            mappings = {
               i = { j = { k = "<ESC>" } },
               t = {
                  j = { k = "<C-\\><C-n>" },
               },
            },
         },
      },
})

-- ここから VSCode の場合に上書き
if vim.g.vscode then
  vim.g.coc_global_extensions = {}
end

function SnakeToCamel()
   -- 選択範囲を取得
   local start_line = vim.fn.line("'<")
   local end_line = vim.fn.line("'>")

   for line_num = start_line, end_line do
      local line = vim.fn.getline(line_num)

      -- スネークケースをキャメルケースに変換
      local camel = line:gsub("(%a)([%w_]*)", function(first, rest)
        return first:upper() .. rest:gsub("_(%w)", function(c) return c:upper() end):gsub("_", "")
      end)

      -- 次の行に挿入
      vim.fn.append(line_num, camel)
   end
end

-- Visual Modeでのキーマップ
vim.keymap.set('v', '<leader>sc', ':<C-u>lua SnakeToCamel()<CR>', { noremap = true, silent = true })
