local gl = require("galaxyline")
-- local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")

local special_char = {
  logo = "🥥 ",
  end_icon = "🦜",
  git_branch = " ",
  left_sep1 = " ",
  left_sep2 = " ",
  right_sep1 = "",
  right_sep2 = "",
  mode_icon = " ",
  vertical_bar = "▊",
  git_add = "洛", -- ""
  git_modify = "柳", -- "   柳"
  git_remove = " ", -- "   "
  file_ro = "",
  file_unsave = "",
  diagnostic_error = "  ",
  diagnostic_warn = "  ",
  diagnostic_hint = "  ",
  diagnostic_info = "  "
}

local colors = {
  bg = "#222034",
  fg = "#cbdbfc",
  logo_bg = "#e65100",
  end_bg = "#72d572",
  dark_bg = "#212121",
  mode_bg = "#424242",
  yellow = "#fbf236",
  cyan = "#26c6da",
  ocean = "#738ffe",
  darkblue = "#3b50ce",
  green = "#8bc34a",
  orange = "#f57f17",
  violet = "#5e35b1",
  magenta = "#e91e63",
  blue = "#4e6cef",
  red = "#e51c23",
  plum = "#e84e40",
  purple = "#ab47bc",
  gray = "#616161",
  white = "#ffffff",
  milk = "#eeeeee"
}

local mode_alias = {
  ["c"] = "COMMAND",
  ["i"] = "INSERT",
  ["ic"] = "INSERT COMPL",
  ["ix"] = "INSERT COMPL",
  ["multi"] = "MULTI",
  ["n"] = "NORMAL",
  ["ni"] = "(INSERT)",
  ["no"] = "OP PENDING",
  ["R"] = "REPLACE",
  ["Rv"] = "V REPLACE",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  [""] = "S-BLOCK",
  ["t"] = "TERMINAL",
  ["v"] = "VISUAL",
  ["V"] = "V-LINE",
  [""] = "V-BLOCK",
  ["r?"] = ":CONFIRM",
  ["!"] = "SHELL",
  ["r"] = "HIT-ENTER"
}
-- auto change color according the vim mode
local mode_color = {
  ["c"] = colors.milk, -- command
  ["i"] = colors.ocean, --insert
  ["ic"] = colors.purple,
  ["ix"] = colors.purple,
  ["multi"] = colors.purple,
  ["n"] = colors.green,
  ["ni"] = colors.violet,
  ["no"] = colors.magenta,
  ["R"] = colors.yellow,
  ["Rv"] = colors.yellow,
  ["s"] = colors.orange,
  ["S"] = colors.orange,
  [""] = colors.red,
  ["t"] = colors.violet,
  ["v"] = colors.magenta,
  ["V"] = colors.yellow,
  [""] = colors.blue,
  ["r?"] = colors.red,
  ["!"] = colors.blue,
  ["r"] = colors.red
}

local gls = gl.section
gl.short_line_list = {
  "NvimTree",
  "vista",
  "dbui",
  "packer",
  "defx",
  "packager",
  "startify",
  "term",
  "nerdtree",
  "fugitive",
  "fugitiveblame",
  "plug"
}

-- ===========================================
-- Left Section
-- ===========================================
gls.left = {
  -- Logo
  {
    CocoNvimLogo = {
      provider = function()
        return special_char.logo
      end,
      highlight = {colors.bright_text, colors.logo_bg},
      separator = special_char.left_sep2,
      separator_highlight = {colors.logo_bg, colors.mode_bg}
    }
  },
  -- Vim Mode
  {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        local vim_mode = vim.fn.mode()
        local alias = mode_alias[vim_mode]
        local vimmode = "?"
        if alias ~= nil then
          if vim.fn.winwidth(0) > 80 then
            vimmode = alias
          else
            vimmode = alias:sub(1, 1)
          end
        else
          vimmode = vim.fn.mode():byte()
        end
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
        return vimmode .. " " .. special_char.mode_icon
      end,
      highlight = {colors.red, colors.mode_bg},
      separator = special_char.left_sep2,
      separator_highlight = {colors.mode_bg, colors.bg}
    }
  },
  -- Git
  {
    GitIcon = {
      provider = function()
        return special_char.git_branch
      end,
      condition = condition.check_git_workspace,
      highlight = {colors.ocean, colors.bg, "bold"}
    }
  },
  {
    GitBranch = {
      provider = "GitBranch",
      condition = condition.check_git_workspace,
      highlight = {colors.ocean, colors.bg, "bold"},
      separator = " ",
      separator_highlight = {"NONE", colors.bg}
    }
  },
  {
    DiffAdd = {
      provider = "DiffAdd",
      condition = condition.hide_in_width,
      icon = special_char.git_add,
      highlight = {colors.green, colors.bg}
    }
  },
  {
    DiffModified = {
      provider = "DiffModified",
      condition = condition.hide_in_width,
      icon = special_char.git_modify,
      highlight = {colors.orange, colors.bg}
    }
  },
  {
    DiffRemove = {
      provider = "DiffRemove",
      condition = condition.hide_in_width,
      icon = special_char.git_remove,
      highlight = {colors.red, colors.bg}
    }
  },
  {
    FileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = {
        require("galaxyline.provider_fileinfo").get_file_icon_color,
        colors.bg
      }
    }
  },
  {
    FileTypeName = {
      provider = "FileTypeName",
      condition = condition.buffer_not_empty,
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {
        require("galaxyline.provider_fileinfo").get_file_icon_color,
        colors.bg,
        "bold"
      }
    }
  },
  {
    FileName = {
      provider = {"FileName"},
      condition = require("galaxyline.condition").buffer_not_empty,
      highlight = {colors.fg, colors.bg, "bold"}
    }
  },
  {
    FileSize = {
      provider = "FileSize",
      condition = condition.buffer_not_empty,
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.cyan, colors.bg, "bold"}
    }
  }
}

-- ===========================================
-- Middle Section
-- ===========================================

gls.mid = {
  {
    ShowLspClient = {
      provider = "GetLspClient",
      condition = function()
        local tbl = {["dashboard"] = true, [""] = true}
        if tbl[vim.bo.filetype] then
          return false
        end
        return true
      end,
      icon = " LSP:",
      highlight = {colors.yellow, colors.bg, "bold"},
      separator = " ",
      separator_highlight = {"NONE", colors.bg}
    }
  },
  {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = special_char.diagnostic_error,
      highlight = {colors.red, colors.bg}
    }
  },
  {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = special_char.diagnostic_warn,
      highlight = {colors.orange, colors.bg}
    }
  },
  {
    DiagnosticHint = {
      provider = "DiagnosticHint",
      icon = special_char.diagnostic_hint,
      highlight = {colors.cyan, colors.bg}
    }
  },
  {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      icon = special_char.diagnostic_info,
      highlight = {colors.blue, colors.bg}
    }
  }
}

-- ===========================================
-- Right Section
-- ===========================================

gls.right = {
  -- {
  --   FileIcon = {
  --     provider = "FileIcon",
  --     condition = condition.buffer_not_empty,
  --     highlight = {
  --       require("galaxyline.provider_fileinfo").get_file_icon_color,
  --       colors.bg
  --     }
  --   }
  -- },
  -- {
  --   FileTypeName = {
  --     provider = "FileTypeName",
  --     condition = condition.buffer_not_empty,
  --     -- separator = " ",
  --     -- separator_highlight = {"NONE", colors.bg},
  --     highlight = {
  --       require("galaxyline.provider_fileinfo").get_file_icon_color,
  --       colors.bg
  --     }
  --   }
  -- },
  -- {
  --   FileSize = {
  --     provider = "FileSize",
  --     condition = condition.buffer_not_empty,
  --     separator = " ",
  --     separator_highlight = {"NONE", colors.bg},
  --     highlight = {colors.cyan, colors.bg}
  --   }
  -- },
  {
    LineInfo = {
      provider = "LineColumn",
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.fg, colors.bg}
    }
  },
  {
    PerCent = {
      provider = "LinePercent",
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.fg, colors.bg, "bold"}
    }
  },
  {
    FileEncodeSep = {
      provider = function()
        return " " .. special_char.right_sep2
      end,
      highlight = {colors.mode_bg, colors.bg}
    }
  },
  {
    FileEncode = {
      provider = "FileEncode",
      condition = condition.hide_in_width,
      separator = " ",
      separator_highlight = {"NONE", colors.mode_bg},
      highlight = {colors.milk, colors.mode_bg, "bold"}
    }
  },
  {
    FileFormat = {
      provider = "FileFormat",
      condition = condition.hide_in_width,
      separator = " ",
      separator_highlight = {"NONE", colors.mode_bg},
      highlight = {colors.milk, colors.mode_bg, "bold"}
    }
  },
  {
    BlankSepRigitEnd = {
      provider = function()
        return " "
      end,
      highlight = {"NONE", colors.mode_bg}
    }
  },
  -- end logo
  {
    EndSep = {
      provider = function()
        return " " .. special_char.right_sep2
      end,
      highlight = {colors.end_bg, colors.mode_bg}
    }
  },
  {
    EndLogo = {
      provider = function()
        return " " .. special_char.end_icon
      end,
      highlight = {colors.end_bg, colors.end_bg}
    }
  }
}
-- Short status line
gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
