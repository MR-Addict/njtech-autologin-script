# 南京工业大学校园网自动登录Python脚本Selenium版

## 1. 准备

- 安装python
- 安装selenium包
- 配置登录信息
- 下载chromedriver(本仓库有此文件)

第一步，相信大家都是有装python的，这一步就直接跳过了，没有安装的请前往官网下载。

第二步，安装python的`selenium`包，安装过的也可以跳过这一步，没有装的可以使用以下命令：

```shell
pip install -i https://mirrors.aliyun.com/pypi/simple/ selenium
```

第三步，由于登录需要账号，密码和运营商的信息，这些需要大家在`src/assets/`文件夹下自己新建一个`profile.json`文件并配置相关信息。格式如下：

```json
{
  "username": "YOUR_USERNAME",
  "password": "YOUR_PASSWORD",
  "provider": "YOUR_PROVIDER"
}
```
其中运营商只能填两个，移动是`cmcc`，电信是`telecom`。

第四步，chromedriver已经提前下载在`assets`文件夹中，可以直接跳过。

最后，你的文件树应该如下：

- autologin.bat
- assets
  - autologin.exe
  - chromedriver.exe
  - profile.json

## 2. 使用

> 注意：本项目仅适用Windows，相信Linux的大佬们根本不需要这个脚本。

双击`src`文件夹下的`autologin.bat`直接运行即可。
