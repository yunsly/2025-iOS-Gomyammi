//
//  OnboardingViews.swift
//  Gomyammi
//
//  Created by yunsly on 4/19/25.
//

import SwiftUI

// 첫 번째 온보딩 화면 - 고먐미 소개
struct OnboardingPage1: View {
    var nextPage: () -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Spacer()
                
                Text("안녕하냥, 인간! 나는 고먐미야.")
                    .font(.pretendardMedium24)
                    .multilineTextAlignment(.center)
                
                Text("나를 어떻게 사용하는지 알려줄거니까 잘들어!\n그냥 내가 심심해서 그러는거니까\n고맙다는 말은 필요없다냥.")
                    .font(.pretendardRegular15)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineSpacing(5)
                
                Spacer()
                
                // 고양이 이미지
                Image("cat-with-name")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                Spacer()
            }
            .padding()
            
            Spacer()
            
            // 다음 페이지 버튼
            Button(action: nextPage) {
                Text("계속")
                    .modifier(NextButton(buttonColor: "D1D1D1", textColor: "8A8484"))
            }
            .padding(.bottom, 40)
        }
    }
}

// 두 번째 온보딩 페이지
struct OnboardingPage2: View {
    var nextPage: () -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Spacer()
                
                Text("네 만다라트를 채우라냥!")
                    .font(.pretendardMedium24)
                    .multilineTextAlignment(.center)
                
                Text("다 채우지 못해도 상관없다냥.\n근데 하나씩 채워나가면...\n나도 좀 기분이 좋을지도?")
                    .font(.pretendardRegular15)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineSpacing(5)
                
                Spacer()
                
                // 만다라트 이미지 (추후 수정)
                Image("cat-with-name")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                Spacer()
                
            }
            .padding()
            
            Spacer()
            
            // 다음 페이지 버튼
            Button(action: nextPage) {
                Text("계속")
                    .modifier(NextButton(buttonColor: "D1D1D1", textColor: "8A8484"))
            }
            .padding(.bottom, 40)
        }
    }
}

// 세 번째 온보딩 페이지
struct OnboardingPage3: View {
    var nextPage: () -> Void
    
    var body : some View {
        VStack {
            VStack(spacing: 30) {
                Spacer()
                
                Text("달성률도 알려주겠댱!")
                    .font(.pretendardMedium24)
                    .multilineTextAlignment(.center)
                Text("세부 페이지에서 진척도를 표시하면\n특별히 내가 통계 페이지에\n정리해주겠다냥")
                    .font(.pretendardRegular15)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineSpacing(5)
                
                Spacer()
                
                
                // 진도 표시 바
                
                // 통계 바
                
                Spacer()
                
            }
            // 다음 페이지 버튼
            Button(action: nextPage) {
                Text("계속")
                    .modifier(NextButton(buttonColor: "D1D1D1", textColor: "8A8484"))
            }
            .padding(.bottom, 40)
        }
    }
}

// 네 번째 온보딩 페이지
struct OnboardingPage4: View {
    var nextPage: () -> Void
    
    var body: some View {
        
        VStack {
            VStack(spacing: 30) {
                Spacer()
                
                Text("큰 목표부터 차근차근!")
                    .font(.pretendardMedium24)
                    .multilineTextAlignment(.center)
                
                Text("절대 욕심부리지 말라냥.\n목표를 쪼개는 연습을 하는거다!\n준비 됐으면 가보쟝!")
                    .font(.pretendardRegular15)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineSpacing(5)
                
                Spacer()
                
                // 고양이 이미지
                Image("close-eye-cat")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                Spacer()
            }
            // 다음 페이지 버튼
            Button(action: nextPage) {
                Text("시작하기")
                    .modifier(NextButton(buttonColor: "444343", textColor: "FFFFFF"))
            }
            .padding(.bottom, 40)
        }
    }
}

// 다섯 번째 온보딩 페이지
struct OnboardingPage5: View {
    var nextPage: () -> Void
    @State var mainGoal: String = ""
    @State var mainGoalmemo: String = ""
    @FocusState var isFocused: Bool
    
    // SwiftData 모델 컨텍스트 추가
    @Environment(\.modelContext) private var modelContext
    
    // 버튼 활성화 상태 확인
    var isButtonEnabled: Bool {
        return !mainGoal.isEmpty
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = false // 포커스 해제하여 키보드 내림
                }
            VStack {
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("이루고 싶은 목표가 있냥?")
                        .font(.pretendardMedium24)
                        .multilineTextAlignment(.center)
                    
                    Text("만다라트를 사용하기 위한 최죵 목표!\n작성 이후 수정도 가능하니 부담가지지 말라냥!")
                        .font(.pretendardRegular15)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .lineSpacing(5)
                    
                    // 목표 입력 영역
                    VStack (spacing: 30) {
                        HStack {
                            Text("Goal")
                            Spacer()
                                .frame(width: 10)
                            TextField("메인 목표", text: $mainGoal)
                                .font(.pretendardRegular14)
                                .focused($isFocused)
                        }
                        .font(.pretendardBold15)
                        .modifier(WhiteBox(paddingValue: 15, height: 40))
                        
                        VStack {
                            Spacer()
                                .frame(height: 10)
                            HStack {
                                Text("memo (선택)")
                                    .font(.pretendardBold15)
                                Spacer()
                            }
                            
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                                    .frame(height: 130) // 하얀 박스의 높이에 맞게 조정
                                
                                TextEditor(text: $mainGoalmemo)
                                    .font(.pretendardRegular14)
                                    .padding(4)
                                    .background(Color.clear)
                                    .scrollContentBackground(.hidden)
                                    .focused($isFocused)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .modifier(WhiteBox(paddingValue: 10, height: 170))
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                }
                // 다음 페이지 버튼
                Button(action: {
                    nextPage()
                    createNewMandalart()
                }) {
                    Text("만다라트 만들기")
                        .modifier(NextButton(buttonColor: "444343", textColor: "FFFFFF"))
                }
                .disabled(!isButtonEnabled)
                .padding(.bottom, 40)
                
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    // 만다라트 데이터 생성 함수
    private func createNewMandalart() {
        // 1. mainTask 생성
        var mainTask = MandalaTask(emoji: "🐾", miniGoal: mainGoal, memo: mainGoalmemo, gridIndex: 4, cellIndex: 4)
        mainTask.progress = .inProgress
        
        // 2. 8개의 1차 subTask 생성
        let centerGridCellIndices = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        for (i, cellIdx) in centerGridCellIndices.enumerated() {
            let subTask = MandalaTask(emoji: "", miniGoal: "", memo: "", gridIndex: 4, cellIndex: cellIdx)
            subTask.progress = .planned
            subTask.parentTask = mainTask
            
            if mainTask.subTasks == nil {
                mainTask.subTasks = [subTask]
            } else {
                mainTask.subTasks?.append(subTask)
            }
            
            // 3. 각 1차 서브태스크에 대해 8개의 2차 서브태스크 생성
            // 해당 서브태스크 그리드의 셀 인덱스 (중앙 4를 제외한 0-8)
            let subGridIndex = i > 3 ? i + 1 : i // 중앙 그리드(4)를 건너뛰기 위한 조정
            
            for subCellIdx in centerGridCellIndices {
                let secondLevelTask = MandalaTask(emoji: "", miniGoal: "", memo: "", gridIndex: subGridIndex, cellIndex: subCellIdx)
                secondLevelTask.progress = .planned
                secondLevelTask.parentTask = subTask
                
                if subTask.subTasks == nil {
                    subTask.subTasks = [secondLevelTask]
                } else {
                    subTask.subTasks?.append(secondLevelTask)
                }
            }
        }
        
        
        // 4. 만다라트 보드 생성
        var mandalaBoard = MandalaBoard(mainGoal: mainGoal)
        mandalaBoard.mainTask = mainTask
        
        
        // 5. 모델 컨텍스트 저장
        modelContext.insert(mandalaBoard)
        
        // 6. 변경 사항 저장 시도
        do {
            try modelContext.save()
            print("Your new Mandalart board is created!")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
