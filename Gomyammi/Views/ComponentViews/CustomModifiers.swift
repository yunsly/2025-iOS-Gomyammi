//
//  CustomModifiers.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI

struct WhiteBox: ViewModifier {
    var paddingValue: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, paddingValue)
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 25)
            .font(.pretendardSemiBold17)

    }
}

struct BasicButton: ViewModifier {
    var buttonColor: String
    var buttonWidth: CGFloat
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .frame(maxWidth: buttonWidth, maxHeight: 48, alignment: .leading)
                .background(Color(hex: buttonColor))
                .cornerRadius(15)
            Spacer()

        }
        
    }
}
