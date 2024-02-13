// CarBookingView.swift

import SwiftUI

struct CarBookingView: View {
    @Binding var selectedDate: Date
    @Binding var numberOfPassengers: Int
    @Binding var isShowingDatePicker: Bool
    
    var selectedVehicle: VehicleType

    var body: some View {
        NavigationView {
            VStack {
                // Navigation bar with back button
                HStack {
                    NavigationLink(destination: SelectTransportView()) {
                        Image(systemName: "arrow.left")
                            .padding()
                    }
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

                // Date picker for "from date"
                HStack {
                    Text("From date")
                        .padding(.leading)
                    Spacer()
                    Text("\(selectedDate, formatter: dateFormatter)")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            isShowingDatePicker = true
                        }
                        .padding(.trailing)
                        .sheet(isPresented: $isShowingDatePicker) {
                            DatePicker("Select a date and time", selection: $selectedDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                        }
                }

                // Date picker for "to date"
                HStack {
                    Text("To date")
                        .padding(.leading)
                    Spacer()
                    Text("\(selectedDate, formatter: dateFormatter)")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            isShowingDatePicker = true
                        }
                        .padding(.trailing)
                        .sheet(isPresented: $isShowingDatePicker) {
                            DatePicker("Select a date and time", selection: $selectedDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
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
                    Stepper(value: $numberOfPassengers, in: 2...8) {
                        Text("\(numberOfPassengers)")
                    }
                    .padding(.trailing)
                }
                .padding(.top)

                // Go Button
                Button(action: {
                    // Add your action when the "Go" button is tapped
                }) {
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
    static var previews: some View {
        CarBookingView(selectedDate: .constant(Date()), numberOfPassengers: .constant(2), isShowingDatePicker: .constant(false), selectedVehicle: VehicleType(name: "Car", emoji: "🚗"))
    }
}
