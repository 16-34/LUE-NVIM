-- -- 改键
-- 主键
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

local keymap = vim.keymap

-- 代码格式化
keymap.set("n", "<leader>f", "<CMD>lua vim.lsp.buf.format()<CR>", { desc = "代码格式化" })

-- 取消高亮
keymap.set("n", "<leader>nh", "<CMD>nohl<CR>", { desc = "取消高亮" })

-- 重做
keymap.set("n", "U", "<C-r>", { desc = "重做" })

-- 窗格分割
keymap.set("n", "<leader>|", "<CMD>split<CR>", { desc = "水平分割窗格" })
keymap.set("n", "<leader>\\", "<CMD>vsplit<CR>", { desc = "垂直分割窗格" })

-- 窗格跳转
keymap.set("n", "<leader><Left>", "<C-w>h", { desc = "跳转到左边窗格" })
keymap.set("n", "<leader><Right>", "<C-w>l", { desc = "跳转到右边窗格" })
keymap.set("n", "<leader><Up>", "<C-w>k", { desc = "跳转到上方窗格" })
keymap.set("n", "<leader><Down>", "<C-w>j", { desc = "跳转到下方窗格" })
keymap.set("n", "<leader>x", "<C-w>c", { desc = "关闭当前窗格" })
keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "保存" })
keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "关闭" })

-- 光标移动
vim.keymap.set("i", "<M-Left>", "<C-o>b", { desc = "跳转到上一个词" })
vim.keymap.set("i", "<M-Right>", "<C-o>w", { desc = "跳转到下一个词" })
vim.keymap.set("i", "<C-a>", "<Home>", { desc = "跳转到行首" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "跳转到行尾" })

-- 缩进
vim.keymap.set("i", "<M-[>", "<C-d>", { desc = "向左缩进" })
vim.keymap.set("i", "<M-]>", "<C-t>", { desc = "向右缩进" })
vim.keymap.set("n", "<M-[>", "<<", { desc = "向左缩进" })
vim.keymap.set("n", "<M-]>", ">>", { desc = "向右缩进" })
vim.keymap.set("v", "<M-[>", "<gv", { desc = "向左缩进" })
vim.keymap.set("v", "<M-]>", ">gv", { desc = "向右缩进" })

-- 代码块移动
vim.keymap.set({ "i", "n" }, "<M-k>", "<CMD>m .-2<CR>", { desc = "上移一行" })
vim.keymap.set({ "i", "n" }, "<M-j>", "<CMD>m .+1<CR>", { desc = "下移一行" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv", { desc = "上移一行" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv", { desc = "下移一行" })

if vim.g.neovide then
    vim.keymap.set("i", "<D-s>", "<Esc>:w<CR>a", { desc = "保存" })
    vim.keymap.set("i", "<D-z>", "<Esc>ua", { desc = "撤销" })
    vim.keymap.set("i", "<D-Z>", "<Esc><C-r>a", { desc = "重做" })
end

-- 终端
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "退出终端模式" })
vim.keymap.set({ "n", "t" }, "<C-`>", function()
    local term_buf = nil

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" then
            term_buf = buf
            break
        end
    end

    if term_buf then
        local win = vim.fn.bufwinid(term_buf)
        if win ~= -1 then
            vim.api.nvim_win_close(win, true) -- 折叠
        else
            vim.cmd("botright split")
            vim.cmd("buffer " .. term_buf) -- 展开
        end
    else
        vim.cmd("botright split | terminal") -- 首次创建
    end
end, { desc = "切换终端" })

-- 折行
vim.keymap.set({ "n", "i" }, "<M-z>", function()
    local wrap = not vim.opt_local.wrap:get()

    vim.opt_local.wrap = wrap
    vim.opt_local.linebreak = wrap
    vim.opt_local.breakindent = wrap
end, { desc = "切换折行" })
