//
//  ContentView.swift
//  ViewAndModifiers
//
//  Created by Fidelis Akilan on 5/23/25.
//

import SwiftUI

struct CapsuleText: View  {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
    
}

struct GridStack<Content: View> : View {
    let rows: Int
    let columns: Int
    let content: (Int,Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows,id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id:\.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }
    
}


struct ContentView: View {
    var body: some View {
        CapsuleText(text: "Hello")
        Text("Hello, World")
            .titleStyle()
        Color.blue
            .frame(width: 200, height: 200)
            .watermarked(with: "Hacking with Swift")
        GridStack(rows: 5, columns: 5) { r, c in
            Text("\(r)\(c)")
        }
    }
}

#Preview {
    ContentView()
}
