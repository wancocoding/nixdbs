vim.api.nvim_set_keymap("n", "<leader>F", "<cmd>Format<cr>", {silent = true})

require("formatter").setup(
  {
    logging = false,
    filetype = {
			cpp = {
        -- clang-format
        function()
          return {
            exe = "clang-format",
            args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
            stdin = true,
            cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
          }
        end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      python = {
        -- black
        function()
          return {
            exe = "black",
            args = {"--fast", "--line-length", 80, "-q", "-"},
            stdin = true
          }
        end
      },
      go = {
        -- gofmt
        function()
          return {
            exe = "gofmt",
            args = {},
            stdin = true
          }
        end
      },
      json = {
        -- use python json.tool to format json
        function()
          return {
            exe = "python3",
            args = {"-m", "json.tool"},
            stdin = true
          }
        end
      },
      rust = {
        -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--line-width", 79, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

