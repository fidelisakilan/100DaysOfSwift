//
//  ImageDetailView.swift
//  ImageViewer
//
//  Created by Fidelis Akilan on 4/5/26.
//

import SwiftUI
import MapKit

struct ImageDetailView: View {
    let post: Post
    var body: some View {
        Form {
            Section("Image") {
                if let image = post.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.circle)
                        .padding(.trailing)
                }
            }
            Section("Location") {
                Map(interactionModes: []) {
                    Marker("Taken At", coordinate: post.coordinate)
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .navigationTitle(post.name)
    }
}

//#Preview {
//    ImageDetailView()
//}
