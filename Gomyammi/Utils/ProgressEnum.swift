//
//  ProgressEnum.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI

enum TaskStatus: String, CaseIterable, Identifiable, Codable {
    
    case planned = "예정"
    case inProgress = "진행 중"
    case paused = "일시정지"
    case completed = "완료"
    
    var id: Self { self }
    
    var imageName: String {
        switch self {
        case .planned: return "icon-plan"
        case .inProgress: return "icon-ing"
        case .paused: return "icon-pause"
        case .completed: return "icon-complete"
        }
    }
}
