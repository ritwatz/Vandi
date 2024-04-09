//
//  History_detail_upcoming.swift
//  Vandi_2
//
//  Created by admin49 on 26/03/24.
//

import SwiftUI

struct History_detail_upcoming: View {
    var body: some View {
        NavigationStack {
            VStack(spacing:15){
                VStack {
                    Home21().frame(maxWidth: .infinity,maxHeight: 300)
                }.overlay{
                    NavigationLink(destination: Home2()) {
                        Text("Full Map")
                            .foregroundColor(.black)
                            .padding()
                            .background(Rectangle().fill(Color.mint).frame(width: 80,height: 50).cornerRadius(10))
                            .shadow(radius: 10)
                        
                    }.offset(x:150,y:-55)
                }
                
                VStack(alignment:.leading){
                    Text("Tototal Rental Duration : 3 Days").font(.title3).bold()
                    Text("Overtime Duration : TBD ").font(.title3).bold()
                }.frame(width:350,alignment: .leading)

                Divider()
                VStack(alignment:.leading){
                    HStack(){
                        VStack(spacing :30){
                            VStack {
                                Text("22-02-2023")
                                Text("[9:15 AM]")
                            }
                            VStack {
                                Text("25-02-2023")
                                Text("[8:00 PM]")
                            }
                        }
                        VStack(spacing :30){
                            Image(systemName: "circle.fill").foregroundColor(.mint).font(.system(size: 12))
                            Rectangle()
                                .frame(width: 40,height: 1)
                                .foregroundColor(Color.gray).rotationEffect(.degrees(90))
                            Image(systemName: "circle.fill").foregroundColor(.mint).font(.system(size: 12))
                        }
                        VStack(spacing :50){
                            Text("Ziyadh Rentals , Chennai")
                            Text("Ziyadh Rentals , Chennai")
                        }
                    }
                }
                Divider()
                
                VStack(alignment: .leading,spacing:10){
                    Text("Bill Details").font(.title3).bold().frame(width: .infinity).padding(.vertical,1)
                    HStack{
                        Text("Bill ID :")
                        Spacer()
                        Text("JKL789")
                    }
                    HStack{
                        Text("Rental Duration Cost :")
                        Spacer()
                        Text("$400")
                    }
                    
                    HStack{
                        Text("Overtime Duration Cost :")
                        Spacer()
                        Text("TBD")
                    }
                    HStack{
                        Text("Total Cost :")
                        Spacer()
                        Text("$400+")
                    }
                    HStack{
                        Text("Payement Mode")
                        Spacer()
                        Text("UPI")
                    }
                }.frame(width: 350,alignment: .leading)
                
                Divider()
                HStack{
                    Text("Get Invoice Copy")
                    Image(systemName: "chevron.right").font(.footnote).offset(y:1)
                }.frame(width:350,height:20, alignment: .leading)
                Divider()
                HStack{
                    Text("Get Help")
                    Image(systemName: "chevron.right").font(.footnote).offset(y:1)
                }.frame(width:350,height:20, alignment: .leading)
                Divider()

            }.navigationTitle("Tue,Dec 22,6:00 PM - JKL789").navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                
        }
    }
//    func call(){
//        Home2()
//    }
}

#Preview {
    History_detail_upcoming()
}
