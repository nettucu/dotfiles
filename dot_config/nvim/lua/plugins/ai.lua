return {
  -- Claude Code Bridge
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "ClaudeCode",
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude Code (Agent)" },
    },
    opts = {
      window = { position = "right", split_ratio = 0.4 },
    },
  },

  -- Codex Bridge (Static integration for your OpenAI account)
  {
    "ishiooon/codex.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = "Codex",
    keys = {
      { "<leader>cx", "<cmd>Codex<cr>", desc = "Codex (Agent)" },
    },
    opts = {},
  },

  -- 1. Agentic.nvim: The UI for your Claude, Codex, and Gemini CLI agents
  {
    "carlos-algms/agentic.nvim",

    opts = {
      -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp"
      provider = "claude-acp", -- setting the name here is all you need to get started
    },

    -- these are just suggested keymaps; customize as desired
    keys = {
      {
        "<C-\\>",
        function()
          require("agentic").toggle()
        end,
        mode = { "n", "v", "i" },
        desc = "Toggle Agentic Chat",
      },
      {
        "<C-'>",
        function()
          require("agentic").add_selection_or_file_to_context()
        end,
        mode = { "n", "v" },
        desc = "Add file or selection to Agentic to Context",
      },
      {
        "<C-,>",
        function()
          require("agentic").new_session()
        end,
        mode = { "n", "v", "i" },
        desc = "New Agentic Session",
      },
      {
        "<A-i>r", -- ai Restore
        function()
          require("agentic").restore_session()
        end,
        desc = "Agentic Restore session",
        silent = true,
        mode = { "n", "v", "i" },
      },
    },
  },

  -- 2. CodeCompanion: Excellent for general chat using Gemini (Free/Pro)
  -- Gemini allows 1500+ requests per day on their free tier via AI Studio
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {
      strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
      },
    },
  },
}
