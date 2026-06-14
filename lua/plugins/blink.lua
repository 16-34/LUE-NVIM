-- 补全引擎
vim.pack.add({
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = vim.version.range("1.*"), -- 用 release tag，自动下载预编译 fuzzy
    }
})

local ok, blink = pcall(require, "blink.cmp")
if not ok then
    return
end

blink.setup({
    keymap = { preset = "super-tab" },
    -- appearance = {
    --     nerd_font_variant = "mono",
    -- },
    completion = {
        list = {
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },
        menu = {
            auto_show = true,
            border = "rounded",
        },
        documentation = {
            auto_show = true,
            window = {
                border = "rounded",
            },
        },
    },
    sources = {
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
    cmdline = {
        sources = function()
            local cmd_type = vim.fn.getcmdtype()
            if cmd_type == "/" then
                return { "buffer" }
            end

            if cmd_type == ":" then
                return { "cmdline" }
            end

            return {}
        end,
        keymap = {
            preset = "super-tab"
        },
        completion = {
            menu = {
                auto_show = true,
            }
        }
    }
})

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "#aaaaaa", bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#ffffff", bold = true })

vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#aaaaaa", bg = "none" })

vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#ffffff", bold = true })

vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = "#ffffff", bold = true })
