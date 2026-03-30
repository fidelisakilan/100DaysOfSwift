//
//  UserLocationView-ContentView.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/29/26.
//

import Foundation
import MapKit
import LocalAuthentication

extension UserLocationView {
    @Observable
    class ViewModel {
        var isUnlocked = false
        var locations = [CLocation]()
        var selectedPoint: CLocation?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var showError = false

        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([CLocation].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate to view your places"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    if success {
                        self.isUnlocked = true
                        print("is unlocked")
                    } else {
                        self.showError.toggle()
                        print("Failed to unlock \(error?.localizedDescription)")
                    }
                }
            } else {
                self.showError.toggle()
                print("Failed to unlock \(error?.localizedDescription)")
            }
            
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Error during save")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = CLocation(id: UUID(), name: "New Pin", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: CLocation) {
            guard let selectedPoint else { return }
            if let index = locations.firstIndex(of: selectedPoint) {
                locations[index] = location
                save()
            }
        }
    }
    
}
