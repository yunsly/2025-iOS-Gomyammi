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
            .scaledToFit()
            .frame(width: size)
            .opacity(opacity)
    }
}


struct RandomBigCatPawStamp: View {
    var opacity: Double
    
    var body: some View {
        Image("cat-paw5")
            .resizable()
            .scaledToFit()
            .frame(width: 109)
            .opacity(opacity)
    }
}

