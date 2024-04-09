//
//  Payment.swift
//  Vandi_2
//
//  Created by user2 on 27/02/24.
//

import SwiftUI

struct PaymentScreen: View {
    @State private var selectedDeliveryOption: String?
    @State private var selectedPaymentOption: String?
    @State private var selectedCarName: String?

    var deliveryOptions = ["Delivery", "Take Away"]
    var paymentOptions = ["UPI", "Net Banking", "Cash"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
    //                Text("Book Vehicle")
    //                    .font(.title)
    //                    .fontWeight(.semibold)
    //                    .foregroundColor(Color.black)
    //                    .padding(.top, 5)
    //                    .offset(x: -110)
    //                    .padding()

                    // Current Location
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(Color.mint)
                                .font(.title)
                            Text("Current Location")
                                .font(.footnote)
                                .fontWeight(.bold)
                        }

                        Text("123 Main Street, City")
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                    }.offset(x: -100)

                    // Car Location
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(Color.mint)
                                .font(.title)
                            Text("Car Location")
                                .font(.footnote)
                                .fontWeight(.bold)
                        }

                        Text("Potheri Car Rentals, Chennai")
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                    }
                    .offset(x: -100)
                    .padding()

                    // Selected Car Card
                    VStack(alignment: .leading) {
                        if let selectedCarName = selectedCarName {
                            Text("Selected Car")
                                .font(.title2)
                                .padding(.bottom, 4)
                                .offset(x: -85)
                                .padding(.top)

                            // Display selected car photo and name
                            Image(selectedCarName) // Replace with actual image name
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 150) // Adjusted dimensions

                            Text(selectedCarName)
                                .font(.headline)
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                    }

                    // Select Vehicle Delivery Mode Subheading
                    Text("Select Delivery Option")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                        .offset(x: -85)
                        .padding(.top)

                    // Delivery Options Card
                    HStack {
                        HStack {
                            Button(action: {
                                selectedDeliveryOption = "Delivery"
                            }) {
                                Text("Delivery")
                                    .padding()
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(selectedDeliveryOption == "Delivery" ? Color.themeColor() : Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(selectedDeliveryOption == "Delivery" ? .white : .black)
                            }
                            .buttonStyle(PlainButtonStyle())

                            Button(action: {
                                selectedDeliveryOption = "Take Away"
                            }) {
                                Text("Take Away")
                                    .padding()
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .background(selectedDeliveryOption == "Take Away" ? Color.themeColor() : Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(selectedDeliveryOption == "Take Away" ? .white : .black)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .padding()
                        .background(Color(.mint.opacity(0.2)))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.mint, lineWidth: 1))
                    }
                    .padding()

                    // Select Payment Mode Subheading
                    Text("Select Payment Mode")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                        .offset(x: -85)
                        .padding(.top)

                    // Payment Options Card
                    VStack {
                        ForEach(paymentOptions, id: \.self) { option in
                            Button(action: {
                                selectedPaymentOption = option
                            }) {
                                Text(option)
                                    .padding()
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .background(selectedPaymentOption == option ? Color.themeColor() : Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(selectedPaymentOption == option ? .white : .black)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .padding()
                    .background(Color(.mint.opacity(0.2)))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.mint, lineWidth: 1))

                    // Confirm Booking Button
                    NavigationLink(destination: PaymentEnd().navigationBarBackButtonHidden()){
                        Text("Confirm Booking")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .background((selectedDeliveryOption != nil && selectedPaymentOption != nil) ? Color.themeColor() : Color.gray)
                            .cornerRadius(10)
                            .frame(width: UIScreen.main.bounds.width - 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(16)
                    .disabled(selectedDeliveryOption == nil || selectedPaymentOption == nil)
                }
                .navigationTitle("Confirm Payment")
                .background(Color(.systemBackground))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen()
    }
}

extension Color {
    static func themeColor() -> Color {
        return Color(.systemMint)
    }
}
