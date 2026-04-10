//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Fidelis Akilan on 4/10/26.
//

import SwiftUI
import SwiftData

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filterType: FilterType
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    var title: String {
        switch filterType {
        case .none: "Everyone"
        case .contacted: "Contacted people"
        case .uncontacted: "Uncontacted people"
        }
    }
    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                        .bold()
                    Text(prospect.emailAddr)
                        .foregroundStyle(.secondary)
                }
            }
                .toolbar {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        let item = Prospect(name: "Akilan Amithasagaran", emailAddr: "fidelisakilan@gmail.com", isContacted: false)
                        modelContext.insert(item)
                    }
                }
                .navigationTitle(title)
        }
    }
    
    init(filterType: FilterType) {
        self.filterType = filterType
        let contacted = filterType == FilterType.contacted
        if filterType != .none {
            _prospects = Query(
                filter: #Predicate { $0.isContacted == contacted },
                sort: [SortDescriptor(\Prospect.name)])
        }
    }
}

#Preview {
    ProspectsView(filterType: .none)
        .modelContainer(for: Prospect.self)
}
