//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Konrad Cureau on 13/05/2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    @State private var titleMessage = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)

                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(
                title: Text(titleMessage),
                message: Text(confirmationMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.titleMessage = "Sorry"
                self.confirmationMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
                self.showingConfirmation = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.titleMessage = "Thank You !"
                self.confirmationMessage =  "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }
        .resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
