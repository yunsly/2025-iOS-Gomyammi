//
//  MainView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI

struct MainView: View {
    @State private var mainGoal: String = "Challeng 2 완수하기"
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            ZStack {
                // 배경색 설정
                Color(hex: "f5f5f5").ignoresSafeArea()
                
                VStack {
                    // 메인목표 바
                    HStack(spacing: 10) {
                        Image("cat-paw5")
                            .resizable()
                            .frame(width: 26, height: 23)
                        Text("\(mainGoal)")
                    }
                    .modifier(WhiteBox(paddingValue: 15))
                    
                    MandalartView()
                        .environmentObject(navigationManager)
                    
                }
                
            }
        }
        .navigationDestination(for: ViewType.self) { value in
            switch value {
            case .gridDetailView:
//                GridDetailView()
//                    .environmentObject(navigationManager)
                EmptyView()
            case .editGridView:
                EmptyView()
            case .mainView:
                EmptyView()
            case .onBoarding:
                EmptyView()
            }
        }
        
    }
}

