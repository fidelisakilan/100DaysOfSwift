//
//  EditLocationView-ViewModel.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/30/26.
//

import Foundation

extension EditLocationView {
    @Observable
    class ViewModel {
        enum LoadingState {
            case loading, success, failed
        }
        
        let location: CLocation
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        init(location: CLocation, name: String, description: String) {
            self.location = location
            self.name = name
            self.description = description
            self.loadingState = LoadingState.loading
        }
        

        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(self.location.latitude)%7C\(self.location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                self.pages = items.query.pages.values.sorted()
                self.loadingState = .success
                print("Success")
            } catch {
                self.loadingState = .failed
                print(error.localizedDescription)
            }
        }
    }
}
