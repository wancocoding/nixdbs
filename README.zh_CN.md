Linux Development Bootstrap
===


在Linux上快速搭建一个合适的开发环境,如数据库,缓存,编辑器,特定语言开发,帮助文档,开发工具等等



## 特性

* 可以选择国内线路或者国外线路安装
* 无人值守
* 支持的操作系统有`OSX`, `Debian/Ubuntu`, `Archlinux`, `Fedora/RedHat`, `OpenSuse`
* 多种选择,支持最小化(只安装非常必须的语言工具)
* 可以定制特定语言所需环境和工具
* 支持导入自己的dotfiles
* 大量常用的操作简化,比如git新建仓库





## TODO

* [x] 根据提示选择安装线路,`github`和`gitee`切换
* [x] 终端颜色问题
* [x] 精简默认任务
* [x] 更新语言的最新版本 golang node python
* [ ] 更新语言的最新版本 java gradle ruby
* [x] 格式化所有脚本
* [x] 修复安装dev kits的时候的需要确认的问题
* [ ] 字体安装
* [x] 增加`~/.config/nixdbs/`文件夹,用于保存配置信息,环境变量,临时脚本等等
* [ ] 将所有环境变量写到一个可以配置删除的文件夹里,方便在移除的时候一起删除
