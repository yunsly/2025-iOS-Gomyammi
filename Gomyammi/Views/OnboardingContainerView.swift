//
//  OnboardingContainerView.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI

struct OnboardingContainerView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경색 설정
                Color(hex: "f5f5f5").ignoresSafeArea()
                
                // 현재 페이지에 따라 적절한 온보딩 뷰 표시
                Group {
                    switch currentPage {
                    case 0:
                        OnboardingPage1 {
                            withAnimation {
                                currentPage = 1
                            }
                        }
                    case 1:
                        OnboardingPage2 {
                            withAnimation {
                                currentPage = 2
                            }
                        }
                    case 2:
                        OnboardingPage3 {
                            withAnimation {
                                currentPage = 3
                            }
                        }
                    case 3:
                        OnboardingPage4 {
                            withAnimation {
                                currentPage = 4
                            }
                        }
                    case 4:
                        OnboardingPage5 {
                            withAnimation {
                                // 온보딩 완료 처리
                                hasCompletedOnboarding = true
                            }
                        }
                        
                    default:
                        EmptyView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if currentPage > 0 {
                        Button(action: {
                            withAnimation {
                                currentPage -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}
