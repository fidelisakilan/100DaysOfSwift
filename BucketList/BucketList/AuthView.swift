//
//  AuthView.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/26/26.
//

import SwiftUI
import LocalAuthentication

struct AuthView: View {
    @State private var unlocked = false
    var body: some View {
        VStack  {
            if unlocked {
                Text("Unlocked")
            }
            else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics, error: &error
        ) {
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "We need to unlock your data") { success, authenticationError in
                    if success {
                        unlocked = true
                    } else {}
                }
        }  else  {}
    }
}

#Preview {
    AuthView()
}
