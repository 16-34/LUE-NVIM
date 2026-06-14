-- snacks
vim.pack.add({
    "https://github.com/folke/snacks.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

local ok, snacks = pcall(require, "snacks")
if not ok then
    return
end

local function git_status_text(lines)
    local text = {}
    for i, line in ipairs(lines) do
        local status = line:sub(1, 2)
        local index_status = status:sub(1, 1)
        local worktree_status = status:sub(2, 2)
        local hl = "SnacksDashboardGitNormal"
        if line:match("^##") then
            hl = "SnacksDashboardGitBranch"
        elseif status:find("U", 1, true) then
            hl = "SnacksDashboardGitConflict"
        elseif index_status ~= " " and index_status ~= "?" then
            hl = "SnacksDashboardGitStaged"
        elseif worktree_status == "D" then
            hl = "SnacksDashboardGitDelete"
        elseif status == "??" then
            hl = "SnacksDashboardGitAdd"
        elseif worktree_status == "M" then
            hl = "SnacksDashboardGitChange"
        end
        table.insert(text, { (i == 1 and "" or "\n") .. line, hl = hl })
    end
    return text
end

snacks.dashboard.sections.git_status = function(opts)
    return function()
        local root = Snacks.git.get_root()
        local lines
        if root then
            lines = vim.fn.systemlist({ "git", "-C", root, "status", "--short", "--branch", "--renames" })
            if vim.v.shell_error ~= 0 then
                lines = { "无法获取 git 状态" }
            end
        else
            lines = { "当前目录不是 git 仓库" }
        end
        return {
            {
                text = git_status_text(lines),
                indent = opts.indent,
            },
        }
    end
end

snacks.setup({
    notifier = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },

    picker = {
        ui_select = true,
        matcher = { frecency = true, cwd_bonus = true, history_bonus = true },
        formatters = { icon_width = 3 },
        win = {
            input = {
                keys = {
                    ["<C-t>"] = { "edit_tab", mode = { "n", "i" } },
                    ["<Tab>"] = { "confirm", mode = { "n", "i" } },
                },
            },
        },
    },

    dashboard = {
        enabled = true,
        width = 50,
        preset = {
            keys = {
                { icon = "󰈞 ", key = "f", desc = "查找文件", action = ":lua Snacks.picker.smart()" },
                { icon = " ", key = "r", desc = "最近文件", action = ":lua Snacks.picker.recent()" },
                { icon = " ", key = "n", desc = "创建新文件", action = ":enew" },
                { icon = " ", key = "m", desc = "Mason 面板", action = ":Mason" },
                { icon = " ", key = "c", desc = "Nvim 配置", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                { icon = " ", key = "q", desc = "离开", action = ":qa" },
            },
            header = [[
  ██╗       ██╗   ██╗   ███████╗
  ██║       ██║   ██║   ██╔════╝
██║       ██║   ██║   █████╗
██║       ██║   ██║   ██╔══╝
  ███████╗  ╚██████╔╝   ███████╗
  ╚══════╝   ╚═════╝    ╚══════╝
]],
        },
        sections = {
            { section = "header" },
            { section = "keys", padding = 1 },
            { pane = 2, icon = " ", title = "最近文件", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "最近目录", section = "projects", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Git 仓库", section = "git_status", indent = 4, padding = 1 },
        },
    },

    terminal = {
        win = {
            width = 0.7,
            height = 0.6,
            position = "float",
            border = "rounded",
        },
    },
    image = {
        enabled = true,
        doc = { enabled = true, inline = false, float = true, max_width = 50, max_height = 50 },
    },
    styles = {
        snacks_image = {
            border = "rounded",
            backdrop = false,
        },
    },
})

-- 颜色
vim.api.nvim_set_hl(0, "SnacksDashboardGitNormal", { fg = "#a6adc8", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardGitBranch", { fg = "#89dceb", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardGitStaged", { fg = "#74c7ec", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardGitAdd", { fg = "#a6e3a1", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardGitChange", { fg = "#f9e2af", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardGitDelete", { fg = "#f38ba8", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardGitConflict", { fg = "#cba6f7", bg = "NONE", bold = true })

-- 键绑定
vim.keymap.set('n', '<leader><leader>f', snacks.picker.smart, { desc = 'Snacks 查找文件' })
vim.keymap.set('n', '<leader><leader>g', snacks.picker.grep, { desc = 'Snacks 查找内容' })
vim.keymap.set('n', '<leader><leader>b', function()
    snacks.picker.buffers({ sort_lastused = true })
end, { desc = 'Snacks 查找标签页' })
vim.keymap.set('n', '<leader><leader>k', snacks.picker.keymaps, { desc = 'Snacks 查找按键映射' })
vim.keymap.set('n', '<leader><leader>h', snacks.picker.help, { desc = 'Snacks 查找帮助文档' })
vim.keymap.set("n", "<leader><leader>d", snacks.picker.diagnostics_buffer, { desc = "Snacks 查找诊断信息", })
vim.keymap.set("n", "<leader><leader>/", snacks.picker.lines, { desc = "Snacks 在当前文件模糊查找", })

vim.keymap.set("n", "<leader><leader>n", snacks.notifier.show_history, { desc = "Snacks 查看通知历史" })
vim.keymap.set('n', '<leader><leader>i', snacks.picker.lsp_incoming_calls, { desc = 'Snacks 查看谁调用了当前函数' })
vim.keymap.set('n', '<leader><leader>t', snacks.picker.treesitter, { desc = 'Snacks 查找语法树' })
vim.keymap.set('n', '<leader><leader>s', snacks.picker.lsp_symbols, { desc = 'Snacks 查找 lsp 符号' })

vim.keymap.set('n', '<leader>t', snacks.explorer.open, { desc = 'Snacks 文件树' })

vim.keymap.set('n', 'gr', function()
    snacks.picker.lsp_references({ include_current = true })
end, { desc = 'Snacks 查找引用' })

vim.keymap.set({ "n", "t" }, "<C-`>", snacks.terminal.toggle, { desc = "ToggleTerm 切换终端" })

vim.keymap.set("n", "<leader><leader>z", function()
    snacks.zen()
end, { desc = "Snacks 禅模式" }
)
