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
            
            VStack (spacing: 30){
                // 메인목표 바
                HStack(spacing: 10) {
                    Text("/ 선택한 그리드는 \(gridIndex)")
                }
                .modifier(WhiteBox(paddingValue: 15, height: 40))
                
                // 중앙 3x3 그리드의 경우
                if gridIndex == 4  {
                    
                }
                VStack(spacing: 1) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 1) {
                            ForEach(0..<3) { col in
                                let cellIndex = row * 3 + col
                                
                                // 중앙 3x3 그리드의 경우
                                if (cellIndex == 4 && gridIndex == 4) {
                                    CatPawStamp(opacity: 0.7, size: 114, padding: 15)
                                }
                                else {
                                    Button {
                                        showingEditGoalView = true
                                        print(showingEditGoalView)
                                    } label: {
                                        Text( cellIndex == 4 && gridIndex == 4 ? "" : "(\(gridIndex), \(cellIndex))")
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
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 4)
                )
                .cornerRadius(10)
                
                Spacer()
                
                Image("cat-lying-on-the-box")
                    .resizable()
                    .frame(width: 130, height: 130)
                
                Spacer()
                    .frame(height: 20)
                
            }
            
            
        }
        .background(Color.black)
    }
}
