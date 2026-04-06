import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var showUploadSheet = false
    @State private var userImages = [Post]()
    let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
    let locationFetcher = LocationFetcher()
    var body: some View {
        NavigationStack {
            Form {
                ForEach(userImages.sorted(), id: \.id) { item in
                    NavigationLink(value: item) {
                        HStack {
                            Text(item.name)
                                .bold()
                            Spacer()
                            if let image = item.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(.circle)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Post.self) { post in
                ImageDetailView(post: post)
            }
            .navigationTitle("ImageViewer")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Upload Image", systemImage: "plus") {
                        locationFetcher.start()
                        if locationFetcher.lastKnownLocation != nil {
                            showUploadSheet.toggle()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showUploadSheet) { UploadImageView() {
            name, imageData in
            let latitude = locationFetcher.lastKnownLocation?.latitude
            let longitude = locationFetcher.lastKnownLocation?.longitude
            if latitude != nil && longitude != nil {
                let newPost = Post(id: UUID(), name: name, imageData: imageData, latitude: latitude!, longitude: longitude!)
                save(newPost)
            }
        }
        }
        .onAppear { loadAllImages() }
    }
    
    func loadAllImages() {
        do {
            let data = try Data(contentsOf: savePath)
            userImages = try JSONDecoder().decode([Post].self, from: data)
        } catch {
            print("Error loading db, \(error.localizedDescription)")
            userImages = []
        }
        
    }
    
    func save(_ post: Post) {
        userImages.append(post)
        do {
            let data = try JSONEncoder().encode(userImages)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error saving db, \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    ContentView()
}
