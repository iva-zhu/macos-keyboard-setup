-- Neovim options: numbers, 2-space indent, no swap/backup, system clipboard, smooth scroll.

local options = {
  -- Clipboard settings
  clipboard = 'unnamedplus', -- Use system clipboard
  completeopt = { 'menu', 'menuone', 'noselect' }, -- Completion menu behavior

  -- Line numbering
  number = true, -- Show line numbers
  relativenumber = true, -- Show relative line numbers

  -- Backup, swap and undo files
  swapfile = false, -- Disable swap file
  backup = false, -- Disable backup file
  undofile = true, -- Persist undo history between sessions (stored in ~/.local/state/nvim/undo/)

  -- Text wrapping and scrolling
  wrap = false, -- Disable line wrapping
  smoothscroll = true, -- Enable smooth scrolling
  scrolloff = 8, -- Minimum number of screen lines to keep above and below the cursor

  -- Mouse settings
  mouse = '', -- Disable mouse support

  -- Splitting behavior
  splitbelow = true, -- Open new horizontal split below
  splitright = true, -- Split vertical window to the right

  -- Indentation and tab settings
  expandtab = true, -- Use spaces instead of tabs
  smartindent = true, -- Smart autoindenting on new lines
  cindent = true, -- Enable C-style indentation
  smarttab = true, -- Insert appropriate number of spaces on tab
  shiftwidth = 2, -- Number of spaces to use for each step of (auto)indent
  softtabstop = 2, -- Number of spaces in tab when editing
  tabstop = 2, -- Number of spaces that a <Tab> in the file counts for

  -- Search settings
  hlsearch = true, -- Enable highlight on search
  incsearch = true, -- Show search matches as you type
  ignorecase = true, -- Ignore case in searches by default
  smartcase = true, -- Case sensitive if an uppercase is entered

  -- Visual settings
  termguicolors = true, -- Enable true color support
  cursorline = true, -- Highlight the current line
  showmode = false, -- Hide the "-- INSERT --" mode hint

  -- Performance settings
  updatetime = 50, -- Faster completion (default is 4000ms)

  -- Hide syntax markers in JSON and Markdown files
  cole = 2,
}

for option, value in pairs(options) do
  vim.opt[option] = value
end

-- Encoding UTF-8
vim.opt.encoding = 'utf-8'
