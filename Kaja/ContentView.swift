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
                NavigationLink(destination: TestView()) {
                    Text("Vowels")
                }
                Spacer()
                NavigationLink(destination: TestView()) {
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
