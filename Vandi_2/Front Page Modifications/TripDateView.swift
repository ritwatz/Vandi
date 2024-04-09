//
//  TripDateView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct TripDateView: View {
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    @State private var isDatePickerPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Trip Dates")
                .foregroundStyle(Color(.darkGray))
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack(spacing: 10) {
                VStack(alignment: .leading) {
                    // Start and End Date Text with Time
                    Text("Start Date: \(formattedDateWithTime(date: startDate))")
                        .fontWeight(.bold).font(.system(size:16))
                    Text("End Date: \(formattedDateWithTime(date: endDate))")
                        .fontWeight(.bold).font(.system(size:16))
                    
                    // Calculate and display the total rental duration
                    Text("Total Rental Duration: \(calculateRentalDuration())")
                        .fontWeight(.bold).font(.system(size:16))
                }
                
                Spacer()
                
                Button {
                    isDatePickerPresented.toggle()
                } label: {
                    Text("Change")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
        }
        .padding(.horizontal)
        .popover(isPresented: $isDatePickerPresented, arrowEdge: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Divider()
                    Text(" Select Start Date & Time").font(.title2).fontWeight(.bold)
                    Divider()
                    DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                    Divider()
                    Text("Select End Date & Time").font(.title2).fontWeight(.bold)
                    Divider()
                    DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .onChange(of: startDate) { newValue in
                            endDate = Calendar.current.date(byAdding: .hour, value: 1, to: newValue) ?? newValue
                        }
                    Divider()
                    Button(action: {
                        isDatePickerPresented = false // Dismiss the popover
                    }) {
                        Text("Save")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }.presentationDetents([.large])
        }
    }
    
    func formattedDateWithTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM, HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func calculateRentalDuration() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .day], from: startDate, to: endDate)
        
        if let days = components.day, let hours = components.hour {
            if days > 0 {
                if hours > 0 {
                    return "\(days) day\(days > 1 ? "s" : "") \(hours) hour\(hours > 1 ? "s" : "")"
                } else {
                    return "\(days) day\(days > 1 ? "s" : "")"
                }
            } else {
                if hours > 0 {
                    return "\(hours) hour\(hours > 1 ? "s" : "")"
                } else {
                    return "Less than an hour"
                }
            }
        } else {
            return "Duration calculation error"
        }
    }
}

struct TripDateView_Previews: PreviewProvider {
    static var previews: some View {
        TripDateView()
    }
}
