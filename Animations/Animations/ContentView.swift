//
//  ContentView.swift
//  Animations
//
//  Created by Fidelis Akilan on 6/10/25.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount),anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    //    @State private var animationAmount = 1.0
    //    @State private var animeationAmtBinding = 1.0
    //    @State private var explicitAnimation = 1.0
    //    let letters = Array("Hello World")
    //    @State private var enabled = false
    //    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300,height: 300)
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 300,height: 300)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
        
        //        HStack(spacing: 0) {
        //            ForEach(0..<letters.count, id: \.self ) { num in
        //                Text(String(letters[num]))
        //                    .padding(5)
        //                    .font(.title)
        //                    .foregroundStyle(.white)
        //                    .background(enabled ? .red : .blue)
        //                    .offset(dragAmount)
        //                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
        //            }
        //        }
        //        .gesture(DragGesture()
        //            .onChanged { dragAmount = $0.translation }
        //            .onEnded { _ in
        //                dragAmount = .zero
        //                enabled.toggle()
        //            })
        
        
        
        //        LinearGradient(colors: [.red, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)
        //            .frame(width: 300,height: 200)
        //            .clipShape(.rect(cornerRadius: 10))
        //            .offset(dragAmount)
        //            .gesture(DragGesture()
        //                .onChanged { dragAmount = $0.translation }
        //                .onEnded { _ in
        //                    withAnimation(.easeInOut(duration: 0.5)) {
        //                        dragAmount = .zero
        //                    }
        //                }
        //            )
        //        VStack {
        //            Spacer()
        //            Button("Tap Me") { }
        //                .padding(50)
        //                .background(.red)
        //                .foregroundColor(.white)
        //                .clipShape(.circle)
        //                .overlay {
        //                    Circle()
        //                        .stroke(.red)
        //                        .scaleEffect(animationAmount)
        //                        .opacity(2 - animationAmount)
        //                        .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
        //                }.onAppear{
        //                    animationAmount = 2
        //                }
        //            Spacer()
        //        }
        
        //        VStack {
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
        //        }
        
        //        VStack {
        //            Spacer()
        //            Button("Tap Me") {
        //                withAnimation(.spring(duration: 1, bounce: 0.25)){
        //                    explicitAnimation += 360
        //                }
        //            }
        //            .padding(50)
        //            .background(.red)
        //            .foregroundColor(.white)
        //            .clipShape(.circle)
        //            .rotation3DEffect(.degrees(explicitAnimation), axis: (x:0.0, y: 1.0, z: 0.0))
        //            Spacer()
        //        }
        
    }
}

#Preview {
    ContentView()
}
