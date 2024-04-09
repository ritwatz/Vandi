//
//  loginPageSwiftUIView.swift
//  Vandi_2
//
//  Created by admin49 on 23/03/24.
//

import SwiftUI
import FirebaseAuth

struct loginView: View {
    
    @State private var email = ""
    @State private var password = ""

    @EnvironmentObject var viewModel : AuthViewModel
    
   
    var body: some View {
        NavigationView{
                VStack{
                    //Linktutor
                    VStack(alignment: .leading){
                        Text("Vandi")
                            .fontWeight(.bold)
                            .font(.system(size: 70).weight(.bold))
                            .fontDesign(.rounded)
                            .foregroundColor(.black)
                        Text("Chale Chalo")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(.mint)
                            .padding(.bottom,25)
                    }
                    .offset(y: 60)
                    
                    //login and signup option
                    HStack{
                        VStack{
                            Text("Login")
                                .font(.title2)
                            Rectangle()
                                .frame(width: 100, height: 3)
                                .foregroundColor(.mint)
                                .foregroundStyle(Color.blue)
                        }
                        Spacer()
                        VStack{
                            NavigationLink(destination: signUpView()){
                                Text("Sign up")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            Rectangle()
                                .frame(width: 100, height: 3)
                                .foregroundStyle(Color.clear)
                        }
                    }
                    .padding(.horizontal, 50)
                    .offset(y: 130)
                    
                    //login details
                    List{
                        VStack(alignment: .leading){
                            Text("Email address")
                                .font(.title2)
                                .padding(.leading, 10)
                            TextField("Email addresss", text: $email)
                                .listRowBackground(Color.black)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .textFieldStyle(.plain)
                                .cornerRadius(8)
                                .padding(10)
                        }
                        .listRowBackground(Color.clear)
                        VStack(alignment: .leading){
                            Text("Password")
                                .font(.title2)
                                .padding(.leading, 10)
                            SecureField("Password", text: $password)
                                .cornerRadius(8)
                                .padding(10)
                        }
                        .padding(.top)
                        .listRowBackground(Color.clear)
                    }
                    .padding(.top, 20)
                    .offset(y: 150)
                    .listStyle(PlainListStyle())
                    
                    //button
                    Button {
                        Task {
                           try await viewModel.signIn(withEmail: email, password: password)
                        }
                        
                    } label :{
                        
                        Text("Login")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .frame(width: 250, height: 35)
                    .padding()
                    .disabled(!FormIsValid)
                    .opacity(FormIsValid ? 1.0 : 0.5)
                    .background(Color.mint)
                    .cornerRadius(50)
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .environment(\.colorScheme, .dark)
                .foregroundColor(.black)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    loginView()
}

extension loginView: AuthenticationFormProtocol {
    var FormIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
    

