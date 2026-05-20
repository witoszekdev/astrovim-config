---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  opts = {
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
        },
      },
    },
  },
}
