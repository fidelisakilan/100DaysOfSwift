import MapKit
import SwiftUI

struct UserLocationView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    @State private var viewModel = ViewModel()
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .background(.white)
                                .frame(width: 44, height: 44)
                                .clipShape(.circle)
                                .onLongPressGesture(minimumDuration: 0.1) {
                                    viewModel.selectedPoint = location
                                }
                        }
                    }
                }
                .mapStyle(.hybrid)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPoint) { point in
                    EditLocationView(location: point) {
                        viewModel.update(location: $0)
                    }
                }
            }
        } else {
            Button("Authenticate", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    UserLocationView()
}
