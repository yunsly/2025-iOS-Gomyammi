//
//  CustomModifiers.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI

struct WhiteBox: ViewModifier {
    var paddingValue: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.leading, paddingValue)
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 25)
            .font(.pretendardSemiBold17)

    }
}

