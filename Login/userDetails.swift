import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

struct UserData: Identifiable, Codable, Equatable {
    var id: String
    var aboutParagraph: String
    var city: String
    var email: String
    var documentUid: String
    var fullName: String
// Assuming location is of type GeoPoint
    var occupation: String
    var phoneNumber: Int
    var imageUrl: String
}

class UserViewModel: ObservableObject {
    @Published var userDetails = [UserData]()
    private let db = Firestore.firestore()
    static let shared = UserViewModel()
    
    func fetchUserDetails() async {
        do {
            let snapshot = try await db.collection("users").getDocuments()
            
            DispatchQueue.main.async {
                var details: [UserData] = []
                for document in snapshot.documents {
                    let data = document.data()
                    let id = document.documentID
                    let aboutParagraph = data["aboutParagraph"] as? String ?? ""
                    let city = data["city"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let documentUid = data["id"] as? String ?? ""
                    let fullName = data["fullName"] as? String ?? ""
              
                    let occupation = data["occupation"] as? String ?? ""
                    let phoneNumber = data["phoneNumber"] as? Int ?? 0
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    
                    let userDetail = UserData(id: id,
                                              aboutParagraph: aboutParagraph,
                                              city: city,
                                              email: email,
                                              documentUid: documentUid,
                                              fullName: fullName,
                                         
                                              occupation: occupation,
                                              phoneNumber: phoneNumber,
                                              imageUrl: imageUrl)
                    details.append(userDetail)
                }
                self.userDetails = details
            }
        } catch {
            print("Error fetching teacher details: \(error.localizedDescription)")
        }
    }
    
    func fetchUserDetailsByID(userID: String) async {
        do {
            let document = try await db.collection("users").document(userID).getDocument()
            
            // Check if the document exists
            if document.exists {
                if let data = document.data() {
                    let userDetail = UserData(
                        id: document.documentID,
                        aboutParagraph: data["aboutParagraph"] as? String ?? "",
                        city: data["city"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        documentUid: data["id"] as? String ?? "",
                        fullName: data["fullName"] as? String ?? "",
                       
                        occupation: data["occupation"] as? String ?? "",
                        phoneNumber: data["phoneNumber"] as? Int ?? 0,
                        imageUrl: data["imageUrl"] as? String ?? ""
                    )
                    
                    DispatchQueue.main.async {
                        self.userDetails = [userDetail]
                    }
                }
            } else {
                print("Student document does not exist")
            }
        } catch {
            print("Error fetching student details: \(error.localizedDescription)")
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

struct UserDetails: View {
    @ObservedObject var userViewModel = UserViewModel.shared

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(userViewModel.userDetails) { userDetail in
                    VStack(alignment: .leading) {
                        Text("ID: \(userDetail.id)")
                        Text("Full Name: \(userDetail.fullName)")
                        Text("Email: \(userDetail.email)")
                        Text("City: \(userDetail.city)")
                        Text("About: \(userDetail.aboutParagraph)")
                        Text("Occupation: \(userDetail.occupation)")
                        Text("Phone Number: \(userDetail.phoneNumber)")
                    
                        Text("Image Link: \(userDetail.imageUrl)")
                        
                        // Async image loading
                        AsyncImage(url: URL(string: userDetail.imageUrl)) { image in
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
            .navigationBarTitle("Student Details")
            .onAppear {
                Task {
                    await userViewModel.fetchUserDetails()
                }
            }
        }
    }
}

#Preview {
    UserDetails()
}
