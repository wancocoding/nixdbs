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
local package_path_str = "/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/coco/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["completion-nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
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
  hop = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/hop"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["oceanic-material"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/oceanic-material"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/coco/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
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

-- Config for: hop
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop")
-- Config for: galaxyline.nvim
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugin.statusline\frequire\0", "config", "galaxyline.nvim")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
