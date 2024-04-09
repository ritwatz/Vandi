//
//  ProfilePage.swift
//  Vandi_2
//
//  Created by user2 on 26/02/24.
//
import SwiftUI
struct ProfilePage: View {
    @State private var email: String = ""
    @State private var contactNumber: String = ""
    @State private var gender: String = ""
    @State private var address: String = ""
    @State private var drivingLicense: String = ""
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Profile")
                        .font(.largeTitle)
                        .padding(.top, 20)

                    Image("defaultProfileImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)

                    Text("Name Placeholder")
                        .font(.headline)
                        .padding(.top, 10)

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 10)

                    TextField("Contact Number", text: $contactNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 10)

                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("male")
                        Text("Female").tag("female")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 10)
                    
                    TextField("Address", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 10)
                    
                    TextField("Driving License Number", text: $drivingLicense)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 10)

                    // Add the rest of the text fields similarly...

                    Button(action: {
                        // Implement action for Confirm Button
                        // You can call a function to save the entered details in a struct file
                    }) {
                        Text("Confirm")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Spacer()
                }
                .padding()
            .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}


struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
