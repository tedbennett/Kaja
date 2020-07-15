//
//  ContentView.swift
//  Kaja
//
//  Created by Ted Bennett on 11/07/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var englishToKorean = true
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: MultipleChoiceTestView(dict: hangulVowels)) {
                    Text("Vowels")
                }
                Spacer()
                NavigationLink(destination: MultipleChoiceTestView(dict: hangulConsonants)) {
                    Text("Consonants")
                }
                Spacer()
                Button(action: {
                    self.englishToKorean.toggle()
                }) {
                    Text(englishToKorean ? "English -> Korean" : "Korean -> English")
                }
                Spacer()
            }.navigationBarTitle("Kaja!")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let hangulVowels = ["ㅏ":"a",
                    "ㅑ":"ya",
                    "ㅓ":"eo",
                    "ㅕ":"yeo",
                    "ㅗ":"o",
                    "ㅛ":"yo",
                    "ㅜ":"u",
                    "ㅠ":"yu",
                    "ㅡ":"eu",
                    "ㅣ":"i",
                    "ㅔ":"e",
                    "ㅐ":"ae",
                    "ㅒ":"yae",
                    "ㅖ":"ye"
]

let  hangulConsonants = ["ㄱ":"g",
                         "ㄴ":"n",
                         "ㄷ":"d",
                         "ㄹ":"l/r",
                         "ㅁ":"m",
                         "ㅂ":"b",
                         "ㅅ":"s",
                         "ㅇ":"ng",
                         "ㅈ":"j",
                         "ㅊ":"ch",
                         "ㅋ":"k",
                         "ㅌ":"t",
                         "ㅍ":"p",
                         "ㅎ":"h"]


