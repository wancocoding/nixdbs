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
  vertical_bar = "▊"
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
  darkblue = "#3b50ce",
  green = "#8bc34a",
  orange = "#f57f17",
  violet = "#5e35b1",
  magenta = "#e91e63",
  blue = "#e91e63",
  red = "#e51c23",
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
  ["c"] = colors.red,
  ["i"] = colors.blue,
  ["ic"] = colors.yellow,
  ["ix"] = colors.yellow,
  ["multi"] = colors.yellow,
  ["n"] = colors.green,
  ["ni"] = colors.violet,
  ["no"] = colors.magenta,
  ["R"] = colors.purple,
  ["Rv"] = colors.purple,
  ["s"] = colors.orange,
  ["S"] = colors.orange,
  [""] = colors.orange,
  ["t"] = colors.violet,
  ["v"] = colors.yellow,
  ["V"] = colors.blue,
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
  "packager"
}

-- Logo
gls.left[1] = {
  CocoNvimLogo = {
    provider = function()
      return special_char.logo
    end,
    highlight = {colors.bright_text, colors.logo_bg},
    separator = special_char.left_sep2,
    separator_highlight = {colors.logo_bg, colors.mode_bg}
  }
}
-- Vim Mode
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local vim_mode = vim.fn.mode()
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
      return mode_alias[vim_mode] .. " " .. special_char.mode_icon
    end,
    highlight = {colors.red, colors.mode_bg},
    separator = special_char.left_sep2,
    separator_highlight = {colors.mode_bg, colors.bg}
  }
}

-- Right
-- end logo
gls.right[1] = {
  EndSep = {
    provider = function()
      return " " .. special_char.right_sep2
    end,
    highlight = {colors.end_bg, colors.bg}
  }
}
gls.right[2] = {
  EndLogo = {
    provider = function()
      return " " .. special_char.end_icon
    end,
    highlight = {colors.end_bg, colors.end_bg}
  }
}
-- gls.left[3] = {
--   FileSize = {
--     provider = "FileSize",
--     condition = condition.buffer_not_empty,
--     highlight = {colors.fg, colors.bg}
--   }
-- }
-- gls.left[4] = {
--   FileIcon = {
--     provider = "FileIcon",
--     condition = condition.buffer_not_empty,
--     highlight = {
--       require("galaxyline.provider_fileinfo").get_file_icon_color,
--       colors.bg
--     }
--   }
-- }

-- gls.left[5] = {
--   FileName = {
--     provider = "FileName",
--     condition = condition.buffer_not_empty,
--     highlight = {colors.fg, colors.bg, "bold"}
--   }
-- }
-- gls.left[6] = {
--   LineInfo = {
--     provider = "LineColumn",
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.fg, colors.bg}
--   }
-- }

-- gls.left[7] = {
--   PerCent = {
--     provider = "LinePercent",
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.fg, colors.bg, "bold"}
--   }
-- }

-- gls.left[8] = {
--   DiagnosticError = {
--     provider = "DiagnosticError",
--     icon = "  ",
--     highlight = {colors.red, colors.bg}
--   }
-- }
-- gls.left[9] = {
--   DiagnosticWarn = {
--     provider = "DiagnosticWarn",
--     icon = "  ",
--     highlight = {colors.yellow, colors.bg}
--   }
-- }

-- gls.left[10] = {
--   DiagnosticHint = {
--     provider = "DiagnosticHint",
--     icon = "  ",
--     highlight = {colors.cyan, colors.bg}
--   }
-- }

-- gls.left[11] = {
--   DiagnosticInfo = {
--     provider = "DiagnosticInfo",
--     icon = "  ",
--     highlight = {colors.blue, colors.bg}
--   }
-- }
-- gls.mid[1] = {
--   ShowLspClient = {
--     provider = "GetLspClient",
--     condition = function()
--       local tbl = {["dashboard"] = true, [""] = true}
--       if tbl[vim.bo.filetype] then
--         return false
--       end
--       return true
--     end,
--     icon = " LSP:",
--     highlight = {colors.yellow, colors.bg, "bold"}
--   }
-- }

-- gls.right[1] = {
--   FileEncode = {
--     provider = "FileEncode",
--     condition = condition.hide_in_width,
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.green, colors.bg, "bold"}
--   }
-- }

-- gls.right[2] = {
--   FileFormat = {
--     provider = "FileFormat",
--     condition = condition.hide_in_width,
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.green, colors.bg, "bold"}
--   }
-- }

-- gls.right[3] = {
--   GitIcon = {
--     provider = function()
--       return "  "
--     end,
--     condition = condition.check_git_workspace,
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.violet, colors.bg, "bold"}
--   }
-- }

-- gls.right[4] = {
--   GitBranch = {
--     provider = "GitBranch",
--     condition = condition.check_git_workspace,
--     highlight = {colors.violet, colors.bg, "bold"}
--   }
-- }

-- gls.right[5] = {
--   DiffAdd = {
--     provider = "DiffAdd",
--     condition = condition.hide_in_width,
--     icon = "  ",
--     highlight = {colors.green, colors.bg}
--   }
-- }
-- gls.right[6] = {
--   DiffModified = {
--     provider = "DiffModified",
--     condition = condition.hide_in_width,
--     icon = " 柳",
--     highlight = {colors.orange, colors.bg}
--   }
-- }
-- gls.right[7] = {
--   DiffRemove = {
--     provider = "DiffRemove",
--     condition = condition.hide_in_width,
--     icon = "  ",
--     highlight = {colors.red, colors.bg}
--   }
-- }

-- gls.right[8] = {
--   RainbowBlue = {
--     provider = function()
--       return " ▊"
--     end,
--     highlight = {colors.blue, colors.bg}
--   }
-- }

-- gls.short_line_left[1] = {
--   BufferType = {
--     provider = "FileTypeName",
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.blue, colors.bg, "bold"}
--   }
-- }

-- gls.short_line_left[2] = {
--   SFileName = {
--     provider = "SFileName",
--     condition = condition.buffer_not_empty,
--     highlight = {colors.fg, colors.bg, "bold"}
--   }
-- }

-- gls.short_line_right[1] = {
--   BufferIcon = {
--     provider = "BufferIcon",
--     highlight = {colors.fg, colors.bg}
--   }
-- }
