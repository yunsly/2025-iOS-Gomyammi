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
    var task: MandalaTask? // 선택된 태스크
    
    @State private var showingEditGoalView: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            // 배경색 설정
            Color(hex: "f5f5f5").ignoresSafeArea()
            
            VStack (spacing: 30){
                // 메인목표 바
                HStack (spacing: 15) {
                    CustomBackButton()
                        .padding(.leading, 10)
                    HStack {
                        Text("/ \(task?.parentTask?.miniGoal ?? "")")
                    }
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.trailing, 25)
                    .font(.pretendardSemiBold17)
                }
                .padding(.leading, 15)
                .padding(.top, 5)
                
                VStack(spacing: 1) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 1) {
                            ForEach(0..<3) { col in
                                let detailCellIndex = row * 3 + col
                                
                                // 중앙 3x3 그리드의 경우
                                if (detailCellIndex == 4 && gridIndex == 4) {
                                    CatPawStamp(opacity: 0.7, size: 114, padding: 15)
                                }
                                else {
                                    Button {
                                        showingEditGoalView = true
                                    } label: {
                                        cellContent(cellIndex: detailCellIndex)
                                    }
                                    .sheet(isPresented: $showingEditGoalView) {
                                        EditGoalView(
                                            gridIndex: gridIndex,
                                            cellIndex: detailCellIndex,
                                            task: task
                                        )
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
                    .scaledToFit()
                    .frame(width: 130)
                
                Spacer()
                    .frame(height: 20)
                
            }
            .navigationBarHidden(true) // 기본 네비게이션 바 숨기기
            
            
        }
        .background(Color.black)
    }
    
    // 셀 내용 표시
    private func cellContent(cellIndex: Int) -> some View {
        ZStack {
            Rectangle()
                .fill((cellIndex == 4 && gridIndex != 4) || (gridIndex == 4 && cellIndex != 4) ? Color(hex: "f5f5f5") : Color.white)
                .frame(width: 114, height: 114)
            
            if let task = task {
                if !task.emoji.isEmpty {
                    Text(task.emoji)
                        .font(.system(size: 40))
                } else {
                    Text("(\(gridIndex), \(cellIndex))")
                        .foregroundColor(.gray)
                }
            } else {
                Text("(\(gridIndex), \(cellIndex))")
                    .foregroundColor(.gray)
            }
        }
    }
}
