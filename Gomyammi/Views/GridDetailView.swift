//
//  GridDetailView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI


struct GridDetailView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    let gridIndex: Int
    let cellIndex: Int
    @State private var showingEditGoalView: Bool = false
    
    var body: some View {
        ZStack {
            // 배경색 설정
            Color(hex: "f5f5f5").ignoresSafeArea()
            
            VStack {
                // 메인목표 바
                HStack(spacing: 10) {
                    Text("/ 선택한 그리드는 \(gridIndex)")
                }
                .modifier(WhiteBox(paddingValue: 15, height: 40))
                
                VStack(spacing: 1) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 1) {
                            ForEach(0..<3) { col in
                                let cellIndex = row * 3 + col
                                Button {
                                    showingEditGoalView = true
                                    print(showingEditGoalView)
                                } label: {
                                    Text("(\(gridIndex), \(cellIndex))")
                                        .frame(width: 114, height: 114)
                                        .background((cellIndex == 4 && gridIndex != 4) || (gridIndex == 4 && cellIndex != 4) ? Color(hex: "f5f5f5") : Color.white)
                                }
                                .sheet(isPresented: $showingEditGoalView) {
                                    EditGoalView(gridIndex: gridIndex, cellIndex: cellIndex)
                                        .presentationDetents([.large])
                                        .presentationCornerRadius(21)
                                        .presentationDragIndicator(.visible)
                                }
                                
                            }
                        }
                    }
                }
                .cornerRadius(10)
          
            }
            
        }
        .background(Color.black)
    }
}
