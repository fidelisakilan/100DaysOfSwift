//
//  ImageDetailView.swift
//  ImageViewer
//
//  Created by Fidelis Akilan on 4/5/26.
//

import SwiftUI

struct ImageDetailView: View {
    let post: Post
    var body: some View {
        VStack {
            if let image = post.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .padding(.trailing)
            }
        }
        .navigationTitle(post.name)
    }
}

//#Preview {
//    ImageDetailView()
//}
