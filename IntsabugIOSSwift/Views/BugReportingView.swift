//
//  BugReportingView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 21/07/2025.
//

import SwiftUI

struct BugReportingView: View {
    var body: some View {
        VStack(spacing: 0) {

            Spacer()
            Text("Bug Reporting Screen")
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
    BugReportingView()
}
