//
//  TestView.swift
//  Kaja
//
//  Created by Ted Bennett on 11/07/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Text("Test").font(.largeTitle)
                .padding(60)
            ForEach(0..<2) {_ in
                HStack {
                    ForEach(0..<2) {_ in
                        ZStack {
                            Rectangle().foregroundColor(.gray)
                                .cornerRadius(10)
                            Button(action: {}) {
                                Text("a").font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 60, height: 60)
                        .padding(20)
                    }
                }
            }
        }.navigationBarTitle("Hi", displayMode: .inline)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
