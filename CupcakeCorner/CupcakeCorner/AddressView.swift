//
//  AddresView.swift
//  CupcakeCorner
//
//  Created by Fidelis Akilan on 9/12/25.
//

import SwiftUI

struct AddresView: View {
    @Bindable var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
                .disabled(order.hasInvalidAddress)
            }
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddresView(order: Order())
}
