-- markdown 渲染
vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    -- 'https://github.com/nvim-mini/mini.nvim',            -- if you use the mini.nvim suite
    -- 'https://github.com/nvim-mini/mini.icons',        -- if you use standalone mini plugins
    'https://github.com/nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

local ok, render_markdown = pcall(require, 'render-markdown')

if not ok then
    return
end
render_markdown.setup({}) -- only mandatory if you want to set custom options

-- 安装依赖
local ok, treesitter = pcall(require, "nvim-treesitter")
if ok then
    treesitter.install({
        "markdown",
        "markdown_inline",
        "latex",
        "html",
        "yaml",
    }, { max_jobs = 1 })
end

-- pipx install pylatexenc 或 npm install -g libtexprintf
