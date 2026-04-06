//
//  UserUploadImageView.swift
//  ImageViewer
//
//  Created by Fidelis Akilan on 4/5/26.
//

import SwiftUI
import PhotosUI

struct UploadImageView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image? = nil
    @State private var imageData: Data? = nil
    @State private var name = ""
    @Environment(\.dismiss) var dismiss
    let onSave: (String, Data) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Preview") {
                        PhotosPicker(selection: $selectedItem) {
                            if let processedImage {
                                processedImage
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .padding()
                            } else {
                                ContentUnavailableView(
                                    "Upload Image",
                                    systemImage: "photo.badge.plus",
                                    description: Text("Click to import a photo")
                                )
                            }
                        }
                    }
                    Section("Enter Name") {
                        TextField("Add a caption for the uploaded image", text: $name)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", systemImage: "xmark", role: .close) { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Upload", systemImage: "checkmark", role: .confirm) { uploadImage() }
                        .disabled(name == "")
                }
            }
            .onChange(of: selectedItem, loadImage)
        }
    }
    
    func uploadImage() {
        if name != "" && imageData != nil {
            onSave(name, imageData!)
            dismiss()
        }
    }
    
    func loadImage() {
        Task {
            do {
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                guard let inputImage = UIImage(data: imageData) else { return }
                self.imageData = imageData
                processedImage = Image(uiImage: inputImage)
            } catch {
                print("error loading image \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    UploadImageView() { _,_ in }
}
