//
//  MainView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
//    @State private var mainGoal: String = "Challeng 2 완수하기"
    
    // SwiftData 쿼리로 만다라트 보드 데이터 가져오기
    @Query private var myMandalaBoard: [MandalaBoard]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경색 설정
                Color(hex: "f5f5f5").ignoresSafeArea()
                
                VStack {
                    // 메인목표 바
                    HStack(spacing: 10) {
                        Image("cat-paw5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26)
                        Text(myMandalaBoard.first?.mainGoal ?? "목표를 설정해주세요.")
                    }
                    .modifier(WhiteBox(paddingValue: 15, height: 40))
                    
                    // 만다라트 그리드 - 데이터 전달
                    MandalartView(mandalaBoard: myMandalaBoard.first)
                    
                    // 통계 바 - 데이터 기반 통계 표시
                    StatisticsView(mandalaBoard: myMandalaBoard.first)
                    
                }
            }
        }
            
    }
}


