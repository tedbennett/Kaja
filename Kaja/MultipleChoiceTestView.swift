//
//  MultipleChoiceTestView.swift
//  Kaja
//
//  Created by Ted Bennett on 11/07/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import SwiftUI

struct MultipleChoiceTestView: View {
    var questions: [String : String]
    @State private var text = "Test"
    @State private var questionIndex = 0
    @State private var complete = false
    @State private var transitioning = false
    
    var body: some View {
        VStack {
            Text(text).font(.largeTitle)
                .padding(60)
                .animation(.easeInOut)
                .transition(.slide)
                .id("MyTitleComponent" + text)
            ForEach(0..<2) { row in
                HStack {
                    ForEach(0..<2) { col in
                        ButtonView(transitioning: self.$transitioning, questionIndex: self.$questionIndex, complete: self.$complete, answerSet: ["a", "b", "c"])
                            .frame(width: 100, height: 100)
                        
                    }.padding(10)
                }
            }
        }.navigationBarTitle("Hi", displayMode: .inline)
            .sheet(isPresented: $complete) {
                TestFinishedView()
        }
        
    }
    
    func onGuess(at index: Int) {
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceTestView(questions: ["ㅏ":"a",
                                           "ㅑ":"ya",
                                           "ㅓ":"eo",
                                           "ㅕ":"yeo",
                                           "ㅗ":"o",
                                           "ㅛ":"yo",
                                           "ㅜ":"u",
                                           "ㅠ":"yu",
                                           "ㅡ":"eu",
                                           "ㅣ":"i"]
        )
    }
}


struct ButtonView: View {
    @State private var colour: Color = .gray
    @Binding var transitioning: Bool
    @Binding var questionIndex: Int
    @Binding var complete: Bool
    var answerSet: [String]
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(self.colour)
                .cornerRadius(20)
                .animation(.easeInOut)
                .transition(.opacity)
            
            Text(answerSet[questionIndex]).font(.largeTitle)
                .foregroundColor(.white)
                .padding(10)
                .animation(.easeInOut)
                .transition(.slide)
            
            
        }.onTapGesture {
            self.transitioning = true
            self.colour = self.answerSet[self.questionIndex] == "b" ? .green : .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.colour = .gray
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if self.questionIndex < self.answerSet.count - 1 {
                        self.questionIndex += 1
                    } else {
                        self.complete = true
                    }
                    self.transitioning = false
                }
            }
        }
        .allowsHitTesting(!transitioning)
    }
}
