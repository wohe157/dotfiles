-- Function to set key mappings easily
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Use <C-h/j/k/l> to move the cursor among windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Use Tab or Shift-Tab to change the indentation repeatedly
map("n", "<Tab>", ">")
map("n", "<S-Tab>", "<")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Move current line / block with Alt-j/k similar to vscode
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '>-2<CR>gv=gv")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
