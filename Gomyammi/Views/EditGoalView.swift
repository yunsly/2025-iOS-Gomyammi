//
//  EditGoalView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI

struct EditGoalView: View {
    
    // 표시해야할 정보
    @Bindable var board: MandalartBoard
    
    let gridIndex: Int
    let cellIndex: Int
    
    @State private var emoji: String = ""
    @State private var miniGoal: String = ""
    @State private var memo: String = ""
    
    @State private var selectedStatus: TaskStatus? = .planned
    @State private var completionDate: String = ""
    @State private var hasToChangeCell: MandalartCell?
    
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {
        ZStack {
            // 배경색 설정
            
            Color(hex: "f5f5f5").ignoresSafeArea()
                .onTapGesture {
                    isFocused = false // 포커스 해제하여 키보드 내림
                }
            
            if let cell = board.findCell(gridIndex: gridIndex, cellIndex: cellIndex) {
                VStack (spacing: 20) {
                    Spacer()
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        Text("세부 목표 설정이다냥")
                            .font(.pretendardBold21)
                        Spacer()
                        
                    }
                    VStack {
                        HStack {
                            Text("Emoji")
                            Spacer()
                                .frame(width: 35)
                            
                            TextField("", text: $emoji)
                                .focused($isFocused)
                                .onChange(of: emoji) { oldValue, newValue in
                                    // 입력된 텍스트가 비어있지 않은 경우
                                    if !newValue.isEmpty {
                                        // 마지막 입력된 문자가 이모지인지 확인
                                        if let lastChar = newValue.last, lastChar.isEmoji {
                                            // 마지막 이모지만 남기기
                                            emoji = String(lastChar)
                                        } else {
                                            // 이모지가 아니면 입력 무시
                                            if let oldLastChar = oldValue.last, oldValue.count > 0 {
                                                emoji = String(oldLastChar)
                                            } else {
                                                emoji = ""
                                            }
                                        }
                                    }
                                }
                        }
                        .font(.pretendardBold15)
                        .frame(height: 30)
                        Divider()
                        
                        
                        HStack {
                            Text("Mini goal")
                            Spacer()
                                .frame(width: 10)
                            TextField("디자인한테 달려가기", text: $miniGoal)
                                .focused($isFocused)
                                .font(.pretendardRegular14)
                        }
                        .font(.pretendardBold15)
                        .frame(height: 30)
                        
                    }
                    .modifier(WhiteBox(paddingValue: 15, height: 90))
                    
                    
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        HStack {
                            Text("memo (선택)")
                                .font(.pretendardBold15)
                            Spacer()
                        }
                        
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .frame(height: 130) // 하얀 박스의 높이에 맞게 조정
                            
                            TextEditor(text: $memo)
                                .focused($isFocused)
                                .font(.pretendardRegular14)
                                .padding(4)
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .modifier(WhiteBox(paddingValue: 10, height: 170))
                    
                    HStack {
                        Text("완료 일자")
                        Spacer()
                            .frame(width: 35)
                        Text("\(completionDate)")
                            .font(.pretendardRegular14)
                    }
                    .font(.pretendardBold15)
                    .modifier(WhiteBox(paddingValue: 10, height: 40))
                    
                    HStack {
                        Text("진척도")
                            .font(.pretendardSemiBold13)
                            .padding(.leading, 30)
                        Spacer()
                    }
                    StatusButtonsView(board: board, selectedStatus: $selectedStatus, completionDate: $completionDate)
                    
                    Spacer()
                    
                    Button {
                        // 명시적으로 cell 찾기
                        if let updatedCell = board.findCell(gridIndex: gridIndex, cellIndex: cellIndex) {
                            updatedCell.emoji = emoji
                            updatedCell.title = miniGoal
                            updatedCell.memo = memo
                            updatedCell.progress = selectedStatus ?? .planned
                            updatedCell.completionDate = completionDate
                            
                            // 메인셀 변경 시 쌍방 바인딩
                            if gridIndex == 4 {
                                if let hasToChangeCell = board.findCell(gridIndex: cellIndex, cellIndex: 4) {
                                    hasToChangeCell.emoji = emoji
                                    hasToChangeCell.title = miniGoal
                                    hasToChangeCell.memo = memo
                                    hasToChangeCell.progress = selectedStatus ?? .planned
                                    hasToChangeCell.completionDate = completionDate
                                }
                            } else if cellIndex == 4 {
                                if let hasToChangeCell = board.findCell(gridIndex: 4, cellIndex: gridIndex) {
                                    hasToChangeCell.emoji = emoji
                                    hasToChangeCell.title = miniGoal
                                    hasToChangeCell.memo = memo
                                    hasToChangeCell.progress = selectedStatus ?? .planned
                                    hasToChangeCell.completionDate = completionDate
                                }
                            }
                            // 변경 알림
                            try? modelContext.save()
                        }
                        
                        isFocused = false
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("작성")
                                .font(.pretendardMedium18)
                                .foregroundColor(.white)
                            Image("cat-paw5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28)
                                .colorInvert()
                            Spacer()
                        }
                    }
                    .modifier(BasicButton(buttonColor: emoji.isEmpty || miniGoal.isEmpty ? "D1D1D1":"444343", buttonWidth: 246))
                    .disabled(emoji.isEmpty || miniGoal.isEmpty)
                    
                    Spacer()
                        .frame(height: 20)
                }
                .ignoresSafeArea(.keyboard)
                .onAppear {
                    emoji = cell.emoji
                    miniGoal = cell.title
                    memo = cell.memo ?? ""
                    completionDate = cell.completionDate ?? ""
                    selectedStatus = cell.progress
                }
                
            } else {
                Text("셀을 찾을 수 없습니다")
                    .font(.pretendardBold18)
                    .foregroundColor(.red)
            }
            
        }

    }
        
        
}
    
