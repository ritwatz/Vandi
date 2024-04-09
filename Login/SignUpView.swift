//
//  SignUpView.swift
//  Vandi_2
//
//  Created by admin49 on 23/03/24.
//
import SwiftUI
import FirebaseAuth

struct signUpView: View {
   
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var confirmPassword = ""
   
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationStack{
            
                VStack{
                    //Linktutor
                    VStack(alignment: .leading){
                        Text("Vandi")
                            .fontWeight(.bold)
                            .font(.system(size: 50).weight(.bold))
                            .fontDesign(.rounded)
                            .foregroundColor(.black)
                        Text("Chale Chalo")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.mint)
                            .padding(.bottom,25)
                    }
                    .offset(y: 30)
                    
                    //login and signup option
                    HStack{
                        VStack{
                            NavigationLink(destination: loginView()){
                                Text("Login")
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }
                            Rectangle()
                                .frame(width: 100, height: 3)
                                .foregroundStyle(Color.clear)
                        }
                        Spacer()
                        VStack{
                            NavigationLink(destination: signUpView()){
                                Text("Sign up")
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }
                            Rectangle()
                                .frame(width: 100, height: 3)
                                .foregroundStyle(Color.mint)
                        }
                    }
                    .padding(.horizontal, 50)
                    .offset(y: 40)
                    
                    //sign up details
                    
                    
                    List{
                        
                            VStack(alignment: .leading){
                                Text("Email address")
                                    .font(.title3)
                                TextField("Email address", text: $email)
                                    .listRowBackground(Color.black)
                                    .textFieldStyle(.plain)
                                    .cornerRadius(8)
                                    .autocapitalization(.none)
                            }
                            .listRowBackground(Color.clear)
                            
                            
                            VStack(alignment: .leading){
                                Text("Full Name")
                                    .font(.title3)
                                TextField("full name", text: $fullName)
                                    .cornerRadius(8)
                            }
                            .padding(.top)
                            .listRowBackground(Color.clear)
                            
                            VStack(alignment: .leading){
                                Text("Password")
                                    .font(.title3)
                                SecureField("Password", text: $password)
                                    .cornerRadius(8)
                            }
                            .padding(.top)
                            .listRowBackground(Color.clear)
                            
                            VStack(alignment: .leading){
                                
                                Text("Confirm Password")
                                    .font(.title3)
                                ZStack(alignment : .trailing) {
                                    SecureField("Password", text: $confirmPassword)
                                        .cornerRadius(8)
                                    
                                    if !password.isEmpty && !confirmPassword.isEmpty {
                                        if password == confirmPassword {
                                            Image(systemName: "checkmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(.systemGreen))
                                        } else {
                                            Image(systemName: "xmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(.systemRed))
                                        }
                                    }
                                }
                            }
                            .padding(.top)
                            .listRowBackground(Color.clear)
                            
                            
                        
                    }
                    .padding(.top)
                    .offset(y: 40)
                    .listStyle(PlainListStyle())
                    
                  
              Spacer()
                    
                    
                    //button
                    Button {
                        Task {
                            try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                        }
                    
                    } label : {
                        Text("Sign up")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .frame(width: 250, height: 35)
                    .padding()
                    .disabled(!FormIsValid)
                    .opacity(FormIsValid ? 1.0 : 0.5)
                    .background(Color.mint)
                    .cornerRadius(50)
                    
                   
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .environment(\.colorScheme, .dark)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    signUpView()
}



extension signUpView: AuthenticationFormProtocol {
    var FormIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && password == confirmPassword
        && !fullName.isEmpty
    }
}

