//
//  MandalartView.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI



// 만다라트 9x9 그리드 뷰
struct MandalartView: View {
    
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
        NavigationLink(destination: GridDetailView(gridIndex: gridIndex, cellIndex: cellIndex), label: {
            if gridIndex == 4 && cellIndex == 4 {
                CatPawStamp(opacity: 0.7, size: 38, padding: 6)
                    .frame(width: 38, height: 38)
                    .background(Color.white)
            }
            else {
                Text("")
                    .frame(width: 38, height: 38)
                    .background((cellIndex == 4 && gridIndex != 4) || (gridIndex == 4 && cellIndex != 4) ? Color(hex: "f5f5f5") : Color.white)
            }
        })
    }
}


