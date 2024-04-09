//
//  addVehicleView.swift
//  Vandi_2
//
//  Created by admin49 on 03/04/24.
//
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: PhotoPicker

        init(parent: PhotoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
    }
}

struct AddVehicleView: View {
    @State private var carName = ""
    @State private var rating = 0.0
    @State private var brand = ""
    @State private var pricePerDay = 0
    @State private var description = ""
    @State private var mainImage: UIImage? = nil // Track the selected image
    @State private var mainImageName = ""
    @State private var imagesNames = [String]()
    @State private var insurance = ""
    @State private var maxDistance: Float?
    @State private var numberOfSeats = 0
    @State private var numberOfDoors = 0
    @State private var gasType = ""
    @State private var hostName = ""
    @State private var hostImageName = ""
    @State private var hostJoinDate = ""
    @State private var isFavorite = false
    @State private var pricePerHour = 0
    @State private var reviewsCount = 0
    @State private var airCondition = false
    @State private var colour = ""
    @State private var milage = 0.0
    @State private var lastServiceDate = Date()
    @State private var vendorId = 0
    @State private var maxSpeed = 0.0
    @State private var horsePower = 0.0
    @State private var distanceAway = 0.0
    @State private var govRegistrationNumber = ""
    @State private var modelName = ""
    @State private var modelYear = ""
    @State private var city = ""
    @State private var vehicleType = ""
    @State private var transmissionType = ""
    @State private var showImagePicker = false
    @State private var additionalImages: [UIImage?] = [nil, nil, nil]
    @State private var additionalImageNames: [String] = ["", "", ""]
    @State private var showAdditionalImagePickers = [false, false, false]
    @State private var insuranceExpiryOn = Date()
    @State private var carInsuranceImage: UIImage? = nil
    @State private var carRegistrationImage: UIImage? = nil
    @State private var showCarInsuranceImagePicker = false
    @State private var showCarRegistrationImagePicker = false
//    @State private var vehicleStore = VehicleStore(vehicles: [
//        VehicleCar(id: "1", carName: "Toyota Camry", rating: 4.5, brand: "Toyota", pricePerDay: 50, description: "Comfortable sedan", mainImageName: "camry", imagesNames: [], insurance: "Yes", maxDistance: nil, numberOfSeats: 5, numberOfDoors: 4, GasType: "Petrol", hostName: "John Doe", hostImageName: "host", hostJoinDate: "2023-01-01", isFavorite: true, pricePerHour: 10, reviewscount: 100, airCondition: true, colour: "Silver", milage: 50000, lastServiceDate: Date(), vendorId: 1, maxSpeed: 180, horsePower: 200, distanceAway: 10, govRegistraionNumber: "ABC123", modelName: "Camry", modelYear: "2022", city: "New York", vehicleType: "Car", transmissionType: "Automatic"),
//        VehicleCar(id: "2", carName: "Honda Civic", rating: 4.2, brand: "Honda", pricePerDay: 40, description: "Compact sedan", mainImageName: "civic", imagesNames: [], insurance: "Yes", maxDistance: nil, numberOfSeats: 5, numberOfDoors: 4, GasType: "Petrol", hostName: "Jane Doe", hostImageName: "host", hostJoinDate: "2023-01-01", isFavorite: true, pricePerHour: 8, reviewscount: 80, airCondition: true, colour: "Black", milage: 40000, lastServiceDate: Date(), vendorId: 2, maxSpeed: 170, horsePower: 180, distanceAway: 15, govRegistraionNumber: "XYZ456", modelName: "Civic", modelYear: "2021", city: "Los Angeles", vehicleType: "Car", transmissionType: "Automatic")
//    ])
 // Initialize the vehicle store

    
    
    // Function to save vehicle data
    func saveVehicle() {
        _ = VehicleCar(
                id: UUID().uuidString,
                carName: carName,
                rating: rating,
                brand: brand,
                pricePerDay: pricePerDay,
                description: description,
                mainImageName: mainImageName,
                imagesNames: imagesNames,
                insurance: insurance,
                maxDistance: maxDistance,
                numberOfSeats: numberOfSeats,
                numberOfDoors: numberOfDoors,
                GasType: gasType,
                hostName: hostName,
                hostImageName: hostImageName,
                hostJoinDate: hostJoinDate,
                isFavorite: isFavorite,
                pricePerHour: pricePerHour,
                reviewscount: reviewsCount,
                airCondition: airCondition,
                colour: colour,
                milage: milage,
                lastServiceDate: lastServiceDate,
                vendorId: vendorId,
                maxSpeed: maxSpeed,
                horsePower: horsePower,
                distanceAway: distanceAway,
                govRegistraionNumber: govRegistrationNumber,
                modelName: modelName,
                modelYear: modelYear,
                city: city,
                vehicleType: vehicleType,
                transmissionType: transmissionType
            )
            
            // Append the vehicle to the vehicle store
            //vehicleStore.addVehicle(vehicle)
            
            // For demonstration, let's just print the vehicle store
            //print(vehicleStore)
        }
    
    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Car Name", text: $carName)
                    TextField("Brand", text: $brand)
                    TextField("Description", text: $description)
                    //                TextField("Main Image Name", text: $mainImageName)
                    
                    TextField("Gas Type", text: $gasType)
                    //                Toggle("Insurance", isOn: $hasInsurance)
                    //                TextField("Host Name", text: $hostName)
                    //                TextField("Host Image Name", text: $hostImageName)
                    //                TextField("Host Join Date", text: $hostJoinDate)
                    //                Toggle("Is Favorite", isOn: $isFavorite)
                }
                
                Section(header: Text("Details")) {
                    
                    HStack {
                        Stepper("Number of Seats", value: $numberOfSeats, in :1...7)
                        Text("\(numberOfSeats)").padding(.horizontal)
                    }
                    
                    HStack {
                        Stepper("Number of Doors", value: $numberOfDoors, in :1...7)
                        Text("\(numberOfDoors)").padding(.horizontal)
                    }
                    
                    //                        HStack {
                    //                            Text("Reviews Count")
                    //                            TextField("Enter reviews count", value: $reviewsCount, formatter: NumberFormatter())
                    //                                .keyboardType(.numberPad)
                    //                                .offset(x: 167)
                    //                        }
                    
                    HStack {
                        Text("Milage")
                        TextField("Enter milage", value: $milage, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .offset(x: 213)
                            .padding(.horizontal)
                    }
                    DatePicker("Insurance Expiry Date", selection: $insuranceExpiryOn, displayedComponents: .date)
                    DatePicker("Last Service Date", selection: $lastServiceDate, displayedComponents: .date)
                    
                    //                        HStack {
                    //                            Text("Vendor ID")
                    //                            TextField("Enter vendor ID", value: $vendorId, formatter: NumberFormatter())
                    //                                .keyboardType(.numberPad)
                    //                                .offset(x: 150)
                    //                        }
                    
                    HStack {
                        Text("Max Speed")
                        TextField("Enter max speed", value: $maxSpeed, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .offset(x: 150)
                    }
                    
                    HStack {
                        Text("Horse Power")
                        TextField("Enter horse power", value: $horsePower, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .offset(x: 150)
                    }
                    
                    //                        HStack {
                    //                            Text("Distance Away")
                    //                            TextField("Enter distance away", value: $distanceAway, formatter: NumberFormatter())
                    //                                .keyboardType(.decimalPad)
                    //                                .offset(x: 150)
                    //                        }
                    
                }
                
                Section(header: Text("Other Info")) {
                    TextField("Colour", text: $colour)
                    TextField("Government Registration Number", text: $govRegistrationNumber)
                    TextField("Model Name", text: $modelName)
                    TextField("Model Year", text: $modelYear)
                    TextField("City", text: $city)
                    HStack {
                        Text("Vehicle Type")
                        Spacer()
                        Picker("", selection: $vehicleType) {
                            Text("Car").tag("Car")
                            Text("Bike").tag("Bike")
                            Text("Scooty").tag("Scooty")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.trailing, 20) // Adjust padding as needed
                    }
                    HStack {
                        Text("Transmission Type")
                        Spacer()
                        Picker("", selection: $vehicleType) {
                            Text("Manual").tag("Manual")
                            Text("Automatic").tag("Automatic")
                            Text("Semi-Automatic").tag("Semi-Automatic")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.trailing, 20) // Adjust padding as needed
                    }
                    TextField("Transmission Type", text: $transmissionType)
                }
                
                
                // Add more sections for additional details as needed
                Section(header: Text("Select Main Image")) {
                    if let image = mainImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    } else {
                        Text("No image selected")
                    }
                    
                    Button("Select Image") {
                        // Present image picker when button is tapped
                        showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker) {
                        PhotoPicker(image: $mainImage)
                    }
                    
                    TextField("Main Image Name", text: $mainImageName)
                        .disabled(true)
                }
                // Additional Image Selectors
                Section(header: Text("Select Additional Images")) {
                    
                        ForEach(0..<3, id: \.self) { index in
                            // Additional Image Preview
                            if let image = additionalImages[index] {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                            } else {
                                Text("No image selected")
                            }
                            // Button to select Additional Image
                            Button("Select Image \(index + 1)") {
                                showAdditionalImagePickers[index] = true
                            }
                            
                            .sheet(isPresented: $showAdditionalImagePickers[index]) {
                                PhotoPicker(image: $additionalImages[index])
                            }
                            
                            // Additional Image Name Field
                            TextField("Image \(index + 1) Name", text: $additionalImageNames[index])
                                .disabled(true)
                        
                    }
                }
                
                Section(header: Text("Proofs")) {
                    // Car Insurance Document Picker
                    HStack {
                        Text("Car Insurance Photo")
                        Spacer()
                        Button(action: {
                            showCarInsuranceImagePicker = true
                        }) {
                            if let image = carInsuranceImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            } else {
                                Text("Select")
                            }
                        }
                        .sheet(isPresented: $showCarInsuranceImagePicker) {
                            PhotoPicker(image: $carInsuranceImage)
                        }
                    }
                    
                    // Car Registration Document Picker
                    HStack {
                        Text("Car Registration Photo")
                        Spacer()
                        Button(action: {
                            showCarRegistrationImagePicker = true
                        }) {
                            if let image = carRegistrationImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            } else {
                                Text("Select")
                            }
                        }
                        .sheet(isPresented: $showCarRegistrationImagePicker) {
                            PhotoPicker(image: $carRegistrationImage)
                        }
                    }
                }
                
                Section(header: Text("Price")){
                    HStack{
                        Text("Price Per Hour")
                        TextField("Enter Price Per Hour", value: $pricePerHour, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .offset(x:150)
                    }
                    
                    HStack{
                        Text("Price Per Day")
                        TextField("Enter Price Per Day", value: $pricePerDay, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .offset(x:158)
                    }
                }
                
                Button(action: {
                    // Call the saveVehicle function when the button is tapped
                    saveVehicle()
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle("Add Vehicle")
            .accentColor(.mint)
                
            
        }
    }
}

struct VehicleStore {
    var vehicles: [VehicleCar] = []
    
    // Function to add a VehicleCar object to the array
    mutating func addVehicle(_ vehicle: VehicleCar) {
        vehicles.append(vehicle)
    }
}

struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView()
    }
}
