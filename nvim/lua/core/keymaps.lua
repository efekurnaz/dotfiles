-- Search and replace keymaps
vim.keymap.set('n', '<leader>S', ':%s/\\v//gc<left><left><left><left>', { desc = 'Search and replace in file' })
vim.keymap.set('v', '<leader>s', ':s/\\v//gc<left><left><left><left>', { desc = 'Search and replace in selection' })

-- Use telescope for better search experience
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').live_grep, { desc = 'Search text in workspace' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Search current word' })
