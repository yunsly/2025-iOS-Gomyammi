//
//  StatusButtonView.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI

struct StatusButton: View {
    let status: TaskStatus
    @Binding var selectedStatus: TaskStatus?
    @Binding var completionDate: String
    
    // 버튼의 크기와 투명도를 제어하는 상태 변수
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            Image(status.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: isPressed && selectedStatus == status ? 70 : 50)
                .opacity(selectedStatus == status || selectedStatus == nil ? 1.0 : 0.6)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        // 같은 버튼을 두 번 누르면 선택 해제
                        if selectedStatus == status {
                            selectedStatus = nil
                            isPressed = false
                            // 완료 상태를 해제할 경우 완료 일자도 초기화
                            if status == .completed {
                                completionDate = ""
                            }
                        } else {
                            selectedStatus = status
                            isPressed = true
                            // 완료 버튼을 누르면 현재 날짜 저장
                            if status == .completed {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy / MM / dd"
                                completionDate = formatter.string(from: Date())
                            }
                        }
                    }
                }
            
            Text(status.rawValue)
                .font(.caption)
                .foregroundColor(selectedStatus == status ? .primary : .secondary)
        }
        .padding(.horizontal, 8)
    }
}

struct StatusButtonsView: View {
    @Binding var selectedStatus: TaskStatus?
    @Binding var completionDate: String

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(TaskStatus.allCases.enumerated()), id: \.element.id) { index, status in
                if index > 0 {
                    Spacer()
                }
                StatusButton(status: status, selectedStatus: $selectedStatus, completionDate: $completionDate)
            }
        }
        .modifier(WhiteBox(paddingValue: 10, height: 100))
    }
}
