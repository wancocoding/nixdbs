" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["ayu-vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/ayu-vim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugin.statusline\frequire\0" },
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["git-blame.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/git-blame.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  hop = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/hop"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["material.vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/material.vim"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["oceanic-material"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/oceanic-material"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["palenight.vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/palenight.vim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-go"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-go"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-which-key"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vista.vim"
  }
}

time("Defining packer_plugins", false)
-- Config for: hop
time("Config for hop", true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop")
time("Config for hop", false)
-- Config for: galaxyline.nvim
time("Config for galaxyline.nvim", true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugin.statusline\frequire\0", "config", "galaxyline.nvim")
time("Config for galaxyline.nvim", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
