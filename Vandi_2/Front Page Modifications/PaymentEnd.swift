//
//  PaymentEnd.swift
//  Vandi_2
//
//  Created by user50b on 04/03/24.
//
import SwiftUI

struct PaymentEnd: View {
    @State private var isSheetPresented = true
    
    var body: some View {
        ZStack {
            NavigationStack {
                Image("verify").offset(y: 130)
                Text("Thank You").font(.title).fontWeight(.medium).offset(y: 140)
                VStack(alignment: .center) {
                    Text("Your booking has been sent to").font(.title3).fontWeight(.medium)
                    Text("Md.Sharif Ahamed").font(.title3).fontWeight(.medium)
                }.offset(y: 160)
                
                Spacer()
                 NavigationLink(destination: HistoryView()){Text("Next")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 130)
                        .background(Color.mint)
                        .cornerRadius(10)
                }
            }
            
            if isSheetPresented {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Your Booking is added to the History").bold().padding()
                    Button("Continue") {
                        isSheetPresented = false
                    }.padding()
                    .background(Color.mint)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
        }
    }
}

#Preview {
    PaymentEnd()
}
