//
//  vehicleDetail.swift
//  Vandi_2
//
//  Created by admin49 on 29/03/24.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct VehicleData: Identifiable, Equatable {
    let id: String
    let vendorId: String
    let vehicleType: String
    let vehicleName: String
    let vehicleNumber: String
    let vehicleModel: String
    let price: Int
    let gasType: String
    let description: String
    var bookingConfirmed: Int
    var imageURL: String
}

class VehicleDataViewModel: ObservableObject {
    @Published var vehicleData: [VehicleData] = []
    
    static let shared = VehicleDataViewModel()
    
    func fetchVehicleDetails() {
        let db = Firestore.firestore()
        
        db.collection("vehicle").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                var detail: [VehicleData] = []
                for document in snapshot!.documents {
                    let vData = document.data()
                    let id = document.documentID
                    let vendorId = vData["vendorId"] as? String ?? ""
                    let vehicleType = vData["vehicleType"] as? String ?? ""
                    let vehicleName = vData["vehicleName"] as? String ?? ""
                    let vehicleNumber = vData["vehicleNumber"] as? String ?? ""
                    let vehicleModel = vData["vehicleModel"] as? String ?? ""
                    let price = vData["price"] as? Int ?? 0
                    let gasType = vData["gasType"] as? String ?? ""
                    let description = vData["description"] as? String ?? ""
                    let bookingConfirmed = vData["bookingConfirmed"] as? Int ?? 0
                    let imageURL = vData["imageURL"] as? String ?? ""
                    
                    let vehicleDetail = VehicleData(id: id,
                                                     vendorId: vendorId,
                                                     vehicleType: vehicleType,
                                                     vehicleName: vehicleName,
                                                     vehicleNumber: vehicleNumber,
                                                     vehicleModel: vehicleModel,
                                                     price: price,
                                                     gasType: gasType,
                                                     description: description,
                                                     bookingConfirmed: bookingConfirmed,
                                                     imageURL: imageURL)
                    
                    detail.append(vehicleDetail)
                }
                self.vehicleData = detail
            }
        }
    }
    
    func fetchVehicleDetailsByID(vehicleID: String) async {
        do {
            let db = Firestore.firestore()
            let document = try await db.collection("vehicle").document(vehicleID).getDocument()
            
            if document.exists {
                if let vData = document.data() {
                    let data = VehicleData(
                        id: vehicleID,
                        vendorId: vData["vendorId"] as? String ?? "",
                        vehicleType: vData["vehicleType"] as? String ?? "",
                        vehicleName: vData["vehicleName"] as? String ?? "",
                        vehicleNumber: vData["vehicleNumber"] as? String ?? "",
                        vehicleModel: vData["vehicleModel"] as? String ?? "",
                        price: vData["price"] as? Int ?? 0,
                        gasType: vData["gasType"] as? String ?? "",
                        description: vData["description"] as? String ?? "",
                        bookingConfirmed: vData["bookingConfirmed"] as? Int ?? 0,
                        imageURL: vData["imageURL"] as? String ?? ""
                    )
                    DispatchQueue.main.async {
                        self.vehicleData = [data]
                    }
                }
            } else {
                print("Vehicle document does not exist")
            }
        } catch {
            print("Error fetching vehicle details: \(error.localizedDescription)")
        }
    } // fetchDetailByID
    
    func updateVehicleDetails(vehicleID: String, newData: [String: Any]) {
          let db = Firestore.firestore()
          
          db.collection("vehicle").document(vehicleID).updateData(newData) { error in
              if let error = error {
                  print("Error updating vehicle details: \(error.localizedDescription)")
              } else {
                  print("Vehicle details updated successfully.")
              }
          }
      }
      
      func deleteVehicle(vehicleID: String) {
          let db = Firestore.firestore()
          
          db.collection("vehicle").document(vehicleID).delete { error in
              if let error = error {
                  print("Error deleting vehicle: \(error.localizedDescription)")
              } else {
                  print("Vehicle deleted successfully.")
              }
          }
      }
    
    
    func addVehicleData(vehicleData: VehicleData) {
           let db = Firestore.firestore()
           
           // Add a new document with a generated ID
           db.collection("vehicle").addDocument(data: [
               "vendorId": vehicleData.vendorId,
               "vehicleType": vehicleData.vehicleType,
               "vehicleName": vehicleData.vehicleName,
               "vehicleNumber": vehicleData.vehicleNumber,
               "vehicleModel": vehicleData.vehicleModel,
               "price": vehicleData.price,
               "gasType": vehicleData.gasType,
               "description": vehicleData.description,
               "bookingConfirmed": vehicleData.bookingConfirmed
           ]) { err in
               if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Document added with ID: ")
               }
           }
       }
}

struct VehicleDetail: View {
    @ObservedObject var vehicleViewModel = VehicleDataViewModel()
    
    var body: some View {
        VStack {
            ForEach(vehicleViewModel.vehicleData) { detail in
                VStack(alignment: .leading) {
                    NavigationLink(destination: VehicleCard(carName: detail.vehicleName, model: detail.vehicleModel)) {
                        Text("Vehicle Name: \(detail.vehicleName)")
                    }
                }
                .padding()
            }
        }
        .onAppear() {
            vehicleViewModel.fetchVehicleDetails()
        }
    }
}

struct VehicleCard: View {
    let carName: String
    let model: String
    
    var body: some View {
        Text("Car Name: \(carName), Model: \(model)")
    }
}

struct VehicleDetail_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetail()
    }
}





//var body: some View {
//      VStack {
//          Text("Current Price: \(vehicleViewModel.vehicleData.first?.price ?? 0)")
//          TextField("New Price", value: $newPrice, formatter: NumberFormatter())
//          Text("Current Description: \(vehicleViewModel.vehicleData.first?.description ?? "")")
//          TextField("New Description", text: $newDescription)
//          Button("Update Details") {
//              if let vehicleID = vehicleViewModel.vehicleData.first?.id {
//                  let newData: [String: Any] = [
//                      "price": newPrice,
//                      "description": newDescription
//                  ]
//                  vehicleViewModel.updateVehicleDetails(vehicleID: vehicleID, newData: newData)
//              }
//          }
//      }
//      .onAppear() {
//          vehicleViewModel.fetchVehicleDetails()
//      }
//  }
