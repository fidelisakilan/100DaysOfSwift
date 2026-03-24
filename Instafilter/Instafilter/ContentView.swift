//
//  ContentView.swift
//  Instafilter
//
//  Created by Fidelis Akilan on 3/18/26.
//

import SwiftUI
import StoreKit
import PhotosUI
import StoreKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var intensity = 0.5
    @State private var radius = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    @AppStorage("filterCount") var filterCount: Int = 0
    @Environment(\.requestReview) var requestReview
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
                        .onChange(of: intensity, processImage)
                    Slider(value: $intensity)
                        .disabled(processedImage == nil)
                }
                HStack {
                    Text("Radius")
                    Slider(value: $radius)
                        .onChange(of: radius, processImage)
                        .disabled(processedImage == nil)

                }
                HStack {
                    Button("Change Filter") {
                        showingFilters.toggle()
                    }
                    .disabled(processedImage == nil)
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Pick a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixelate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.crystallize()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Comic Effect") { setFilter(CIFilter.comicEffect()) }
                Button("Dot Screen") { setFilter(CIFilter.dotScreen()) }
                Button("Kaleidoscope") { setFilter(CIFilter.kaleidoscope()) }
                Button("Cancel", role: .cancel) { }

            }
        }
    }
    
    
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
        let filterKeys = currentFilter.inputKeys
        if filterKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity, forKey: kCIInputIntensityKey) }
        if filterKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(radius * 200, forKey: kCIInputRadiusKey) }
        if filterKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity * 10, forKey: kCIInputScaleKey) }
        if filterKeys.contains(kCIInputAngleKey) { currentFilter.setValue(radius, forKey: kCIInputAngleKey) }
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        if filterCount == 3 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
