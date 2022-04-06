# 南京工业大学校园网自动登录Powershell版

## 1. 主要功能

- [x] 自动登录
- [x] 检查网络是否已经连接
- [x] 检查校园网是否在访问范围内
- [x] 联网前先关闭电脑的手动代理
- [x] 登录结束后检查网络是否连接成功
- [x] 关闭跳转的默认浏览器
- [x] 连接成功后发出哔的提示音
- [x] 实现自动配置开机自启任务
- [x] 实现休眠结束后自动启动任务
- [ ] 实现连接结束后自动启动其他任务
- [ ] 实现后台无弹窗运行

## 2. 准备

- 配置Windows Powershell权限
- 配置登录信息

第一步，由于Windows默认Windows Powershell没有权限运行脚本，你可以通过以下命令查看你的Windows Powershell的运行权限：

```ps1
Get-ExecutionPolicy
```

如果输出结果是`Restricted `，那么你就需要通过管理员重新打开Windows Powershell，然后再输入以下命令：

```ps1
Set-ExecutionPolicy RemoteSigned
```

这样你就可以正常运行Powershell脚本了。

第二步，由于登录时需要`账号`，`密码`和`运营商`的信息，同时本脚本可以帮大家自动关闭跳转的`浏览器`，这些需要大家在`src`文件夹下自己新建一个`profile.json`文件并配置相关信息。profile内容格式如下：

```json
{
  "username": "学号/工号",
  "password": "密码",
  "provider": "运营商",
  "browser": "跳转的浏览器程序名"
}
```

其中运营商只能填两个，移动是`cmcc`，电信是`telecom`。

我也整理了一些主流的浏览器名称，把对应的浏览器程序名填入就可以了。如果下面没有你使用的浏览器，你可以自己打开任务管理器看一下浏览器的程序名。如果你不想使用这个功能可以将浏览器的程序名`设置为空`。

| 浏览器用户名 | 浏览器程序名 |
| :----------: | :----------: |
|  微软浏览器  |    msedge    |
|  谷歌浏览器  |    chrome    |
|  火狐浏览器  |   firefox    |
|   IE浏览器   |   iexplore   |
|  联想浏览器  |  SLBrowser   |

下面是一个示例：

```json
{
  "username": "XXXXXXXXXXXX",
  "password": "XXXXXXXXXXXX",
  "provider": "telecom",
  "browser": "msedge"
}
```

最后，你的文件结构因该如下：

- src
  - autologin.ps1
  - setup.ps1
  - profile.json

> 注意：为了方便大家使用，在`src`目录下有一个`setup.ps1`的文件，双击运行后跟着指示操作就可以完成相关配置了，同时`setup`也本可以帮助你直接配置开机自启以及休眠启动等任务，所以你最好通过管理员权限打开本脚本。

## 3. 使用

双击`src`文件夹下的`autologin.ps1`直接运行即可。

> 注意：由于本项目是使用Powershell脚本，而目前最新的`Powershell 7`版本是一个支持跨平台的脚本语言，因此理论上可以在任何系统上使用。
