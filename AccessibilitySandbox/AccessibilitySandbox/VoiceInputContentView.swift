//
//  VoiceInputContentView.swift
//  AccessibilitySandbox
//
//  Created by Fidelis Akilan on 4/3/26.
//

import SwiftUI

struct VoiceInputContentView: View {
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button Tapped")
        }
        .accessibilityInputLabels(["JFK", "Kennedy", "John Fitzgerald Kennedy"])
    }
}

#Preview {
    VoiceInputContentView()
}
