//
//  StatusBar.swift
//  Vandi_2
//
//  Created by user2 on 09/02/24.
//

import SwiftUI

struct StatusBar: View {
    var body: some View {
        HStack {
            // Time
            Text(getCurrentTime())
                .font(.caption)
            
            Spacer()
            
            // Signal strength, Wi-Fi, Battery level
            HStack(spacing: 8) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                Image(systemName: "wifi")
                Image(systemName: "battery.100")
            }
            .font(.caption)
        }
        .foregroundColor(.black)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
       // .background() // White background color
    }
    
    // Function to get current time
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
}

#Preview {
    StatusBar()
}
