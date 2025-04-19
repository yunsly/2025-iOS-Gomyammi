//
//  MandalartModels.swift
//  Gomyammi
//
//  Created by yunsly on 4/14/25.
//

import SwiftUI
import SwiftData


struct MandalartData {
    var title: String
    var subGoals: [[String]] // 3x3 구조의 각 셀에 대한 8개 목표
    
    init() {
        self.title = "Challenge 2 완수하기"
        
        var subGoals = Array(repeating: Array(repeating: "", count: 9), count: 9)
        subGoals[4][4] = "Challenge 2 완수하기"
        
        self.subGoals = subGoals
    }
}
