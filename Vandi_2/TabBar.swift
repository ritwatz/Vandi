//
//  TabBar.swift
//  Vandi_2
//
//  Created by user2 on 26/02/24.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ExploreView(viewModel:  ExploreViewModel(), citySelectionManager: CitySelectionManager()).tag(0)
            SelectTransport().tag(1)
            Text("wallet").tag(2)
            PaymentScreen().tag(3)
            ProfilePage().tag(4)
        } .overlay(alignment: .bottom){
            VStack {
                HStack {
                    Button(action: {
                        selectedIndex = 0
                    }) {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                    .foregroundColor(selectedIndex == 0 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedIndex = 1
                    }) {
                        VStack {
                            Image(systemName: "book")
                            Text("Book")
                        }
                    }
                    .foregroundColor(selectedIndex == 1 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedIndex = 2
                    }) {
                        VStack {
                            Image(systemName: "Wallet")
                            Text("Wallet")
                        }.offset(y:5).overlay{
                            Circle().foregroundColor(.mint).frame(width:55,height:55).offset(y:-30)
                        }.overlay{
                            Image(systemName: "wallet.pass").foregroundColor(.white).offset(y:-30)
                                .font(.system(size: 20))
                        }
                    }
                    .foregroundColor(selectedIndex == 2 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedIndex = 3
                    }) {
                        VStack {
                            Image(systemName: "clock")
                            Text("History")
                        }.offset(y:-3)
                    }
                    .foregroundColor(selectedIndex == 3 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedIndex = 4
                    }) {
                        VStack {
                            Image(systemName: "person")
                            Text("Profile")
                        }.offset(y:-2)
                    }
                    .foregroundColor(selectedIndex == 4 ? .blue : .gray)
                }
                .padding()
                .background(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: -5)
                
                // Spacer()
            }
        }
    }
}

#Preview {
    TabBar()
}
