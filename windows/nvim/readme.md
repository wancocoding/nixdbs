
## Windows下NeoVim配置


**1. 安装好语言支持**

先用`scoop`安装好python38, ruby和nodejs-lts

然后安装好NeoVim的包
```
pip3 install pynvim
gem install neovim
npm install -g neovim
```

**2. 做链接**

用管理员身份运行`PowerShell`

```
New-Item -Path ~/AppData/Local/nvim -ItemType SymbolicLink -Value ./nvim.symlink
```

Done!