-- 代码格式化
vim.pack.add({
    "https://github.com/stevearc/conform.nvim"
})

local ok, conform = pcall(require, "conform")
if not ok then
    return
end

conform.setup({
    formatters_by_ft = {
        markdown = { "prettier" },
        python = { "ruff_format" },
    },
    format_on_save = function(bufnr)
        local formatters = conform.list_formatters_for_buffer(bufnr)

        return {
            timeout_ms = 3000,
            lsp_fallback = #formatters == 0,
        }
    end,
})

vim.keymap.set("n", "<leader>f", function()
    conform.format({
        async = true,
        lsp_format = "fallback",
    })
end, { desc = "Conform 代码格式化" })
