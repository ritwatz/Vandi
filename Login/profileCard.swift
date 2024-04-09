//
//  profileCard.swift
//  Vandi_2
//
//  Created by admin49 on 23/03/24.
//

import SwiftUI

struct profileCard: View {
    var personName: String
    var personEmail: String
    
    var body: some View {
        HStack{
            Image("dummyProfilePic")
                .resizable()
                .frame(width: 80, height: 90)
                .cornerRadius(10)
            
            VStack(alignment: .leading){
                Text("\(personName)")
                    .font(.title3)
                
                Text("\(personEmail)")
                    .font(.title3)
                    .foregroundStyle(Color.white)
            }
            .padding(.trailing)
            
            Spacer()
            
            NavigationLink(destination: ProfileInputView(),
                label: {
                    Image(systemName: "pencil")
                    .font(.title3)
                    .foregroundColor(.white)
                        .frame(width: 40 , height: 40)
                }
            )
            
        }
        .padding()
        .frame(width: 350, height: 120)
        .background(.thinMaterial)
        .cornerRadius(20)
    }
}



#Preview {
    profileCard(personName: "Fakie Nameiae", personEmail: "fake_email@gmail.com")
}
