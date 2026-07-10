# ContextDict

> 面向语境的 macOS 词典与翻译工具。

[![许可证](https://img.shields.io/github/license/ph4ble/ContextDict)](./LICENSE)
[![平台](https://img.shields.io/badge/platform-macOS%2013%2B-black?logo=apple)](https://www.apple.com/macos/)

[English](./README.md)

ContextDict 是由 **ph4ble** 维护的 macOS 词典翻译应用，基于 [EasyDict](https://github.com/tisfeng/Easydict) 的 GPL-3.0 fork。项目的重点是结合所在句子，解释划选单词或词组在当前语境中的准确含义。

## 上下文释义

选中单词或词组后，ContextDict 会通过 macOS 辅助功能尝试取得它所在的句子。启用 AI 词典服务时，会要求服务返回：

- 所选词或词组在当前语境中的准确含义；
- 该含义与句子关系的简短解释；
- 完整句子的翻译；
- 仅在有助于区分时列出其他常见含义。

该功能不会在缺少可靠上下文时猜测。来源应用无法提供完整句子和选区范围时，ContextDict 会自动回退到普通词典查询。

## 功能特点

- 根据当前句子解释划选单词和词组
- 提供上下文释义隐私开关；启用后，仅向你已启用的 AI 词典服务发送所选词和所在句子
- 鼠标划词与快捷键划词
- 文本翻译、截图 OCR 与静默 OCR
- 集成苹果系统词典与系统翻译
- 可配置 AI、翻译和 TTS 服务
- 独立的 ContextDict 应用标识、Bundle ID 与 URL scheme

## 开始使用

1. 在 macOS 13 或更高版本构建并启动 ContextDict。
2. 为受支持的来源应用授予所需的辅助功能和 AppleScript 权限。
3. 在设置中启用一个 AI 词典服务并配置其凭证。
4. 在“设置 > 通用”中保持“上下文释义”开启。
5. 在能通过辅助功能提供完整文本的应用中划选单词或词组。

首个独立 DMG 会在本地构建验证完成后发布到本仓库的 Releases 页面。

## 开发

ContextDict 当前在 `dev` 分支开发。本地构建需要完整 Xcode，macOS Command Line Tools 不能替代。项目依赖和构建设置可参考上游的[开发者构建指南](./docs/zh/GUIDE.md#开发者构建)。

## 许可证与署名

ContextDict 使用 [GPL-3.0](./LICENSE) 协议，基于 tisfeng 原创并维护的 EasyDict 衍生。仓库保留 EasyDict 的版权声明、致谢与 GPL-3.0 义务；ContextDict 的新增修改由 ph4ble 维护。

上游基线和修改范围见 [FORK_NOTICE.md](./FORK_NOTICE.md)。
