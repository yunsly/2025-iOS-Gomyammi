//
//  NavigationManager.swift
//  Gomyammi
//
//  Created by yunsly on 4/18/25.
//

import SwiftUI

enum ViewType: Hashable {
    case onBoarding
    case mainView
    case gridDetailView
    case editGridView
}

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    // 화면 전환하기
    func navigate(to destination: ViewType) {
        path.append(destination)
    }
    
    // 루트로 이동하기
    func poptoRoot() {
        path.removeLast(path.count)
    }
    
    // 뒤로가기
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
//    // 내 마음대로 커스텀, 1 - 2 - 3 - 4 순으로 이동하기
//    func oneTwoThreeFour() {
//        path.append("1")
//        path.append("2")
//        path.append("3")
//        path.append("4")
//    }
}
