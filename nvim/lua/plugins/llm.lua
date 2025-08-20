return {
  {
    "github/copilot.vim",
    branch = "release",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    config = function()
      require("CopilotChat").setup()

      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      vim.keymap.set("n", "<leader>cc", chat.open, { silent = true, desc = "Copilot Chat Open" })
      vim.keymap.set("n", "<leader>cq", "<Cmd>CopilotChatBuffer<CR>",
        { silent = true, desc = "Copilot Chat Quick Buffer" })
      vim.keymap.set("x", "<leader>cr", function()
        chat.ask("このコードをリファクタリングしてください", { selection = select.visual })
      end, { silent = true, desc = "Copilot Chat Refactor Selection" })
      vim.keymap.set("x", "<leader>cf", function()
        chat.ask("このコードを修正してください", { selection = select.visual })
      end, { silent = true, desc = "Copilot Chat Fix Selection" })
      vim.keymap.set("n", "<leader>cm", function()
        local diff = table.concat(vim.fn.systemlist('git diff'), '\n')
        local prompt =
            "このgit diffからcommit messageを生成してください．\ncommit messageは英語で簡潔に書いてください．\n ex1) add --- \n ex2) remove --- \n" ..
            diff
        chat.ask(prompt)
      end, { silent = true, desc = "Copilot Chat: Commit message from git diff" })

      vim.api.nvim_create_user_command("CopilotChatBuffer", function()
        vim.ui.input({ prompt = "Quick Chat: " }, function(input)
          if input and input ~= "" then
            chat.ask(input, { selection = select.buffer })
          end
        end)
      end, {})
    end,
  },
}
