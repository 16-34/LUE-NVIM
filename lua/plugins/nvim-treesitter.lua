-- AST
vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter"
})

local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then
    return
end

-- 报错解决： brew install tree-sitter-cli
treesitter.setup()
treesitter.install({
    "c",
    "cpp",
    "lua",
    "python",
    "markdown",
    "markdown_inline",
    "bash",
    "zsh",
}, { max_jobs = 1 })

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "c",
        "cpp",
        "lua",
        "python",
        "markdown",
        "sh",
        "zsh",
    },
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
