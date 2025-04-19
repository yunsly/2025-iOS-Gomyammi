//
//  StatisticCardView.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI

struct StatisticCardView: View {
    let title: String
    let value: Int
    let textColor: String
    
    init(title: String, value: Int, textColor: String) {
        self.title = title
        self.value = value
        self.textColor = textColor
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.pretendardSemiBold12)
                    .foregroundColor(Color(hex: "494A43"))
                Spacer()
            }
            HStack {
                Spacer()
                Text("\(value)")
                    .font(.pretendardSemiBold50)
                    .foregroundColor(Color(hex: textColor))
            }
            
        }
        .padding(15)
        .padding(.top, 5)
        .frame(width: 92, height: 87)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(hex: "f5f5f5"))                       
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(hex: "63645D"), lineWidth: 1)
                .foregroundColor(Color(.systemGray6))
        )
    }
}
