//
//  MandalartView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI



// 만다라트 9x9 그리드 뷰
struct MandalartView: View {
    var mandalaBoard: MandalaBoard?
    
    var body: some View {
        
        VStack(spacing: 1) {
            ForEach(0..<3) { row in
                HStack(spacing: 1) {
                    ForEach(0..<3) { col in
                        let gridIndex = row * 3 + col
                        subGrid(for: gridIndex)
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding()
        
    }
    
    // 3x3 서브 그리드 생성
    func subGrid(for gridIndex: Int) -> some View {
        VStack(spacing: 1) {
            ForEach(0..<3) { row in
                HStack(spacing: 1) {
                    ForEach(0..<3) { col in
                        let cellIndex = row * 3 + col
                        createCell(for: gridIndex, cellIndex: cellIndex)
                        
                    }
                }
            }
        }
    }
    
    // 셀 버튼 생성
    func createCell(for gridIndex: Int, cellIndex: Int) -> some View {
        var task = getTask(gridIndex: gridIndex, cellIndex: cellIndex)
        
        return NavigationLink(destination: GridDetailView(gridIndex: gridIndex, cellIndex: cellIndex, task: task), label: {
            if gridIndex == 4 && cellIndex == 4 {
                CatPawStamp(opacity: 0.7, size: 38, padding: 6)
                    .frame(width: 38, height: 38)
                    .background(Color.white)
            }
            else {
                // 일반 셀 - 상태에 따라 표시
                //                Text("")
                //                    .frame(width: 38, height: 38)
                //                    .background((cellIndex == 4 && gridIndex != 4) || (gridIndex == 4 && cellIndex != 4) ? Color(hex: "f5f5f5") : Color.white)
                ZStack {
                    Rectangle()
                        .fill((cellIndex == 4 && gridIndex != 4) || (gridIndex == 4 && cellIndex != 4) ? Color(hex: "f5f5f5") : Color.white)
                        .frame(width: 38, height: 38)
                    
                    // 태스크가 있는 경우 내용 표시
                    if let task = task, !task.emoji.isEmpty {
                        Text(task.emoji)
                            .font(.system(size: 20))
                    }
                }
            }
        })
    }
    
    // 특정 위치의 task 가져오기
    private func getTask(gridIndex: Int, cellIndex: Int) -> MandalaTask? {
        guard let board = mandalaBoard, let mainTask = board.mainTask else {
            return nil
        }
        
        // 중앙은 mainTask
        if gridIndex == 4 && cellIndex == 4 {
            return mainTask
        }
        
        var allTasks: [MandalaTask] = [mainTask]
        
        if let subTasks = mainTask.subTasks {
            allTasks.append(contentsOf: subTasks)
            
            for subTask in subTasks {
                if let secondLevelTasks = subTask.subTasks {
                    allTasks.append(contentsOf: secondLevelTasks)
                }
            }
        }
        
        return allTasks.first { $0.gridIndex == gridIndex && $0.cellIndex == cellIndex }
    }
}


