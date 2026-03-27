//
//  UserLocationView.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/27/26.
//

import MapKit
import SwiftUI

struct UserLocationView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    @State private var locations = [CLocation]()
    @State private var selectedPoint: CLocation?
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .background(.white)
                            .frame(width: 44, height: 44)
                            .clipShape(.circle)
                            .onLongPressGesture(minimumDuration: 0.1) {
                                selectedPoint = location
                            }
                    }
                }
            }
            .mapStyle(.hybrid)
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = CLocation(id: UUID(), name: "New Pin", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
            .sheet(item: $selectedPoint) { point in
                EditLocationView(location: point) { newLocation in
                    if let index = locations.firstIndex(of: point) {
                        locations[index] = newLocation
                    }
                }
            }
        }
    }
}

#Preview {
    UserLocationView()
}
