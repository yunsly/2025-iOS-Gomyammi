//
//  StampComponent.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI



struct CatPawStamp: View {
    var opacity: Double
    var size: CGFloat
    var padding: CGFloat
    
    var body: some View {
        Image("cat-paw5")
            .resizable()
            .padding(padding)
            .frame(width: size, height: size)
            .opacity(opacity)
    }
}


struct RandomBigCatPawStamp: View {
    var opacity: Double
    
    var body: some View {
        Image("cat-paw5")
            .resizable()
            .frame(width: 109, height: 102)
            .opacity(opacity)
    }
}

