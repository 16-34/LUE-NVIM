vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
})

local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"

local colors = {
    text = "#cdd6f4",
    muted = "#6c7086",
    blue = "#89b4fa",
    green = "#a6e3a1",
    yellow = "#f9e2af",
    red = "#f38ba8",
    mauve = "#cba6f7",
    peach = "#fab387",
}

local theme = {
    normal = {
        a = { fg = colors.blue, bg = "NONE", gui = "bold" },
        b = { fg = colors.text, bg = "NONE" },
        c = { fg = colors.text, bg = "NONE" },
    },
    insert = { a = { fg = colors.green, bg = "NONE", gui = "bold" } },
    visual = { a = { fg = colors.mauve, bg = "NONE", gui = "bold" } },
    replace = { a = { fg = colors.red, bg = "NONE", gui = "bold" } },
    command = { a = { fg = colors.peach, bg = "NONE", gui = "bold" } },
    terminal = { a = { fg = colors.green, bg = "NONE", gui = "bold" } },
    inactive = {
        a = { fg = colors.muted, bg = "NONE" },
        b = { fg = colors.muted, bg = "NONE" },
        c = { fg = colors.muted, bg = "NONE" },
    },
}

local mode_names = {
    n = "󰆍 NORMAL",
    no = "󰆍 O-PENDING",
    i = "󰏫 INSERT",
    ic = "󰏫 INSERT",
    v = "󰈈 VISUAL",
    V = "󰈈 V-LINE",
    ["\22"] = "󰈈 V-BLOCK",
    R = "󰛔 REPLACE",
    Rv = "󰛔 V-REPLACE",
    c = "󰘳 COMMAND",
    cv = "󰘳 EX",
    ce = "󰘳 EX",
    s = "󰒅 SELECT",
    S = "󰒅 S-LINE",
    ["\19"] = "󰒅 S-BLOCK",
    t = "󰆍 TERMINAL",
}

local function mode()
    return mode_names[vim.fn.mode(1)] or mode_names[vim.fn.mode()] or "󰆍 UNKNOWN"
end

local function recording()
    local register = vim.fn.reg_recording()
    return register ~= "" and ("󰑋 REC @" .. register) or ""
end

local function lsp_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ""
    end

    local names = {}
    for _, client in ipairs(clients) do
        if client.name ~= "copilot" then
            names[#names + 1] = client.name
        end
    end

    return #names > 0 and ("󰒋 " .. table.concat(names, ", ")) or ""
end

local progress_icons = { "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" }
local function progress()
    local current = vim.fn.line(".")
    local total = math.max(vim.fn.line("$"), 1)
    local index = math.ceil(current / total * #progress_icons)
    return string.format("%s %d%%%%", progress_icons[math.max(1, index)], math.floor(current / total * 100))
end

local recording_group = vim.api.nvim_create_augroup("LualineRecording", { clear = true })
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
    group = recording_group,
    callback = function()
        require("lualine").refresh({ place = { "statusline" } })
    end,
})

lualine.setup({
    options = {
        theme = theme,
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = { "dashboard", "snacks_dashboard" },
        },
        refresh = {
            statusline = 500,
        },
    },
    sections = {
        lualine_a = {
            { mode, padding = { left = 1, right = 1 } },
        },
        lualine_b = {
            { "branch", icon = "", color = { fg = colors.mauve } },
            {
                "diff",
                symbols = { added = " ", modified = " ", removed = " " },
                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.yellow },
                    removed = { fg = colors.red },
                },
            },
        },
        lualine_c = {
            {
                "filename",
                path = 1,
                symbols = {
                    modified = " 󱇨",
                    readonly = " 󰌾",
                    unnamed = "[No Name]",
                    newfile = " 󰈔",
                },
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
                diagnostics_color = {
                    error = { fg = colors.red },
                    warn = { fg = colors.yellow },
                    info = { fg = colors.blue },
                    hint = { fg = colors.muted },
                },
            },
            { lsp_clients, color = { fg = colors.blue } },
            {
                "encoding",
                cond = function()
                    return vim.bo.fileencoding ~= "" and vim.bo.fileencoding ~= "utf-8"
                end,
            },
            {
                "fileformat",
                symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
                cond = function()
                    return vim.bo.fileformat ~= "unix"
                end,
            },
            { "filetype", colored = false },
            { "location", icon = "󰍒" },
            { progress, color = { fg = colors.blue }, padding = { left = 1, right = 1 } },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            { recording, color = { fg = colors.red, gui = "bold" } },
            { "%S",      padding = { left = 1, right = 1 } },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "oil", "quickfix" },
})
