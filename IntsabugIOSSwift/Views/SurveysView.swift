//
//  SurveysView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI

struct SurveysView: View {
    var body: some View {
        VStack(spacing: 0) {

            Spacer()
            Text("Surveys Screen")
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal){
                Image("LuciqLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 60)
                    .clipped()
                    .padding(.top,5)
                    .padding(.bottom,12)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color("PrimaryColor"), for: .navigationBar)
    }
}

#Preview {
    SurveysView()
}
