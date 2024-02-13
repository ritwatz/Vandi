////
////  SelectTransport.swift
////  Vandi_2
////
////  Created by user2 on 30/01/24.
////
//
//import SwiftUI
//
////struct SelectTransportScreen: View {
////  @State private var selectedDate: Date = Date()
////  @State private var selectedVehicleType: String = "Car"
////  @State private var numberOfPassengers: String = ""
////
////  var body: some View {
////    VStack {
////      // Top bar with back button and title
////      HStack {
////        Button(action: {}) {
////          Image(systemName: "chevron.left")
////            .foregroundColor(.black)
////        }
////        Text("Select transport")
////          .font(.title)
////          .fontWeight(.bold)
////          .foregroundColor(.black)
////        Spacer()
////      }
////
////      // Date picker for selecting travel time period
////      DatePicker(
////        "Select your Time Period",
////        selection: $selectedDate,
////        displayedComponents: [.date]
////      )
////        .padding(.horizontal)
////
////      // Picker for selecting vehicle type
////      Picker("Select Vehicle Type", selection: $selectedVehicleType) {
////        Text("Car").tag("Car")
////        Text("Bike").tag("Bike")
////        Text("Scooter").tag("Scooter")
////      }
////      .padding(.horizontal)
////
////      // Text field for entering number of passengers
////      TextField("Number of Passengers", text: $numberOfPassengers)
////        .keyboardType(.numberPad)
////        .padding(.horizontal)
////
////      // Go button to proceed with booking
////      Button(action: {}) {
////        Text("Go")
////          .foregroundColor(.white)
////          .padding()
////          .background(Color.blue)
////          .cornerRadius(10)
////      }
////      .padding(.horizontal)
////
////      Spacer()
////    }
////    .padding(.top)
////    .navigationTitle("Book")
////  }
////}
////struct SelectTransport_Previews: PreviewProvider {
////    static var previews: some View {
////        SelectTransportScreen()
////    }
////}
//
//// ContentView.swift
//
//import SwiftUI
//
//struct ContentView: View {
//  @State private var fromDate: Date = Date() // Starting from current time
//  @State private var toDate: Date = Date().addingTimeInterval(3600) // To date starts 1 hour after from date
//  @State private var selectedVehicleType: String = "Car" // Default vehicle type is car
//  @State private var numberOfPassengers: Int = 2 // Minimum passengers is 2
//
//  var body: some View {
//    VStack(spacing: 20) {
//      // Top bar with back button and title
//      HStack {
//        Button(action: {}) {
//          Image(systemName: "chevron.left")
//            .foregroundColor(.black)
//        }
//        Text("Select transport")
//          .font(.title)
//          .fontWeight(.bold)
//          .foregroundColor(.black)
//        Spacer()
//      }
//
//      // Select your time period with date pickers
//      HStack {
//        Text("From")
//          .font(.body)
//          .foregroundColor(.gray)
//        DatePicker("", selection: $fromDate, displayedComponents: [.date])
//          .frame(width: 150)
//        Text("To")
//          .font(.body)
//          .foregroundColor(.gray)
//        DatePicker("", selection: $toDate, displayedComponents: [.date])
//          .frame(width: 150)
//      }
//
//      // Select vehicle type with radio buttons
//      HStack(spacing: 20) {
//        RadioButton(text: "Car", isSelected: $selectedVehicleType, isRadioSelected: "Car")
//        RadioButton(text: "Bike", isSelected: $selectedVehicleType, isRadioSelected: "Bike")
//        RadioButton(text: "Scooter", isSelected: $selectedVehicleType, isRadioSelected: "Scooter")
//      }
//
//      // Number of passengers with stepper
//      HStack {
//        Text("Number of passengers:")
//          .font(.body)
//          .foregroundColor(.gray)
//        Spacer()
//        Stepper("", value: $numberOfPassengers, in: 2...7)
//      }
//
//      // Go button to save data in a struct
//      Button(action: {
//        // Save data to your struct here
//        print("Selected transport details:")
//        print("From date:", fromDate)
//        print("To date:", toDate)
//        print("Vehicle type:", selectedVehicleType)
//        print("Number of passengers:", numberOfPassengers)
//      }) {
//        Text("Go")
//          .foregroundColor(.white)
//          .padding()
//          .background(Color.blue)
//          .cornerRadius(10)
//      }
//    }
//    .padding(.horizontal)
//    .navigationTitle("Book")
//  }
//}
//
//struct RadioButton: View {
//  let text: String
//  @Binding var isSelected: String
//  let isRadioSelected: String
//
//  var body: some View {
//    Button(action: {
//      isSelected = isRadioSelected
//    }) {
//      HStack {
//        Image(systemName: isSelected == isRadioSelected ? "circle.fill" : "circle")
//          .foregroundColor(isSelected == isRadioSelected ? .blue : .gray)
//        Text(text)
//          .foregroundColor(.black)
//      }
//    }
//  }
//}
//
//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}
//
