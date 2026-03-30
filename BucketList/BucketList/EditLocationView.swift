//
//  EditLocationView.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/27/26.
//

import SwiftUI

struct EditLocationView: View {
    @Environment(\.dismiss) private var dismiss
    let onSave: (CLocation) -> Void
    @State private var viewModel: ViewModel
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name",text: $viewModel.name)
                    TextField("Description",text: $viewModel.description)
                }
                Section("Nearby..") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading..")
                    case .success:
                        ForEach(viewModel.pages, id: \.pageid) { page in
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
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: CLocation, onSave: @escaping (CLocation) -> Void) {
        _viewModel = State(initialValue: ViewModel(
            location: location,
            name: location.name,
            description: location.description))
        self.onSave = onSave
    }
    
}

#Preview {
    EditLocationView(location: .example) { _ in }
}
