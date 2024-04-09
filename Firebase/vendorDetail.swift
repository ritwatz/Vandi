//
//  vendorDetail.swift
//  Vandi_2
//
//  Created by admin49 on 29/03/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

struct VendorData: Identifiable, Codable, Equatable {
    var id: String
    var vendorAddress: String
    var vendorPANNumber: String
    var vendorEmail: String
    var shopLicenseNo: String
    var vendorName: String
    var phoneNumber: Int
    var imageUrl : String
}

class VendorViewModel: ObservableObject {
    @Published var vendorDetails = [VendorData]()
    private let db = Firestore.firestore()
    static let shared = VendorViewModel() // Change this line

    func fetchVendorDetails() async {
        do {
            let snapshot = try await db.collection("vendor").getDocuments()
            
            DispatchQueue.main.async {
                var details: [VendorData] = []
                for document in snapshot.documents {
                    let data = document.data()
                    let id = document.documentID
                    let vendorAddress = data["address"] as? String ?? ""
                    let vendorPANNumber = data["PANnumber"] as? String ?? ""
                    let vendorEmail = data["vendorEmail"] as? String ?? ""
                    let shopLicenseNo = data["shopLicenseNo"] as? String ?? ""
                    let vendorName = data["vendorName"] as? String ?? ""
                    let phoneNumber = data["phoneNumber"] as? Int ?? 0
                    let imageURL = data["imageURL"] as? String ?? ""
                    
                    let vendorDetail = VendorData(id: id,
                                                  vendorAddress: vendorAddress,
                                                  vendorPANNumber: vendorPANNumber,
                                                  vendorEmail: vendorEmail,
                                                  shopLicenseNo: shopLicenseNo,
                                                  vendorName: vendorName,
                                                  phoneNumber: phoneNumber,
                                                  imageUrl: imageURL
                                                  )
                    details.append(vendorDetail)
                }
                self.vendorDetails = details
            }
        } catch {
            print("Error fetching teacher details: \(error.localizedDescription)")
        }
    }
    
    func fetchVendorDetailsByID(vendorID: String) async {
        do {
            let document = try await db.collection("vendor").document(vendorID).getDocument()
            
            if document.exists {
                if let data = document.data() {
                    let vendorDetail = VendorData(
                        id: document.documentID,
                        vendorAddress : data["address"] as? String ?? "",
                        vendorPANNumber : data["PANnumber"] as? String ?? "",
                        vendorEmail : data["vendorEmail"] as? String ?? "",
                        shopLicenseNo : data["shopLicenseNo"] as? String ?? "",
                        vendorName: data["vendorName"] as? String ?? "",
                        phoneNumber: data["phoneNumber"] as? Int ?? 0,
                        imageUrl: data["imageURL"] as? String ?? ""
                    )
                    
                    DispatchQueue.main.async {
                        self.vendorDetails = [vendorDetail]
                    }
                }
            } else {
                print("Vendor details does not exist")
            }
        } catch {
            print("Error fetching vendor details: \(error.localizedDescription)")
        }
    }
    
    func loadImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "InvalidImageData", code: 0, userInfo: nil)
        }
        
        return image
    }
}

struct VendorDetails: View {
    @ObservedObject var vendorViewModel = VendorViewModel.shared

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(vendorViewModel.vendorDetails) { vendorDetail in
                    VStack(alignment: .leading) {
                        Text("ID: \(vendorDetail.id)")
                        Text("Full Name: \(vendorDetail.vendorName)")
                        Text("Email: \(vendorDetail.vendorEmail)")
                        Text("Address: \(vendorDetail.vendorAddress)")
                        Text("PAN Number: \(vendorDetail.vendorPANNumber)")
                        Text("Shop License Number: \(vendorDetail.shopLicenseNo)")
                        Text("Phone Number: \(vendorDetail.phoneNumber)")
                        
                        AsyncImage(url: URL(string: vendorDetail.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Vendor Details")
            .onAppear {
                Task {
                    await vendorViewModel.fetchVendorDetails() // Corrected this line
                }
            }
        }
    }
}

struct VendorDetails_Previews: PreviewProvider {
    static var previews: some View {
        VendorDetails()
    }
}
