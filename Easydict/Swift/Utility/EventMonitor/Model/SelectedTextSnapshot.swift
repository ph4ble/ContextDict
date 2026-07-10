//
//  SelectedTextSnapshot.swift
//  Easydict
//
//  Created by tisfeng on 2025/xx/xx.
//  Copyright © 2025 izual. All rights reserved.
//

import Foundation

// MARK: - SelectedTextSnapshot

/// Captures selected text with metadata for downstream handlers.
struct SelectedTextSnapshot {
    let text: String?
    let selectTextType: EZSelectTextType
    let isEditable: Bool
    let contextualSentence: String?

    init(
        text: String?,
        selectTextType: EZSelectTextType,
        isEditable: Bool,
        contextualSentence: String? = nil
    ) {
        self.text = text
        self.selectTextType = selectTextType
        self.isEditable = isEditable
        self.contextualSentence = contextualSentence
    }
}
