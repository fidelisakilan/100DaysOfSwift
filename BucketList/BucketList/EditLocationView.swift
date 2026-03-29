//
//  EditLocationView.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/27/26.
//

import SwiftUI

struct EditLocationView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    let location: CLocation
    let onSave: (CLocation) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var description: String
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name",text: $name)
                    TextField("Description",text: $description)
                }
                Section("Nearby..") {
                    switch loadingState {
                    case .loading:
                        Text("Loading..")
                    case .success:
                        ForEach(pages, id: \.pageid) { page in
                                Text("\(page.title)").font(.headline) + Text(": ") + Text(page.description).italic()
                        }
                    case .failed:
                        Text("Failed to load")
                    }
                }
            }
            .navigationTitle("Edit Pin")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location: CLocation, onSave: @escaping (CLocation) -> Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .success
        } catch {
            loadingState = .failed
            print(error.localizedDescription)
        }

        
    }
}

#Preview {
    EditLocationView(location: .example) { _ in }
}
