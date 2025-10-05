//
//  SDKInitializationView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 29/09/2025.
//

import SwiftUI

struct SDKInitializationView: View {
    
    var body: some View {
        VStack(spacing: 0) {
                    // Custom header (toolbar style)
                    HStack {
                        Spacer()
                        Image("LuciqLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 60)
                            .clipped()
                            .padding(.bottom,12)
                        Spacer()
                    }
                    .frame(height: 55)
                    .background(Color("PrimaryColor"))

                    Spacer() // Your content area
            Text("Hello World!")
                .font(Font.custom("ABcArizonaFlare-Regular", size: 40))
                    Spacer()
                }
    }
}

#Preview {
    SDKInitializationView()
}

