//
//  TransportBooking.swift
//  Vandi_2
//
//  Created by user2 on 26/02/24.
//

import SwiftUI

struct CarBookingView: View {
        @Binding var selectedFromDate: Date
        @Binding var selectedToDate: Date
        @Binding var numberOfPassengers: Int
        @Binding var isShowingDatePicker: Bool
    
    var selectedVehicle: VehicleType

    var body: some View {
        NavigationView {
            VStack {
                // Navigation bar with back button
                HStack {
//                    NavigationLink(destination: SelectTransportView()) {
//                        Image(systemName: "arrow.left")
//                            .padding()
//                    }
                    Spacer()
                    Text("Select Transport")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()

                // Subheading
                Text("Select the time period")
                    .font(.headline)
                    .padding()

                HStack {
                                    Text("From date")
                                        .padding(.leading)
                                    Spacer()
                                    Text("\(selectedFromDate, formatter: dateFormatter)")
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            withAnimation {
                                                isShowingDatePicker.toggle()
                                            }
                                        }
                                        .padding(.trailing)
                                        .sheet(isPresented: $isShowingDatePicker) {
                                            DatePicker("Select a date and time", selection: $selectedFromDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                                                .datePickerStyle(.wheel)
                                                .labelsHidden()
                                        }
                                }

                                // Date picker for "to date"
                                HStack {
                                    Text("To date")
                                        .padding(.leading)
                                    Spacer()
                                    Text("\(selectedToDate, formatter: dateFormatter)")
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            withAnimation {
                                                isShowingDatePicker.toggle()
                                            }
                                        }
                                        .padding(.trailing)
                                        .sheet(isPresented: $isShowingDatePicker) {
                                            DatePicker("Select a date and time", selection: $selectedToDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                                                .datePickerStyle(.wheel)
                                                .labelsHidden()
                                        }
                                }

                // Selected Vehicle Type
                Text("Vehicle type")
                    .font(.headline)
                    .padding(.top)
                CardView(vehicleType: selectedVehicle)
                    .frame(width: 100, height: 150) // Adjust the size as needed

                // Number of passengers
                HStack {
                    Text("Number of passengers")
                        .padding(.leading)
                    Spacer()
                    Stepper(value: Binding(
                        get: { numberOfPassengers },
                        set: { newValue in
                            numberOfPassengers = newValue
                        }
                    ), in: 2...8) {
                        Text("\(numberOfPassengers)")
                    }
                    .padding(.trailing)
                }
                .padding(.top)


                // Go Button
                NavigationLink(destination: CarList()) {
                    Text("Go")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.678, green: 0.847, blue: 0.902)) // Teal background
                        .cornerRadius(15)
                }
                .padding(.top)

                Spacer()
            }
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

struct CarBookingView_Previews: PreviewProvider {
    @State static var passengers: Int = 2 // Set an initial value as needed

    static var previews: some View {
        CarBookingView(
            selectedFromDate: .constant(Date()),
            selectedToDate: .constant(Date()),
            numberOfPassengers: $passengers,
            isShowingDatePicker: .constant(false), // Change this to your desired initial value
            selectedVehicle: VehicleType(name: "Car", emoji: "🚗")
        )
    }
}
