//
//  StatisticsView.swift
//  Gomyammi
//
//  Created by yunsly on 4/20/25.
//

import SwiftUI

struct StatisticsView: View {
    var mandalaBoard: MandalaBoard?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 배경이 되는 흰색 상자
            VStack (spacing: 15) {
                Text("포기는 배추셀 때나 하는 말이다냥")
                    .font(.pretendardSemiBold18)
                    .padding(.bottom, 15)
                
                // 통계 정보들 (컴포넌트 재사용)
                HStack(spacing: 15) {
                    StatisticCardView(title: "전체", value: 15, textColor: "7B7B7B")
                    StatisticCardView(title: "예정", value: 4, textColor: "7B7B7B")
                    StatisticCardView(title: "진행 중", value: 6, textColor: "7CA1F8")
                }
                //.padding(.bottom, 40) // 고양이가 들어갈 공간 확보
                
                HStack(spacing: 15) {
                    StatisticCardView(title: "임시", value: 6, textColor: "7CA1F8")
                        .hidden()
                    StatisticCardView(title: "일시정지", value: 3, textColor: "F2A46F")
                    StatisticCardView(title: "완료", value: 2, textColor: "F78080")
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, minHeight: 270)
            
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
            )
            
            // 고양이 이미지를 상자 하단에 걸쳐서 배치
            Image("running-cat")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .offset(x: -100, y: 40) // 왼쪽으로도 이동
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}

#Preview {
    StatisticsView()
}
