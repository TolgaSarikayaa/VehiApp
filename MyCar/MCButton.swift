//
//  MCButton.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.01.24.
//

import SwiftUI

struct MCButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    MCButton(title: "Value", background: .pink) {
        // Action
    }
}
