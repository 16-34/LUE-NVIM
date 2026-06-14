-- mini
vim.pack.add({
    -- "https://github.com/echasnovski/mini.nvim",
    "https://github.com/nvim-mini/mini.surround",
    "https://github.com/nvim-mini/mini.move",
    "https://github.com/nvim-mini/mini.pairs",
})

local surround_ok, mini_surround = pcall(require, "mini.surround")
if surround_ok then
    mini_surround.setup({
        mappings = {
            add = "gsa",
            delete = "gsd",
            replace = "gsr",
            find = "gsf",
            find_left = "gsF",
            highlight = "gsh",
            update_n_lines = "gsn",
        }
    })
end

local move_ok, mini_move = pcall(require, "mini.move")
if move_ok then
    mini_move.setup({
        mappings = {
            left = '<M-[>',
            right = '<M-]>',

            line_left = '<M-[>',
            line_right = '<M-]>',
        },
    })

    -- 重新覆盖可视模式缩进
    vim.keymap.set("v", "<M-[>", "<gv", { desc = "向左缩进" })
    vim.keymap.set("v", "<M-]>", ">gv", { desc = "向右缩进" })
end

local pairs_ok, mini_pairs = pcall(require, "mini.pairs")
if pairs_ok then
    mini_pairs.setup()
end
