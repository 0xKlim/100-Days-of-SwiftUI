//
//  CheckoutView.swift
//  10_CupcakeCorner
//
//  Created by Vladislav on 08.10.2026.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let imageURL = URL(string: "https://hws.dev/img/cupcakes@3x.jpg")
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: imageURL, scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        let orderRequest = OrderRequest(from: order)
        
        guard let encoded = try? JSONEncoder().encode(orderRequest) else {
            showAlert(title: "Error!", message: "Order couldn't be prepared for sending.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("YOUR-API-KEY", forHTTPHeaderField: "x-api-key")               // <-- ENTER YOUR API KEY
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(OrderRequest.self, from: data)
            
            let message = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showAlert(title: "Thank you!", message: message)
        } catch {
            showAlert(title: "Something went wrong", message: "Checkout failed: \(error.localizedDescription)")
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
}

#Preview {
    CheckoutView(order: Order())
}
