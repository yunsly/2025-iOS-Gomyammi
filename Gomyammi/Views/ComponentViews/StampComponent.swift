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
            .scaledToFit()
            .opacity(opacity)
            .frame(width: size)
            .padding(padding)

    }
}


struct RandomCatPawStamp: View {
    let stampList: [String] = ["cat-paw1", "cat-paw2", "cat-paw3", "cat-paw4", "cat-paw5"]
    let stampBigSize: [CGFloat] = [40, 60, 80, 100, 110]
    let stampSmallSize: [CGFloat] = [20, 25, 30, 35]
    
    var opacity: Double
    var padding: CGFloat
    var isBig: Bool
    
    // 초기화할 때 랜덤 이미지와 사이즈 선택
    @State private var randomStamp: String
    @State private var randomStampSize: CGFloat
    
    
    init(opacity: Double = 1.0, padding: CGFloat = 0, isBig: Bool) {
        self.opacity = opacity
        self.padding = padding
        self.isBig = isBig
        // _randomStamp를 사용하여 @State 프로퍼티 초기화
        if self.isBig {
            _randomStamp = State(initialValue: stampList.randomElement() ?? "cat-paw1")
            _randomStampSize = State(initialValue: stampBigSize.randomElement() ?? 100)
        } else {
            _randomStamp = State(initialValue: stampList.randomElement() ?? "cat-paw1")
            _randomStampSize = State(initialValue: stampSmallSize.randomElement() ?? 100)
        }
    }
    
    var body: some View {
        Image(randomStamp)
            .resizable()
            .scaledToFit()
            .frame(width: randomStampSize)
            .opacity(opacity)
            .padding(padding)
    }
}
