//
//  ContentView.swift
//  Instafilter
//
//  Created by Fidelis Akilan on 3/18/26.
//

import SwiftUI
import PhotosUI
import StoreKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var intensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView(
                            "No Picture",
                            systemImage: "photo.badge.plus",
                            description: Text("Tap to import a photo")
                        )
                    }
                }
                .onChange(of: selectedItem, loadImage)
                Spacer()
                HStack {
                    Text("Intensity")
                    Slider(value: $intensity)
                        .onChange(of: intensity, processImage)
                }
                HStack {
                    Button("Change Filter", action: changeFilter)
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
    
    func changeFilter() {}
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: imageData) else { return }
            let ciImage = CIImage(image: uiImage)
            currentFilter.setValue(ciImage, forKey: kCIInputImageKey)
            processImage()
        }
    }
    
    func processImage() {
        currentFilter.intensity = Float(intensity)
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
