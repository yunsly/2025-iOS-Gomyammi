//
//  StampComponent.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI



struct CatPawStamp: View {
    @State private var isImageLoaded = false
    
    var opacity: Double
    var size: CGFloat
    var padding: CGFloat
    
    var body: some View {
        Image("cat-paw5")
            .resizable()
            .scaledToFit()
            .opacity(opacity)
            .frame(width: size)
            .padding(padding)

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

