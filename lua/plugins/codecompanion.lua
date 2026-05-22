---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings = opts.mappings or {}
        opts.mappings.n = opts.mappings.n or {}
        opts.mappings.n["<Leader>Ao"] = {
          function()
            local cc = require "codecompanion.config"
            local cur = cc.config.interactions.chat.adapter
            local next_adapter = cur == "ollama" and "claude_code" or "ollama"
            cc.config.interactions.chat.adapter = next_adapter
            cc.config.interactions.inline.adapter = next_adapter == "ollama" and "ollama" or "copilot"
            cc.config.interactions.cmd.adapter = next_adapter == "ollama" and "ollama" or "copilot"
            vim.notify("CodeCompanion adapter: " .. next_adapter, vim.log.levels.INFO)
          end,
          desc = "Toggle ollama / online adapter",
        }
      end,
    },
  },
  opts = {
    display = {
      diff = {
        enabled = true,
        threshold_for_chat = 12,
        word_highlights = {
          additions = true,
          deletions = true,
        },
      },
    },
    adapters = {
      http = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://localhost:11434",
            },
            schema = {
              model = {
                default = "qwen3.6:35b-a3b",
              },
              num_ctx = {
                default = 16384,
              },
            },
          })
        end,
      },
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN =
              "cmd:op --account my.1password.eu read op://dev/CLAUDE_CODE_OAUTH_TOKEN/password --no-newline",
            },
            defaults = {
              mcpServers = "inherit_from_config",
            },
          })
        end,
        codex = function()
          return require("codecompanion.adapters").extend("codex", {
            defaults = {
              auth_method = "chatgpt",
              session_config_options = {
                mode = "Full Access",
                thought_level = "high",
              },
            },
          })
        end,
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              auth_method = "oauth-personal",
              timeout = 30000,
              session_config_options = {
                model = "gemini-3.1-pro",
              },
            },
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = "claude_code",
      },
      inline = {
        adapter = "copilot",
      },
      cmd = {
        adapter = "copilot",
      },
      cli = {
        agent = "claude_code",
        agents = {
          claude_code = {
            cmd = "claude",
            args = {},
            description = "Claude Code CLI",
          },
          codex = {
            cmd = "codex",
            args = {},
            description = "OpenAI Codex CLI",
          },
          gemini = {
            cmd = "gemini",
            args = {},
            description = "Gemini CLI",
          },
          opencode = {
            cmd = "opencode",
            args = {},
            description = "OpenCode CLI",
          },
        },
      },
    },
    rules = {
      default = {
        description = "Common project rule files",
        files = {
          ".clinerules",
          ".cursorrules",
          ".rules",
          ".windsurfrules",
          ".github/copilot-instructions.md",
          "AGENT.md",
          "AGENTS.md",
          { path = "CLAUDE.md",           parser = "claude" },
          { path = "CLAUDE.local.md",     parser = "claude" },
          { path = ".claude/CLAUDE.md",   parser = "claude" },
          { path = "~/.claude/CLAUDE.md", parser = "claude" },
        },
      },
      opts = {
        chat = {
          ---@param chat CodeCompanion.Chat
          ---@return boolean
          condition = function(chat) return chat.adapter.type == "http" end,
        },
      },
    },
  },
}
