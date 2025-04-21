//
//  GomyammiApp.swift
//  Gomyammi
//
//  Created by yunsly on 4/14/25.
//

import SwiftUI
import SwiftData

@main
struct GomyammiApp: App {
    // 온보딩 완료 여부를 저장
   // @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    // 테스트 용
    @State private var hasCompletedOnboarding: Bool = false
    
    var modelContainer: ModelContainer = {
        let schema = Schema([MandalartCell.self, MandalartBoard.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainView()    
            } else {
                OnboardingContainerView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
        .modelContainer(modelContainer)
        
    }
}
