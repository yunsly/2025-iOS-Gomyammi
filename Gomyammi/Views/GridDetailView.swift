//
//  GridDetailView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI


struct GridDetailView: View {
    
    // 표시해야할 정보
    @Bindable var board: MandalartBoard
    let gridIndex: Int
    let cellIndex: Int
    
    @State private var showingEditGoalView: Bool = false
    @State private var selectedCell: CellIdentifier? = nil
    @State private var markedCell: MandalartCell?
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            VStack (spacing: 30){
                HStack (spacing: 15) {
                    // 메인목표 바
                    CustomBackButton()
                        .padding(.leading, 10)
                    HStack {
                        if let selectedCell = board.findCell(gridIndex:4, cellIndex: gridIndex) {
                            Text(gridIndex == 4 ? "\(board.mainGoal) /" : "/ \(selectedCell.title)")
                        }
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
                                let calculatedCellIndex = row * 3 + col
                                if (calculatedCellIndex == 4 && gridIndex == 4) {
                                    VStack {
                                        CatPawStamp(opacity: 0.7, size: 114, padding: 15)
                                    }
                                    .frame(width: 114, height: 114)
                                } else {
                                    ZStack {
                                        // 1: 배경색
                                        Rectangle()
                                            .fill(
                                                (calculatedCellIndex == 4 && gridIndex != 4) || (gridIndex == 4 && calculatedCellIndex != 4)
                                                ? Color(hex: "f5f5f5")
                                                : Color.white
                                            )
                                            .frame(width: 114, height: 114)
                                        
                                        // 2: 완료 시 도장
                                        if let markedCell = board.findCell(gridIndex: gridIndex, cellIndex: calculatedCellIndex),
                                           markedCell.progress == .completed {
                                            VStack {
                                                RandomCatPawStamp(opacity: 0.2, padding: 15, isBig: true)
                                            }
                                            .frame(width: 114, height: 114)
                                        }
                                        
                                        // 3: 컨텐츠 버튼 (가장 위에!)
                                        Button {
                                            selectedCell = CellIdentifier(gridIndex: gridIndex, cellIndex: calculatedCellIndex)
                                        } label: {
                                            if let cell = board.findCell(gridIndex: gridIndex, cellIndex: calculatedCellIndex) {
                                                VStack {
                                                    Text("\(cell.emoji)")
                                                        .font(.largeTitle)
                                                        .padding(.bottom, 3)
                                                    Text("\(cell.title)")
                                                        .font(.pretendardSemiBold17)
                                                        .foregroundColor(.black)
                                                }
                                                .padding()
                                                .frame(width: 114, height: 114)
                                            } else {
                                                Text("")
                                                    .frame(width: 114, height: 114)
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        .sheet(item: $selectedCell) { cellID in
                                            EditGoalView(
                                                board: board,
                                                gridIndex: cellID.gridIndex,
                                                cellIndex: cellID.cellIndex
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
        .safeAreaPadding(.top)
        .background(Color(hex: "f5f5f5")) // 배경색 지정
    }
}
