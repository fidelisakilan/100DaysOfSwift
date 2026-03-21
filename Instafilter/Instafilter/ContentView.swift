//
//  ContentView.swift
//  Instafilter
//
//  Created by Fidelis Akilan on 3/18/26.
//

import SwiftUI
import PhotosUI
import StoreKit

struct ContentView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @Environment(\.requestReview) var requestReview
    let example = Image(.example)
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
            PhotosPicker(
                selection: $pickerItems,
                maxSelectionCount: 3,
                matching: .any(of: [.images, .not(.screenshots)])
            ) {
                Label("Select a picture", systemImage: "photo")
            }
            ShareLink(
                item: example,
                preview: SharePreview("Example Image", image: example)) {
                Label("Click to share", systemImage: "airport")
            }
            Button("Leave a review") {
                requestReview()
            }
        }
        .padding()
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
