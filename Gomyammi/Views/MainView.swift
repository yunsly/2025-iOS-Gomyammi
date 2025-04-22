//
//  MainView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Query private var boards: [MandalartBoard]
    @State private var activeBoard: MandalartBoard?
    
    // mainGoal 수정모드
    @State private var isEditing = false
    @State private var editedGoal = ""
    
    // 통계 데이터를 위한 상태 변수들
    @State private var totalCells = 0
    @State private var plannedCells = 0
    @State private var inProgressCells = 0
    @State private var pausedCells = 0
    @State private var completedCells = 0
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                // 배경색 설정
                Color(hex: "f5f5f5").ignoresSafeArea()
                
                VStack {
                    // 메인목표 바
                    HStack(spacing: 10) {
                        Image("cat-paw5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26)
                        if let board = activeBoard {
                            if isEditing {
                                TextField("", text: $editedGoal)
                                    .onAppear {
                                        editedGoal = board.mainGoal
                                    }
                                    .onSubmit {
                                        board.mainGoal = editedGoal
                                        isEditing = false
                                    }
                            } else {
                                Text("\(board.mainGoal)")
                                    .onTapGesture {
                                        isEditing = true
                                    }
                            }
                        }
                    }
                    .modifier(WhiteBox(paddingValue: 15, height: 40))
                    
                    
                    
                    MandalartView(board: activeBoard ?? MandalartBoard(mainGoal: "load Error"))
                    
                    // 통계 바
                    ZStack(alignment: .bottom) {
                        // 배경이 되는 흰색 상자
                        VStack (spacing: 15) {
                            Text("포기는 배추셀 때나 하는 말이다냥")
                                .font(.pretendardSemiBold18)
                                .padding(.bottom, 15)
                            
                            // 통계 정보들 (컴포넌트 재사용)
                            HStack(spacing: 15) {
                                StatisticCardView(title: "전체", value: totalCells, textColor: "7B7B7B")
                                StatisticCardView(title: "예정", value: plannedCells, textColor: "7B7B7B")
                                StatisticCardView(title: "진행 중", value: inProgressCells, textColor: "7CA1F8")
                            }
                            //.padding(.bottom, 40) // 고양이가 들어갈 공간 확보
                            
                            HStack(spacing: 15) {
                                StatisticCardView(title: "임시", value: 0, textColor: "7CA1F8")
                                    .hidden()
                                StatisticCardView(title: "일시정지", value: pausedCells, textColor: "F2A46F")
                                StatisticCardView(title: "완료", value: completedCells, textColor: "F78080")
                            }
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, minHeight: 270)
                        
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                        )
                        
                        // 고양이 이미지를 상자 하단에 걸쳐서 배치
                        Image("running-cat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .offset(x: -100, y: 40) // 왼쪽으로도 이동
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    
                }
                .onAppear {
                    loadActiveBoard()
                }
                .onChange(of: activeBoard) { _, _ in
                    updateStatistics()
                }
            }
        }
        
    }
    
    // 전체 셀 개수와 각 상태별 개수를 계산하는 함수
    func calculateStatistics(for board: MandalartBoard?) -> (total: Int, planned: Int, inProgress: Int, paused: Int, completed: Int) {
        guard let board = board else {
            return (0, 0, 0, 0, 0)
        }
        
        var planned = 0
        var inProgress = 0
        var paused = 0
        var completed = 0
        var total = 0
        
        // 서브셀만 검사 -> 중복 방지
        for cell in board.cells {
            for subcell in cell.subcells {
                switch subcell.progress {
                case .planned:
                    if subcell.title.isEmpty == false {
                        planned += 1
                    }
                case .inProgress:
                    inProgress += 1
                case .paused:
                    paused += 1
                case .completed:
                    completed += 1
                }
            }
            total = planned + inProgress + paused + completed
        }
        
        return (total, planned, inProgress, paused, completed)
    }
    
    private func updateStatistics() {
        let stats = calculateStatistics(for: activeBoard)
        totalCells = stats.total
        plannedCells = stats.planned
        inProgressCells = stats.inProgress
        pausedCells = stats.paused
        completedCells = stats.completed
    }
    
    private func loadActiveBoard() {
        // UserDefaults에서 보드 정보 불러오기
        if let activeBoardID = UserDefaults.standard.string(forKey: "myNewMandalartBoardID") {
            // 제목으로 보드 찾기
            activeBoard = boards.first(where: { $0.boardID.uuidString == activeBoardID })
        } else if let firstBoard = boards.first {
            activeBoard = firstBoard
        }
        
        // 통계 업데이트
        updateStatistics()
    }
}

