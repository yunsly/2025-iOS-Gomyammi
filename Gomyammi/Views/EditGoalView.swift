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
    @State private var isEditMode: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {
        VStack {
            // 배경색 설정
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
                            
                            TextField("이모지만 입력 가능합니다", text: $emoji)
                                .font(.pretendardRegular14)
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
                            TextField("메인 목표를 이루기 위한 세부 목표 세우기", text: $miniGoal)
                                .focused($isFocused)
                                .font(.pretendardRegular14)
                        }
                        .font(.pretendardBold15)
                        .frame(height: 30)
                        
                    }
                    .padding(.vertical)
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
                            updatedCell.changeCellData(emoji: emoji, miniGoal: miniGoal, memo: memo, progress: selectedStatus ?? .planned, completionDate: completionDate)
                            // 변경 알림
                            try? modelContext.save()
                        }
                        
                        isFocused = false
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isEditMode ? "수정하기" : "작성하기")
                                .font(.pretendardBold20)
                                .foregroundColor(.white)
                            Spacer()
                                .frame(width: 8)
                            Image("cat-paw5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .colorInvert()

                                
                            Spacer()
                        }
                    }
                    .modifier(BasicButton(buttonColor: emoji.isEmpty || miniGoal.isEmpty ? "D1D1D1":"444343", buttonWidth: 260))
                    .disabled(emoji.isEmpty || miniGoal.isEmpty)
                    
                    Text("삭제하기")
                        .foregroundColor(.red)
                        .font(.pretendardRegular14)
                        .onTapGesture {
                            showDeleteAlert = true
                        }
                    
                    Spacer()
                        .frame(height: 20)
                }
                .ignoresSafeArea(.keyboard)
                .onAppear {
                    // 기존의 데이터가 있다면
                    if cell.emoji != "" {
                        emoji = cell.emoji
                        miniGoal = cell.title
                        memo = cell.memo ?? ""
                        completionDate = cell.completionDate ?? ""
                        selectedStatus = cell.progress
                        isEditMode = true
                    }
                }
                .alert("이 목표를 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                    Button("삭제", role: .destructive) {
                        
                        print("목표 삭제: \(cell.title)")
                        cell.changeCellData(emoji: "", miniGoal: "", memo: "", progress: .planned, completionDate: "")
                        
                        // 하위 셀도 함께 삭제
                        if cell.cellIndex == 4 {
                            for i in 0..<9 where i != 4 {
                                if let childCell = board.findCell(gridIndex: cell.gridIndex, cellIndex: i) {
                                    childCell.changeCellData(emoji: "", miniGoal: "", memo: "", progress: .planned, completionDate: "")
                                }
                            }
                        }
                        dismiss()
                        try? modelContext.save()
                    }
                    Button("취소", role: .cancel) { }
                } message: {
                    Text("하위 목표도 함께 삭제됩니다.")
                }
                
            } else {
                Text("셀을 찾을 수 없습니다")
                    .font(.pretendardBold18)
                    .foregroundColor(.red)
            }
            
            
        }
        .safeAreaPadding(.top)
        .background(Color(hex: "f5f5f5")) // 배경색 지정
        .onTapGesture {
            isFocused = false // 포커스 해제하여 키보드 내림
        }
        
    }
    
    
}

