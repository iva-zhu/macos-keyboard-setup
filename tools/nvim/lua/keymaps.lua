// Neovim keymaps: Ctrl-hjkl window movement, Ctrl-arrows resize, jj to leave insert mode.

local noarrows = true

if noarrows == true then
  local skillissue = function()
    print("skill issue?")
  end

  vim.keymap.set('n', '<Up>', skillissue, { desc = 'No arrow keys'})
  vim.keymap.set('n', '<Down>', skillissue, { desc = 'No arrow keys'})
  vim.keymap.set('n', '<Left>', skillissue, { desc = 'No arrow keys'})
  vim.keymap.set('n', '<Right>', skillissue, { desc = 'No arrow keys'})
end

-- define common options
local map = vim.keymap.set
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}
-----------------
-- Normal mode --
-----------------
-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Quick insert mode leaving
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Escape insert mode' })
