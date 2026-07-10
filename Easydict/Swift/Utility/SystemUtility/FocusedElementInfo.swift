//
//  FocusedElementInfo.swift
//  Easydict
//
//  Created by tisfeng on 2025/8/31.
//  Copyright © 2025 izual. All rights reserved.
//

import AXSwift
import Foundation

/// Result type for focused UI element information
struct FocusedElementInfo: CustomStringConvertible {
    /// Default empty info used when no element data can be retrieved
    static let empty = FocusedElementInfo(
        fullText: nil,
        selectedRange: nil,
        selectedText: nil,
        roleValue: nil
    )

    // MARK: - Role Helpers

    /// Roles that are considered text input elements
    static let textInputRoles: Set<String> = [
        kAXTextFieldRole,
        kAXTextAreaRole,
        kAXComboBoxRole, // Safari: Google search field
        kAXSearchFieldSubrole,
        kAXPopUpButtonRole,
        kAXMenuRole,
    ]

    /// Roles that are considered selectable text elements
    static let selectableTextRoles: Set<String> = textInputRoles.union([
        kAXStaticTextRole,
        kAXGroupRole, // PDF, fix https://github.com/tisfeng/Easydict/issues/1091
        Role.webArea.rawValue,
    ])

    /// Full text in the focused text field, if available
    let fullText: String?

    /// Selected text range, length is 0 if element not supported AX though has selected text
    var selectedRange: CFRange?

    /// Selected text in the focused text field.
    /// If user has selected text, `selectedText` should have a value by forced selection.
    ///
    /// - Note: Sometimes has selected text, but selectedRange is nil
    let selectedText: String?

    /// Role value of the focused element, e.g. kAXTextFieldRole, AXTextAreaRole,
    let roleValue: String?

    /// Whether the focused element is a text input element
    var isTextInputField: Bool {
        guard let roleValue else {
            return false
        }
        return Self.textInputRoles.contains(roleValue)
    }

    /// Focused text, prefer selectedText if available, otherwise use full text
    var focusedText: String? {
        if let selectedText, !selectedText.isEmpty {
            return selectedText
        }
        if let fullText, !fullText.isEmpty {
            return fullText
        }
        return nil
    }

    /// The sentence containing the current selection when the source exposes
    /// both full text and an Accessibility selection range. This intentionally
    /// returns nil rather than guessing when those inputs are unavailable.
    var contextualSentence: String? {
        guard let fullText, let selectedRange else { return nil }
        return ContextSentenceResolver.sentence(
            containingUTF16Range: selectedRange,
            in: fullText
        )
    }

    /// Whether the focused element is a supported text input element
    var isSupportedAXElement: Bool {
        fullText?.isEmpty == false
    }

    // - MARK: CustomStringConvertible

    var description: String {
        let rangeDesc = selectedRange.map { "(\($0.location), \($0.length))" } ?? ""
        let selectedDesc = selectedText ?? "nil"
        let roleDesc = roleValue ?? "nil"
        let fullTextDesc = fullText?.prefix200 ?? "nil"

        return """
        FocusedElementInfo(
            text: \"\(fullTextDesc)\",
            selectedRange: \(rangeDesc),
            selectedText: \(selectedDesc),
            roleValue: \(roleDesc)
        )
        """
    }
}

enum ContextSentenceResolver {
    static func sentence(containingUTF16Range range: CFRange, in text: String) -> String? {
        guard range.location >= 0,
              range.length > 0 else {
            return nil
        }

        let utf16Count = CFIndex(text.utf16.count)
        guard range.location <= utf16Count,
              range.length <= utf16Count - range.location,
              let startUTF16 = text.utf16.index(
                  text.utf16.startIndex,
                  offsetBy: range.location,
                  limitedBy: text.utf16.endIndex
              ),
              let endUTF16 = text.utf16.index(
                  startUTF16,
                  offsetBy: range.length,
                  limitedBy: text.utf16.endIndex
              ),
              let start = String.Index(startUTF16, within: text),
              let end = String.Index(endUTF16, within: text) else {
            return nil
        }

        let prefix = text[..<start]
        let suffix = text[end...]
        let sentenceStart = prefix.lastIndex(where: { ".!?。！？\n".contains($0) })
            .map { text.index(after: $0) } ?? text.startIndex
        let sentenceEnd = suffix.firstIndex(where: { ".!?。！？\n".contains($0) })
            .map { text.index(after: $0) } ?? text.endIndex
        let sentence = text[sentenceStart..<sentenceEnd]
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return sentence.isEmpty ? nil : sentence
    }
}
