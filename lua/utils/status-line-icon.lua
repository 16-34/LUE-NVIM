function ModeName()
    local modes = {
        n = "󰆍 NORMAL",
        i = "󰏫 INSERT",
        v = "󰈈 VISUAL",
        V = "󰈈 V-LINE",
        ["\22"] = "󰈈 V-BLOCK",
        R = "󰛔 REPLACE",
        c = "󰘳 COMMAND",
        t = "󰆍 TERMINAL"
    }
    return modes[vim.fn.mode()] or "UNKNOWN"
end

function RecordingStatus()
    local register = vim.fn.reg_recording()
    return register ~= "" and ("󰑋 REC @" .. register) or ""
end

function FileFlags()
    if vim.bo.modified then
        return "󱇨"
    end
    if vim.bo.readonly then
        return "󰌾"
    end
    return "󰈔"
end

function ProgressIcon()
    local chars = { "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" }
    local cur = vim.fn.line(".")
    local total = vim.fn.line("$")

    local i = math.ceil(cur / total * #chars)
    return chars[math.max(1, i)]
end

function FiletypeIcon()
    local icons = {
        lua = "",
        python = "󰌠",
        javascript = "󰌞",
        typescript = "󰛦",
        rust = "󱘗",
        c = "",
        cpp = "",
        java = "",
        go = "",
        markdown = ""
    }
    return icons[vim.bo.filetype] or ""
end

function DiagnosticsCount()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

    return " " .. errors .. "   " .. warnings
end

vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"

local statusline_group = vim.api.nvim_create_augroup("CustomStatusLine", { clear = true })
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
    group = statusline_group,
    callback = function()
        vim.cmd.redrawstatus()
    end,
})

vim.opt.statusline = " %{v:lua.ModeName()}  >  " .. -- 状态
    "%{v:lua.FileFlags()} %f  >  " .. -- 文件名
    "%{v:lua.FiletypeIcon()}  >  " .. -- 文件类型
    "%{v:lua.DiagnosticsCount()}  >  " .. -- 警告
    "↓ %l  → %c  >  " .. -- 行列号
    "%{v:lua.ProgressIcon()} %p%%" .. -- 文件进度
    "%=" .. -- 右对齐
    "%{v:lua.RecordingStatus()}  %S " -- 宏录制、按键
