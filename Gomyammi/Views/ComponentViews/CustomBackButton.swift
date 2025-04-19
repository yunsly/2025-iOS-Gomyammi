//
//  CustomBackButton.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var color: Color = .black
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 2) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .semibold))
            }
            .foregroundColor(color)
        }
    }
}
