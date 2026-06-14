local function safe_require(module)
    local ok, err = xpcall(function()
        require(module)
    end, debug.traceback)

    if not ok then
        vim.notify(
            "加载模块失败: " .. module .. "\n" .. err,
            vim.log.levels.ERROR
        )
    end
end

local modules = {
    "custom.options",
    "custom.keymaps",
    "custom.lsp",
    "custom.appearence",
    "custom.autocmd",

    -- 插件
    "plugins.nvim-treesitter",

    "plugins.mason",
    "plugins.blink",
    "plugins.nvim-dap",

    "plugins.snacks",
    "plugins.oil",
    "plugins.mini",
    "plugins.flash",
    "plugins.nvim-ufo",

    "plugins.dropbar",
    "plugins.outline",

    "plugins.noice",
    "plugins.which-key",
    "plugins.conform",
    "plugins.render-markdown",
    "plugins.im-select",
}

for _, module in ipairs(modules) do
    safe_require(module)
end
