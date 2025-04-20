//
//  EditGoalView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI

struct EditGoalView: View {
    
    let gridIndex: Int
    let cellIndex: Int
    var task: MandalaTask? // 수정 중인 태스크
    @Environment(\.modelContext) private var modelContext
    
    @State private var emoji: String = ""
    @State private var miniGoal: String = ""
    @State private var memo: String = ""
    
    @State private var selectedStatus: TaskStatus? = .planned
    @State private var completionDate: String = ""
    
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            // 배경색 설정
            
            Color(hex: "f5f5f5").ignoresSafeArea()
                .onTapGesture {
                    isFocused = false // 포커스 해제하여 키보드 내림
                }
            VStack (spacing: 20) {
                Spacer()
                
                HStack {
                    Spacer()
                        .frame(width: 20)
                    Text("세부 목표 설정이다냥")
                        .font(.pretendardBold21)
                    Spacer()
                    
                }
                
                VStack{
                    HStack {
                        Text("Emoji")
                        Spacer()
                            .frame(width: 35)
                        TextField("🐾", text: $emoji)
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
                StatusButtonsView(selectedStatus: $selectedStatus, completionDate: $completionDate)
                
                Spacer()
                
                Button {
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
                .modifier(BasicButton(buttonColor: "444343", buttonWidth: 246))
                Spacer()
                    .frame(height: 20)
            }
            .ignoresSafeArea(.keyboard)
        }
        
        //Text("\(gridIndex), \(cellIndex)")
    }
    
}
