//
//  myProfileView.swift
//  Vandi_2
//
//  Created by admin49 on 23/03/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct myProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @ObservedObject var userViewModel = UserViewModel.shared
    @State var showEditView = false
    
    @State var isClicked : Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    Text("My Profile")
                        .font(.title2)
                    Spacer()
                }
                HStack{
                    if let imageUrl = userViewModel.userDetails.first?.imageUrl {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .clipped()
                                .frame(width: 85, height: 85)
                                .cornerRadius(50)
                                .padding(.trailing, 5)
                        } placeholder: {
                            Image(systemName: "person.crop.square")
                                .resizable()
                                .clipped()
                                .frame(width: 85, height: 85)
                                .cornerRadius(50)
                                .padding(.trailing, 5)
                        }
                        .frame(width: 90, height: 90)
                    } else {
                        Image(systemName: "person.crop.square")
                            .resizable()
                            .clipped()
                            .frame(width: 85, height: 85)
                            .cornerRadius(50)
                            .padding(.trailing, 5)
                    }
                    
                    if let user = viewModel.currentUser {
                        VStack(alignment: .leading){
                            Text(user.fullName)
                                .font(.title2)
                                .foregroundStyle(Color.black)
                            Text(user.email)
                                .font(.title2)
                                .foregroundStyle(Color.black)
                        }
                        .padding(.trailing)
                    }
                    Spacer()
                    VStack{
                        NavigationLink(destination: ProfileInputView() , isActive: $isClicked){
                            Button(action: {
                                showEditView.toggle()
                                isClicked = true
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        
                        Spacer()
                    }
                }
                .padding()
                .frame(width: 350, height: 120)
                .background(Color.white)
                .cornerRadius(20)
                
                
                List{
                    HStack{
                        Text("Change password")
                        Spacer()
                        NavigationLink(destination : newPassword()){
                            
                        }
                        
                        
                        
                    }
                    .listRowBackground(Color.clear)
                    HStack{
                        Text("Delete my account")
                        Spacer()
                        Button{
                            viewModel.deleteAccount()
                        } label: {
                            
                            Image(systemName: "arrow.right")
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                }
                .listStyle(PlainListStyle())
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: 200,  alignment: .center)
                
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Logout")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .frame(width: 200, height: 35)
                            .padding()
                            .background(Color.mint)
                            .cornerRadius(50)
                    }
                    
                    Spacer()
                }
                //.frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
        }
        
    }
}
    


#Preview {
    let viewModel = AuthViewModel()
          viewModel.currentUser = User(id: "mockUserID", fullName: "John Doe", email: "john@example.com")
          
          return myProfileView()
              .environmentObject(viewModel)
}
