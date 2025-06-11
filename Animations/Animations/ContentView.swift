//
//  ContentView.swift
//  Animations
//
//  Created by Fidelis Akilan on 6/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var animeationAmtBinding = 1.0
    @State private var explicitAnimation = 1.0
    var body: some View {
        VStack {
            Spacer()
            Button("Tap Me") { }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(.circle)
            .overlay {
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
            }.onAppear{
                animationAmount = 2
            }
//            Spacer()
//            Stepper("Scale Amount", value: $animeationAmtBinding.animation(),in: 1...10)
//            Spacer()
//            Button("Tap Me") {
//                animeationAmtBinding += 1
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundStyle(.white)
//            .clipShape(.circle)
//            .scaleEffect(animeationAmtBinding)
//            Spacer()
            Spacer()
            Button("Tap Me") {
                withAnimation(.spring(duration: 1, bounce: 0.25)){
                    explicitAnimation += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(explicitAnimation), axis: (x:0.0, y: 1.0, z: 0.0))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
