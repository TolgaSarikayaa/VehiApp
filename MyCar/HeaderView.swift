//
//  HeaderView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.01.24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let background: UIImage
    
    var body: some View {
        VStack {
            // Header
            ZStack {
                Image(uiImage: background)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(title)
                        .font(.system(size: 50))
                        .foregroundColor(Color.white)
                        .bold()
                    Text(subtitle)
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                }
                .padding(.top, 50)
            }
            
            .frame(width: UIScreen.main.bounds.width * 3, 
                   height: 350)
        } .offset(y: -10)
    }
}

#Preview {
    HeaderView(title: "Title", subtitle: "Subtitle",background: UIImage(named: "background")!)
}
