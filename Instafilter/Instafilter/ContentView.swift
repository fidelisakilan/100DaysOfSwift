//
//  ContentView.swift
//  Instafilter
//
//  Created by Fidelis Akilan on 3/18/26.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    var body: some View {
        VStack {
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            } else {
                ContentUnavailableView("No Image", systemImage: "swift")
            }
        }
        .onAppear(perform: loadImage)
        .padding()
    }
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        
        currentFilter.inputImage = beginImage
        let amount = 50
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
