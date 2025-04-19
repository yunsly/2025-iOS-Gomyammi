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
    var buttonColor : String
    var buttonWidth : CGFloat
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .frame(maxWidth: buttonWidth, maxHeight: 48, alignment: .leading)
                .background(Color(hex: buttonColor))
                .cornerRadius(15)
                .padding(.horizontal)
            Spacer()

        }
        
    }
}

struct NextButton: ViewModifier {
    var buttonColor : String = ""
    var textColor: String = ""
    
    func body(content: Content) -> some View {
        content
            .font(.pretendardMedium18)
            .foregroundColor(Color(hex: textColor))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(hex: buttonColor))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(hex: "E6E6E6"), lineWidth: 1)
            )
            .padding(.horizontal, 40)
        
    }
}
