//
//  MultipleChoiceTestView.swift
//  Kaja
//
//  Created by Ted Bennett on 11/07/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import SwiftUI

struct MultipleChoiceTestView: View {
    var questions: [String]
    var answers: [String]
    var buttonLetters: [[String]]
    //var lookup: [String:String]
    
    @State private var currentQuestion = ""
    @State private var questionIndex = 0
    @State private var complete = false
    @State private var transitioning = false
    
    
    init(dict: [String:String]) {
        (self.questions, self.buttonLetters) = generateArrays(from: dict, number: 4)
        self.answers = self.questions.map { dict[$0]! }
    }
    
    
    var body: some View {
        VStack {
            Text(questions[questionIndex]).font(.largeTitle)
                .padding(60)
                .animation(.easeInOut)
                .transition(.slide)
                .id("MyTitleComponent" + questions[questionIndex])
            ForEach(0..<2) { row in
                HStack {
                    ForEach(0..<2) { col in
                        ButtonView(transitioning: self.$transitioning, questionIndex: self.$questionIndex, complete: self.$complete, buttonLetters: self.buttonLetters[(2*row + col)], answers: self.answers)
                            .frame(width: 100, height: 100)
                        
                    }.padding(10)
                }
            }
        }.navigationBarTitle("Hi", displayMode: .inline)
            .sheet(isPresented: $complete) {
                TestFinishedView()
        }
        
    }
    
    func refreshAnswers() {
        
    }
    
    struct ButtonView: View {
        @State private var colour: Color = .gray
        @Binding var transitioning: Bool
        @Binding var questionIndex: Int
        @Binding var complete: Bool
        var buttonLetters: [String]
        var answers: [String]
        
        var body: some View {
            ZStack {
                Rectangle().foregroundColor(self.colour)
                    .cornerRadius(20)
                    .animation(.easeInOut)
                    .transition(.opacity)
                
                Text(buttonLetters[questionIndex]).font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(10)
                    .animation(.easeInOut)
                    .transition(.scale)
                    .id("Button \(buttonLetters[questionIndex]))")
                
                
            }.onTapGesture {
                self.transitioning = true
                self.colour = self.buttonLetters[self.questionIndex] == self.answers[self.questionIndex] ? .green : .red
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.colour = .gray
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        if self.questionIndex < self.buttonLetters.count - 1 {
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
    
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceTestView(dict: ["ㅏ":"a",
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


func generateArrays(from dict: [String:String], number: Int) -> (questions: [String], answers: [[String]]) {
    // 'Question' letters at the top of the multiple choice view
    let questions = Array(dict.keys).shuffled()
    let solutions = Array(dict.values)
    var answers: Array<Array<String>> = Array(repeating: [String](), count: number)
    for key in questions {
        var subSolutions = solutions.shuffled()[..<number]
        if !subSolutions.contains(dict[key]!) {
            subSolutions[Int.random(in: 0..<number)] = dict[key]!
        }
        for index in 0..<number {
            answers[index].append(subSolutions[index])
        }
    }
    return (questions, answers)
}
