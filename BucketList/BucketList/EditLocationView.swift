//
//  EditLocationView.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/27/26.
//

import SwiftUI

struct EditLocationView: View {
    let location: CLocation
    let onSave: (CLocation) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var description: String
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name",text: $name)
                    TextField("Description",text: $description)
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
        }
    }
    init(location: CLocation, onSave: @escaping (CLocation) -> Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

#Preview {
    EditLocationView(location: .example) { _ in }
}
