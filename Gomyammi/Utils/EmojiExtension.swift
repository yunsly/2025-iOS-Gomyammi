//
//  EmojiExtension.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI

// Character 익스텐션으로 이모지 체크 기능 추가
extension Character {
    var isEmoji: Bool {
        // 유니코드 스칼라가 이모지 범위에 속하는지 확인
        if let scalar = unicodeScalars.first {
            return scalar.properties.isEmoji
        }
        return false
    }
}
