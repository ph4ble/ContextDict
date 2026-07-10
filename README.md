# ContextDict

> Context-aware dictionary and translation for macOS.

[![License](https://img.shields.io/github/license/ph4ble/ContextDict)](./LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%2013%2B-black?logo=apple)](https://www.apple.com/macos/)

[中文](./README_ZH.md)

ContextDict is a macOS dictionary and translation application maintained by **ph4ble**. It is a GPL-3.0 fork of [EasyDict](https://github.com/tisfeng/Easydict), focused on explaining the meaning of a selected word or phrase in its actual sentence.

## Contextual Lookup

When you select a word or phrase, ContextDict attempts to obtain its surrounding sentence through macOS Accessibility. With an enabled AI dictionary service, it asks for:

- the precise contextual meaning of the selected term;
- a brief explanation of why that meaning fits;
- a translation of the complete sentence; and
- other common meanings only when they help distinguish the context.

This is deliberately conservative. If the source application cannot provide a reliable sentence and selection range, ContextDict falls back to the regular dictionary query instead of guessing.

## Features

- Context-aware explanation for selected words and phrases
- A privacy control for contextual lookup; when enabled, the selected term and source sentence are sent only to the AI dictionary service you enable
- Mouse selection and shortcut-based lookup
- Text translation, screenshot OCR, and silent OCR
- Apple Dictionary and Apple Translate integration
- Configurable AI, translation, and TTS services
- Separate ContextDict application identity, bundle identifier, and URL scheme

## Getting Started

1. Build and launch ContextDict on macOS 13 or later.
2. Grant the requested Accessibility and AppleScript permissions for supported applications.
3. In Settings, enable an AI dictionary service and configure its credentials.
4. In Settings > General, keep **Contextual Lookup** enabled.
5. Select a word or phrase in an application that exposes its full text through Accessibility.

The first independent DMG release will be published in this repository's Releases page after local build verification.

## Development

ContextDict is currently developed on the `dev` branch. A local build requires the full Xcode application, not only the macOS Command Line Tools. Refer to the upstream [developer build guide](./docs/en/GUIDE.md#developer-build) for project dependencies and build setup.

## License and Attribution

ContextDict is licensed under [GPL-3.0](./LICENSE). It is derived from EasyDict, originally created and maintained by tisfeng. EasyDict's copyright notices, acknowledgements, and GPL-3.0 obligations are retained. ContextDict-specific modifications are maintained by ph4ble.

See [FORK_NOTICE.md](./FORK_NOTICE.md) for the upstream baseline and modification notice.
