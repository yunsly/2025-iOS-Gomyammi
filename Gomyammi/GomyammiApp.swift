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
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainView()
            } else {
                OnboardingContainerView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
    }
}
