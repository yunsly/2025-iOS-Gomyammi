//
//  MandalartModels.swift
//  Gomyammi
//
//  Created by yunsly on 4/14/25.
//

import SwiftUI
import SwiftData

@Model
class MandalartBoard {
    var mainGoal: String
    
    // 보드 - 셀 간의 관계 설정 (보드가 삭제되면 자식셀들도 삭제)
    @Relationship(deleteRule: .cascade)
    var cells: [MandalartCell]
    
    init(mainGoal: String) {
        self.mainGoal = mainGoal
        self.cells = []
    }
    
    func findCell(gridIndex: Int, cellIndex: Int) -> MandalartCell? {
        return cells.first { $0.gridIndex == gridIndex && $0.cellIndex == cellIndex }
    }
}


@Model
class MandalartCell {
    var emoji: String
    var title: String
    var memo: String?
    var progress: TaskStatus
    var hasSubcells: Bool
    var completionDate: String?
    
    // 부모 셀을 참조하는 속성 추가
    @Relationship(deleteRule: .cascade, inverse: \MandalartCell.subcells)
    var parentCell: MandalartCell?
    
    // 하위 셀들 (있다면)
    @Relationship(deleteRule: .cascade)
    var subcells: [MandalartCell] = []
    
    
    // 셀 위치
    var gridIndex: Int
    var cellIndex: Int

    init(emoji: String, title: String, hasSubcells: Bool, gridIndex: Int, cellIndex: Int) {
        self.emoji = emoji
        self.title = title
        self.hasSubcells = hasSubcells
        self.gridIndex = gridIndex
        self.cellIndex = cellIndex
        self.progress = .planned
    }
    
}
