//
//  ContentView.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/25/26.
//

import SwiftUI
import Foundation

extension FileManager {
    func loadFile(name: String, content: String) -> URL? {
        let data = Data(content.utf8)
        let url = URL.documentsDirectory.appendingPathComponent(name)
        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            return url
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed")
    }
}
struct ContentView: View {
    enum LoadingState {
        case loading, success, failed
    }
    @State private var loadingState = LoadingState.success
    var body: some View {
        Spacer()
        Button("Read and Write") {
            let url = FileManager.default.loadFile(name: "message.txt", content: "Text Message")
            Task {
                if let url {
                    let input = try String(contentsOf: url, encoding: .utf8)
                    print(input)
                }
            }
        }
        Spacer()
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
        Spacer()
    }
}

#Preview {
    ContentView()
}
