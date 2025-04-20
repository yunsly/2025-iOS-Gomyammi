//
//  MandalartModels.swift
//  Gomyammi
//
//  Created by yunsly on 4/14/25.
//

import Foundation
import SwiftData

@Model
class MandalaTask {
    // 셀 정보
    var id: UUID
    var emoji: String
    var miniGoal: String
    var memo: String
    
    
    // 진취도
    var progress: TaskStatus
    
    // 완료 여부 및 완료 일자
    var isCompleted: Bool
    var completedAt: Date?
    
    // 관계 프로퍼티
    @Relationship(deleteRule: .cascade) var subTasks: [MandalaTask]?
    var parentTask: MandalaTask?
    
    // 위치 프로퍼티
    var gridIndex: Int
    var cellIndex: Int
    
    init(emoji: String, miniGoal: String, memo: String, gridIndex: Int, cellIndex: Int) {
        self.id = UUID()
        self.emoji = emoji
        self.miniGoal = miniGoal
        self.memo = memo
        
        self.progress = .planned
        self.isCompleted = false
        
        self.gridIndex = gridIndex
        self.cellIndex = cellIndex
    }

    
}


// 만다라트 전체 보드
@Model
class MandalaBoard {
    var id: UUID
    var mainGoal: String
    
    var isCompleted: Bool
    var completedDate: Date?
    
    // 중앙 Task 와의 관계
    @Relationship var mainTask: MandalaTask?
    
    init(mainGoal: String) {
        self.id = UUID()
        self.mainGoal = mainGoal
        self.isCompleted = false
    }
    
}

