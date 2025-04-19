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
    
    @State private var emoji: String = ""
    @State private var miniGoal: String = ""
    @State private var memo: String = ""
    
    @State private var selectedStatus: TaskStatus?
    @State private var completionDate: String = ""
     
    var body: some View {
        ZStack {
            // 배경색 설정
            
            Color(hex: "f5f5f5").ignoresSafeArea()
            VStack (spacing: 20) {
                HStack {
                    Spacer()
                        .frame(width: 16)
                    Text("세부 목표 설정이다냥")
                        .font(.pretendardBold21)
                    Spacer()
                    
                }
                
                VStack{
                    HStack {
                        Text("Emoji")
                        Spacer()
                            .frame(width: 35)
                        TextField("🔥", text: $emoji)
                            .font(.pretendardRegular14)
                    }
                    .font(.pretendardBold15)
                    .frame(height: 30)
                    Divider()
                    
                    
                    HStack {
                        Text("Mini goal")
                        Spacer()
                            .frame(width: 10)
                        TextField("디자인한테 달려가기", text: $miniGoal)
                            .font(.pretendardRegular14)
                    }
                    .font(.pretendardBold15)
                    .frame(height: 30)
                }
                .modifier(WhiteBox(paddingValue: 10, height: 90))
                
                VStack {
                    Spacer()
                        .frame(height: 10)
                    HStack {
                        Text("memo (선택)")
                            .font(.pretendardBold15)
                        Spacer()
                    }
                    
                    TextField("", text: $memo)
                        .font(.pretendardRegular14)
                    Spacer()
                }
                .modifier(WhiteBox(paddingValue: 10, height: 150))
                
                HStack {
                    Text("완료 일자")
                    Spacer()
                        .frame(width: 35)
                    Text("\(completionDate)")
                        .font(.pretendardRegular14)
                }
                .font(.pretendardBold15)
                .modifier(WhiteBox(paddingValue: 10, height: 40))
                
                Text("진척도")
                    .font(.pretendardSemiBold13)
                StatusButtonsView(selectedStatus: $selectedStatus, completionDate: $completionDate)
                            
            }
        }
        Text("\(gridIndex), \(cellIndex)")
    }
}
