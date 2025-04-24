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
    var boardID: UUID
    var mainGoal: String
    
    // 보드 - 셀 간의 관계 설정 (보드가 삭제되면 자식셀들도 삭제)
    @Relationship(deleteRule: .cascade)
    var cells: [MandalartCell]
    
    init(boardID: UUID = UUID(), mainGoal: String) {
        self.boardID = boardID
        self.mainGoal = mainGoal
        self.cells = []
    }
    
    func findCell(gridIndex: Int, cellIndex: Int) -> MandalartCell? {
        if gridIndex == 4 {
            return cells.first { $0.cellIndex == cellIndex }
        }
        // 서브셀을 찾는 경우 - 서브셀은 메인 셀의 subcells 배열에 있음
        else {
            // 모든 메인 셀을 검색
            for mainCell in cells {
                // 각 메인 셀의 서브셀 중에서 gridIndex와 cellIndex가 일치하는 것 찾기
                if let foundSubcell = mainCell.subcells.first(where: {
                    $0.gridIndex == gridIndex && $0.cellIndex == cellIndex
                }) {
                    return foundSubcell
                }
            }
            return nil
        }
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
    
    
    // 셀의 데이터 바꾸는 함수
    func changeCellData(emoji: String, miniGoal: String, memo: String?, progress: TaskStatus, completionDate: String?) {
        
        // 셀 데이터 변경
        self.emoji = emoji
        self.title = miniGoal
        self.memo = memo
        self.progress = progress
        self.completionDate = completionDate
        
        
        // 메인셀 변경 시 쌍방 바인딩
        if self.gridIndex == 4 {
            for cell in self.subcells {
                if cell.gridIndex == self.cellIndex && cell.cellIndex == 4 {
                    cell.emoji = emoji
                    cell.title = miniGoal
                    cell.memo = memo
                    cell.progress = progress
                    cell.completionDate = completionDate
                }
            }
        }
        else if self.cellIndex == 4 {
            if let gridCell = self.parentCell {
                gridCell.emoji = emoji
                gridCell.title = miniGoal
                gridCell.memo = memo
                gridCell.progress = progress
                gridCell.completionDate = completionDate
            }
        }
        
       

    }
}
