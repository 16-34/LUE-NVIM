# LUE-NVIM

个人 Neovim 配置仓库。

## 目录结构

```text
.
├── init.lua                  # 配置入口，加载 custom、plugins 模块
├── lsp/                      # Neovim 原生 LSP 服务配置
│   ├── clangd.lua            # C/C++ LSP
│   ├── lua_ls.lua            # Lua LSP
│   ├── pyright.lua           # Python 类型检查 LSP
│   └── ruff.lua              # Python Ruff LSP
├── lua/
│   ├── custom/               # 基础编辑体验配置
│   │   ├── appearence.lua    # 配色、外观
│   │   ├── autocmd.lua       # 文件类型相关自动命令
│   │   ├── keymaps.lua       # 全局快捷键
│   │   ├── lsp.lua           # LSP 启用、诊断和 LSP 快捷键
│   │   └── options.lua       # 行号、缩进、搜索、分屏等基础选项
│   └── plugins/              # 插件配置
│       ├── blink.lua         # 补全
│       ├── conform.lua       # 格式化
│       ├── dropbar.lua       # 面包屑导航
│       ├── flash.lua         # 快速跳转
│       ├── im-select.lua     # 自动切换输入法
│       ├── lualine.lua       # 状态栏
│       ├── mason.lua         # Mason 管理界面
│       ├── mini.lua          # 多功能插件：mini.move、mini.pairs、mini.surround
│       ├── noice.lua         # 命令行和输入框
│       ├── nvim-dap.lua      # 调试
│       ├── nvim-treesitter.lua # Treesitter 高亮
│       ├── nvim-ufo.lua      # 代码折叠
│       ├── oil.lua           # 目录编辑式文件管理
│       ├── snacks.lua        # 多功能插件：dashboard、picker、文件数、浮动终端、图片渲染
│       └── which-key.lua     # 快捷键提示
└── nvim-pack-lock.json       # 插件锁定文件
```

## 安装

将仓库放到 Neovim 配置目录：

```sh
git clone --depth 1 https://github.com/16-34/LUE-NVIM ~/.config/nvim
```

首次启动时，`vim.pack.add` 会按配置拉取插件。部分语言服务、formatter、调试器和输入法切换工具需要提前安装到系统 `PATH`。

## 环境要求

- Neovim：需要支持 `vim.pack.add`、`vim.lsp.enable` 和 `vim.o.winborder` 的版本。
- Git：用于拉取插件。
- 推荐命令行工具：`ripgrep`、`fd`、`cmake`。
- LSP 可执行文件：`ruff`、`pyright-langserver`、`lua-language-server`、`clangd`（部分可在 Mason 安装）。
- Formatter：Python 使用 `ruff`，Markdown 使用 `prettier`；未配置 formatter 时回退到 LSP 格式化。
- 调试器或调试适配器：`python`、`lldb-dap`、`codelldb`、`gdb`，按实际语言调试需求安装。
- Markdown 数学公式渲染可选安装 `pylatexenc` 或 `libtexprintf`。
- 输入法切换：终端 Neovim 可选安装 `im-select` 或 `macism`，供 `im-select.nvim` 自动切换输入法；Neovide 本身已有该功能，该插件会自动跳过加载。
- 配色：需要确保 `catppuccin` 主题在 Neovim 中可用，或自行替换 `lua/custom/appearence.lua` 中的配色名称。
- 字体：推荐安装 Nerd Font，以正确显示状态栏和图标。

## 快捷键

Leader 键为 `Space`。

| 模式      | 快捷键       | 功能                    |
| --------- | ------------ | ----------------------- |
| 普通      | `<leader>f`  | 使用 Conform 格式化文件 |
| 普通      | `<leader>w`  | 保存文件                |
| 普通      | `<leader>q`  | 关闭当前窗口            |
| 普通      | `<leader>nh` | 取消搜索高亮            |
| 普通      | `U`          | 重做                    |
| 普通/插入 | `<M-z>`      | 切换当前窗口折行        |

### 窗口与终端

| 模式      | 快捷键                         | 功能             |
| --------- | ------------------------------ | ---------------- |
| 普通      | `<leader>\|`                   | 水平分割窗口     |
| 普通      | `<leader>\\`                   | 垂直分割窗口     |
| 普通      | `<leader><Left/Right/Up/Down>` | 在窗口之间移动   |
| 普通      | `<leader>x`                    | 关闭当前分割窗口 |
| 普通/终端 | <kbd>Ctrl</kbd> + <kbd>`</kbd> | 切换浮动终端     |
| 终端      | `<Esc>`                        | 退出终端模式     |

### 插入与可视模式

| 模式         | 快捷键                                  | 功能                  |
| ------------ | --------------------------------------- | --------------------- |
| 插入         | `<M-Left>` / `<M-Right>`                | 按词向左/向右移动光标 |
| 插入         | `<C-a>` / `<C-e>`                       | 移动到行首/行尾       |
| 插入/可视    | `<M-[>` / `<M-]>`                       | 向左/向右调整缩进     |
| 插入/可视    | `<M-j>` / `<M-k>`                       | 向下/向上调整缩进     |
| Neovide 插入 | <kbd>Cmd</kbd> + `s`                    | 保存                  |
| Neovide 插入 | <kbd>Cmd</kbd> + `z`                    | 撤销                  |
| Neovide 插入 | <kbd>Cmd</kbd> + <kbd>Shift</kbd> + `z` | 重做                  |

### 插件功能

| 模式             | 快捷键      | 功能                        |
| ---------------- | ----------- | --------------------------- |
| 普通             | `?`         | 打开 `which-key` 快捷键提示 |
| 普通             | `-`         | 打开 `Oil` 文件管理         |
| Oil              | `q`         | 关闭当前 Oil Buffer         |
| 普通/可视/操作符 | `s`         | 使用 `flash.nvim` 快速跳转  |
| 普通             | `<leader>t` | 打开 `Snacks` 文件树        |
| 普通             | `<leader>o` | 切换代码大纲                |
| 普通             | `zR` / `zM` | 展开/关闭所有折叠           |
| 普通             | `gsa`       | 添加包围符号                |
| 普通             | `gsd`       | 删除包围符号                |
| 普通             | `gsr`       | 替换包围符号                |

### 查找与检索

| 快捷键              | 功能                    |
| ------------------- | ----------------------- |
| `<leader><leader>f` | 查找文件                |
| `<leader><leader>g` | 全局搜索内容            |
| `<leader><leader>b` | 查找 Buffer             |
| `<leader><leader>h` | 查找帮助文档            |
| `<leader><leader>k` | 查找按键映射            |
| `<leader><leader>/` | 在当前文件中模糊查找    |
| `<leader><leader>n` | 查看通知历史            |
| `<leader><leader>d` | 查看当前 Buffer 诊断    |
| `<leader><leader>i` | 查看 LSP incoming calls |
| `<leader><leader>t` | 查找 Treesitter 节点    |
| `<leader><leader>s` | 查找 LSP 符号           |
| `<leader><leader>z` | 切换禅模式              |

### LSP

| 快捷键       | 功能                       |
| ------------ | -------------------------- |
| `gd`         | 在垂直分屏中跳转到定义     |
| `gt`         | 在垂直分屏中跳转到类型定义 |
| `gr`         | 使用 Snacks 查找引用       |
| `gi`         | 在垂直分屏中跳转到实现     |
| `r`          | 重命名符号                 |
| `<leader>ca` | 执行代码动作               |
| `<leader>dn` | 跳转到下一个诊断           |
| `<leader>dp` | 跳转到上一个诊断           |
| `<leader>dv` | 开启或关闭诊断虚拟行       |

### 调试

| 快捷键                   | 功能           |
| ------------------------ | -------------- |
| `<leader>du`             | 切换 DAP UI    |
| `<leader>dU`             | 重置 DAP UI    |
| `<leader>ds` / `<F5>`    | 开始或继续调试 |
| `<leader>dc`             | 运行到光标处   |
| `<leader>dq`             | 终止调试       |
| `<leader>dr`             | 重启当前调试帧 |
| `<leader>do` / `<F10>`   | Step over      |
| `<leader>di` / `<F11>`   | Step into      |
| `<leader>dO` / `<S-F11>` | Step out       |
| `<leader>db`             | 切换断点       |
| `<leader>dB`             | 设置条件断点   |
| `<leader>dD`             | 清空断点       |
