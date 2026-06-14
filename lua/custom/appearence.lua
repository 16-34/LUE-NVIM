-- 配色
vim.cmd.colorscheme("catppuccin")

vim.api.nvim_set_hl(0, "StatusLine", {
    fg = "#ffffff",
    bg = "NONE",
    bold = true
})

-- 全局浮窗边框，Neovim 0.11+
vim.o.winborder = "rounded"

vim.api.nvim_set_hl(0, "NormalFloat", {
    fg = "#ffffff",
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "FloatBorder", {
    fg = "#ffffff",
    bg = "NONE",
})

-- 窗格线
vim.api.nvim_set_hl(0, "WinSeparator", {
    fg = "#ffffff",
    bg = "NONE",
    -- bold = true,
})

-- 状态栏
vim.opt.laststatus = 3
-- vim.opt.cmdheight = 0
vim.opt.showmode = false

if vim.g.neovide then
    vim.g.neovide_hide_mouse_when_typing = true
    vim.o.guifont = "JetBrainsMono Nerd Font:h14"
    vim.g.neovide_opacity = 0.9
    -- vim.g.neovide_cursor_animation_length = 0.2
    -- vim.g.neovide_scroll_animation_length = 0.1
else
    -- 背景
    vim.api.nvim_set_hl(0, "Normal", {
        bg = "NONE"
    })
end
