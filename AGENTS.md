# AstroNvim Configuration - Agent Guidelines

This is a personal Neovim configuration based on AstroNvim v5+. This configuration uses Lazy.nvim for plugin management and includes community packs for various languages and tools.

## Project Structure

```
.
├── init.lua              # Bootstraps Lazy.nvim
├── lua/
│   ├── lazy_setup.lua    # Main lazy.nvim configuration
│   ├── polish.lua        # Custom commands and autocommands
│   ├── community.lua     # AstroCommunity plugin imports
│   └── plugins/          # Individual plugin configurations
└── after/
    └── plugin/           # Post-load plugin scripts
```

## Build/Test Commands

### Neovim Operations
- **Start Neovim**: `nvim`
- **Plugin Management**: `:Lazy` (update, clean, sync plugins)
- **Mason Management**: `:Mason` (LSP/formatter/linter installation)
- **Health Check**: `:checkhealth` (verify Neovim and plugin status)

### Testing (Neotest)
- **Run tests**: Use `:Neotest` commands within Neovim
- **Jest adapter**: `./node_modules/.bin/jest` (JavaScript/TypeScript)
- **Python adapter**: Uses pytest with DAP support
- **Test discovery**: Enabled automatically for Jest

### Formatting/Linting
- **Format on save**: Enabled by default (LSP-based)
- **Timeout**: 1000ms
- **Stylua**: Lua code formatting (see `.stylua.toml`)
- **Selene**: Lua linting (see `selene.toml`)
- **None-ls**: Additional formatters/linters (currently disabled)

### Git Operations
- **Neogit**: `:G` or `:Neogit` (git interface)
- **Conventional commits**: Short, one-line format
- **WIP commits**: Mark as "wip" to skip hooks if commit fails

## Code Style Guidelines

### Lua Conventions

#### Indentation & Formatting
- **Indent**: 2 spaces (defined in `.stylua.toml`)
- **Line width**: 120 characters maximum
- **Line endings**: Unix (LF)
- **Quote style**: Auto-prefer double quotes
- **Call parentheses**: None (omit parens for single-arg function calls)
- **Statement collapsing**: Always collapse simple statements

#### Type Annotations
- Use LSP type annotations with `---@type` and `---@param`
- Example: `---@type LazySpec` at top of plugin files
- Use `---@diagnostic disable: missing-fields` when intentionally omitting fields

#### Comments
- Inline comments for logic explanation
- `stylua: ignore` to skip formatting for specific lines
- Multi-line comments for function/section documentation

#### Naming Conventions
- **Files**: Lowercase with hyphens (e.g., `neo-tree.lua`, `git-conflict-nvim.lua`)
- **Functions**: snake_case (e.g., `get_git_root`, `copy_relative_path`)
- **Variables**: snake_case (e.g., `current_file_path`, `git_root`)
- **Constants**: UPPER_SNAKE_CASE (not prevalent in this config)

#### Module Structure
```lua
---@type LazySpec
return {
  "plugin/name",
  opts = {
    -- plugin options
  },
  config = function(plugin, opts)
    -- setup logic
  end,
}
```

#### Error Handling
- Use `pcall` for operations that might fail
- Check `vim.v.shell_error` after system commands
- Provide informative notifications via `vim.notify`
- Validate inputs before operations (e.g., check if buffer has file path)
- Use different log levels: `vim.log.levels.ERROR`, `.WARN`, `.INFO`

Example:
```lua
local success, result = pcall(vim.fn.systemlist, 'git rev-parse --show-toplevel')
if not success then
  vim.notify("Failed to execute: " .. vim.inspect(result), vim.log.levels.ERROR)
  return nil
end
if vim.v.shell_error == 0 then
  -- success
else
  vim.notify("Command failed with exit code " .. vim.v.shell_error, vim.log.levels.ERROR)
end
```

#### Plugin Configuration Patterns
1. **Lazy loading**: Use `event`, `cmd`, `keys` for conditional loading
2. **Dependencies**: Declare in `dependencies` array
3. **Options extension**: Use `opts` function with `_, opts` parameters
4. **Conditional loading**: Use `cond` function for environment checks
5. **Community imports**: Import from `astrocommunity.*` in `community.lua`

### Import Conventions
- Core AstroNvim: `{ import = "astronvim.plugins" }`
- Community packs: `{ import = "astrocommunity.pack.typescript-all-in-one" }`
- Local plugins: `{ import = "plugins" }`
- Order: AstroNvim core → community → local plugins

### Function Definitions
```lua
-- Prefer local functions
local function my_function(param)
  -- implementation
end

-- For callbacks in config
config = function(plugin, opts)
  -- setup
end
```

### User Commands
```lua
vim.api.nvim_create_user_command(
  'CommandName',
  function_reference,
  { nargs = 0, bar = true, desc = "Description" }
)
```

### Keymaps
- Define in `astrocore` plugin's `mappings` table
- Structure: `mode -> key -> {function, desc}`
- Use `false` to disable default mappings
- Access via `<Leader>` (space) or `<LocalLeader>` (comma)

## Common Patterns

### Checking File System
```lua
if not vim.loop.fs_stat(directory) then
  vim.notify("Directory not found", vim.log.levels.WARN)
  return nil
end
```

### Path Manipulation
```lua
local normalized = vim.fs.normalize(path)
local filename = vim.fn.fnamemodify(path, ':t')  -- tail (basename)
local dir = vim.fn.fnamemodify(path, ':h')       -- head (directory)
```

### Accessing Registers
```lua
vim.fn.setreg('+', value)  -- system clipboard
```

## Project-Specific Notes

### Disabled Features
- `vim.opt.clipboard = ""` (manual clipboard management)
- `none-ls.nvim` (disabled via guard: `if true then return {} end`)
- `user.lua` examples (disabled via guard)

### Custom Commands
- `:CopyRelativePath` - Copy file path relative to git root
- `:CopyFullPath` - Copy absolute file path
- `:CopyFileName` - Copy filename only
- `:G` - Open Neogit

### Language Support
Installed via AstroCommunity:
- TypeScript/JavaScript (all-in-one pack)
- Python (ruff)
- Lua, HTML/CSS, JSON, Markdown, MDX
- Prisma, SQL, Tailwind CSS, Terraform, YAML, Go

### AI/Copilot
- Copilot enabled with custom keymaps (Meta+l to accept)
- CopilotChat enabled for AI assistance
- CodeCompanion enabled

## MCP Integrations (from .claude/CLAUDE.md)
- **github**: Interact with GitHub (repos, issues, PRs, commits, CI)
- **context7**: Documentation lookup for external libraries
- **graphql-execute**: GraphQL queries/mutations
- **playwright**: Web page checking, HTML structure, scraping
- **ESLint**: Linter interaction

## Context Management
- Be conservative with context pollution
- Use LSP for navigation and error checking
- Read minimal lines when possible
- Filter MCP results appropriately

## Git Workflow
- Short conventional commit messages
- Commit frequently to preserve progress
- Skip hooks with WIP markers if needed
- Don't include too many files per commit
- **Never commit**: Ask user to commit instead

## AstroNvim Documentation & Resources

### Official Documentation
- **Main Docs**: https://docs.astronvim.com
- **V5 Migration Guide**: https://docs.astronvim.com/configuration/v5_migration/
- **AstroCommunity**: https://astronvim.github.io/astrocommunity/
- **AstroCommunity Repo**: https://github.com/AstroNvim/astrocommunity
- **AstroNvim Core Repo**: https://github.com/AstroNvim/AstroNvim

### Core Modules Help
Inside Neovim, access help with `:h <module>`:
- `:h astrocore` - Core features (mappings, options, autocommands)
- `:h astrolsp` - LSP configuration and features
- `:h astroui` - UI components and statusline
- `:h astrotheme` - Theme configuration

### Community Packs
Browse available plugins and packs at: https://astronvim.github.io/astrocommunity/
- Language packs (e.g., `astrocommunity.pack.typescript-all-in-one`)
- Motion plugins (e.g., `astrocommunity.motion.flash-nvim`)
- Git tools (e.g., `astrocommunity.git.neogit`)
- Testing tools (e.g., `astrocommunity.test.neotest`)

## Debugging & Troubleshooting

### Health Checks
Run comprehensive diagnostics:
```vim
:checkhealth                    " Check all modules
:checkhealth astronvim          " Check AstroNvim specific
:checkhealth mason              " Check Mason LSP installations
:checkhealth lazy               " Check Lazy.nvim plugin manager
```

### Plugin Management & Debugging

#### Check Installed Plugins
```vim
:Lazy                           " Open Lazy.nvim UI
:Lazy home                      " View all plugins
:Lazy log                       " View plugin change log
:Lazy profile                   " Profile plugin load times
:Lazy sync                      " Update + clean + install
```

#### Find Plugin Source Code
1. **Via Lazy.nvim**: `:Lazy` → select plugin → press `<CR>` to see details
2. **File system**: `~/.local/share/nvim/lazy/<plugin-name>/`
3. **GitHub**: Most plugins are at `github.com/<org>/<repo>`
4. **Check lazy-lock.json**: See exact commit for each plugin

#### Debugging Plugin Conflicts

**Step 1: Identify the issue**
```vim
:messages                       " View recent error messages
:Lazy log <plugin-name>         " Check plugin-specific logs
:set verbose=9                  " Enable verbose logging
```

**Step 2: Check load order**
```vim
:Lazy profile                   " See load times and sequence
```

**Step 3: Isolate the problem**
- Temporarily disable plugins by adding `enabled = false` to plugin spec
- Use `cond = false` for conditional disabling
- Check `lua/plugins/<plugin>.lua` for conflicts

**Step 4: Common conflict patterns**
- **Keymap conflicts**: Two plugins binding same key
  - Check: `:map <key>` to see all bindings for a key
  - Fix: Override in `astrocore` mappings or disable in plugin config
- **LSP conflicts**: Multiple LSP servers for same filetype
  - Check: `:LspInfo` to see active servers
  - Fix: Configure in `astrolsp` config
- **Autocommands conflicts**: Multiple plugins creating same autocmds
  - Check: `:autocmd <event>` to list all autocommands
  - Fix: Override in `polish.lua`

#### Plugin Priority & Load Order
From `lazy_setup.lua`:
1. **AstroNvim core** (`import = "astronvim.plugins"`) - Loads first
2. **Community imports** (`import = "community"`) - Loads second
3. **Local plugins** (`import = "plugins"`) - Loads last (can override)

**Override community/core plugins**: Create file in `lua/plugins/` with same plugin name

### Common Issues

#### LSP Not Working
```vim
:LspInfo                        " Check active LSP servers
:Mason                          " Verify LSP is installed
:checkhealth astronvim          " Check for LSP issues
```

#### Formatting Not Working
```vim
:AstroLspFormatInfo            " Check formatter status
:Mason                          " Verify formatter is installed
" Check lua/plugins/astrolsp.lua for format_on_save config
```

#### Plugin Not Loading
1. Check if disabled: `:Lazy` and search for plugin
2. Check conditions: Look for `cond` or `enabled` in plugin spec
3. Check events: Lazy loading via `event`, `cmd`, or `keys` might delay load
4. Force load: `:Lazy load <plugin-name>`

#### Performance Issues
```vim
:Lazy profile                   " Identify slow plugins
:checkhealth                    " Find issues
" Check lua/plugins/astrocore.lua - large_buf settings disable features for big files
```

### Debugging Lua Code

#### Print Debugging
```lua
-- Use vim.notify for visible messages
vim.notify("Debug: " .. vim.inspect(variable), vim.log.levels.INFO)

-- Use print for messages buffer
print("Value:", vim.inspect(table))

-- Check messages
-- :messages
```

#### Inspect Variables
```lua
-- Pretty print tables
vim.print(some_table)

-- Inspect with metadata
print(vim.inspect(value))
```

#### Error Traces
```lua
-- Wrap potentially failing code
local ok, result = pcall(function()
  -- potentially failing code
end)
if not ok then
  vim.notify("Error: " .. result, vim.log.levels.ERROR)
end
```

### Logs Location
- **Neovim log**: `~/.local/state/nvim/log`
- **Lazy.nvim**: `:Lazy log`
- **LSP logs**: `:LspLog`
- **Mason logs**: Check `:Mason` UI

## Finding Plugin Configuration

### Plugin Source Priority
1. **Local config**: `lua/plugins/<plugin-name>.lua` (highest priority)
2. **Community config**: From `lua/community.lua` imports
3. **AstroNvim defaults**: From AstroNvim core
4. **Plugin defaults**: From plugin's own source

### Locating Plugin Files
```bash
# Local configuration
ls lua/plugins/

# Installed plugin source code
ls ~/.local/share/nvim/lazy/<plugin-name>/

# Community plugin source
ls ~/.local/share/nvim/lazy/astrocommunity/lua/astrocommunity/
```

### Reading Plugin Docs
1. **In Neovim**: `:h <plugin-name>`
2. **GitHub**: Most plugins have README with full docs
3. **Lazy.nvim**: `:Lazy` → select plugin → see description and links
4. **Source code**: Check plugin's `lua/` directory for implementation
