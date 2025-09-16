//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Fidelis Akilan on 9/15/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State var confirmationMessage = ""
    @State var showConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1486427944299-d1955d23e34d"), scale: 3)  { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder:  {
                    ProgressView()
                }
                .padding(.vertical)
                Text("Your total cost is \(order.cost, format:.currency(code: "USD"))")
                    .font(.title)
                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("API Response", isPresented: $showConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "\(decoded.quantity)x added, \(Order.types[decoded.type].lowercased())"
            showConfirmation = true
        } catch {
            print("Error with network \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    CheckoutView(order: Order())
}
