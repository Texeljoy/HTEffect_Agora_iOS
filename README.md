# API Example iOS

*[English](README.md) | 中文*

这个开源示例项目演示了Agora视频SDK的部分API使用示例，以帮助开发者更好地理解和运用Agora视频SDK的API。

## 问题描述
iOS 系统版本升级至 14.0 版本后，用户首次使用集成了声网 iOS 语音或视频 SDK 的 app 时会看到查找本地网络设备的弹窗提示。默认弹窗界面如下图所示：

![](../pictures/ios_14_privacy_zh.png)

[解决方案](https://docs.agora.io/cn/faq/local_network_privacy)

## 环境准备

- XCode 13.0 +
- iOS 真机设备
- 不支持模拟器

## 运行示例程序

这个段落主要讲解了如何编译和运行实例程序。

### 安装依赖库

切换到 **iOS** 目录，运行以下命令使用CocoaPods安装依赖，Agora视频SDK会在安装后自动完成集成。

使用cocoapods

[安装cocoapods](http://t.zoukankan.com/lijiejoy-p-9680485.html)

```
pod install
```

运行后确认 `APIExample.xcworkspace` 正常生成即可。

### 创建Agora账号并获取AppId

在编译和启动实例程序前，你需要首先获取一个可用的App Id:

1. 在[agora.io](https://dashboard.agora.io/signin/)创建一个开发者账号
2. 前往后台页面，点击左部导航栏的 **项目 > 项目列表** 菜单
3. 复制后台的 **App Id** 并备注，稍后启动应用时会用到它
4. 如果开启了token，需要获取 App 证书并设置给`certificate`

5. 打开 `APIExample.xcworkspace` 并编辑 `KeyCenter.swift`，将你的 AppID 和 Certificate 分别替换到 `<#Your APPID#>` 与 `<#YOUR Certificate#>`

    ```
    /**
     Agora 给应用程序开发人员分配 App ID，以识别项目和组织。如果组织中有多个完全分开的应用程序，例如由不同的团队构建，
     则应使用不同的 App ID。如果应用程序需要相互通信，则应使用同一个App ID。
     进入声网控制台(https://console.agora.io/)，创建一个项目，进入项目配置页，即可看到APP ID。
   */
    static let AppId: String = <# YOUR APPID#>

    /**
     Agora 提供 App certificate 用以生成 Token。您可以在您的服务器部署并生成 Token，或者使用控制台生成临时的 Token。
     进入声网控制台(https://console.agora.io/)，创建一个带证书鉴权的项目，进入项目配置页，即可看到APP证书。
     注意：如果项目没有开启证书鉴权，这个字段留空。
    */
    static var Certificate: String? = <#YOUR Certificate#>
    ```

然后你就可以使用 `APIExample.xcworkspace` 编译并运行项目了。

<br/>

## **HTEffect**
### **说明**
- 以下介绍如何快速配置HTEffect模块

<br/>

### **操作步骤**
#### **1. 下载源码**
依次执行以下命令
- git clone **当前仓库**
- cd **工程目录**
- git submodule init && git submodule update

#### **2. 配置工程**
下载完成后，打开工程
- 将 **Bundle Display Name** 和 **Bundle Identifier** 分别替换为您的**应用名**和**包名**
- 将HTAppId.h中NSString *const appId = @"Your AppId"的**Your AppId**替换成您的**AppId**
- 将HTEffect文件夹下的**HTEffect.bundle**替换为您的**HTEffect.bundle**
- 编译，运行，日志搜索**init-status**可以查看相关日志
- 具体执行步骤可以全局搜索 **//todo --- HTEffect** 进行查看 

<br/>
