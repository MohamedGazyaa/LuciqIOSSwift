//
//  IntsabugIOSSwiftApp.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 19/07/2025.
//

import SwiftUI

@main
struct LuciqIOSSwiftApp: App {
    
    @State private var sdkInitialized = false
    
    init() {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "PrimaryColor")
        let customFont = UIFont(name: "ABCArizonaFlare-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)

            UISegmentedControl.appearance().setTitleTextAttributes([
                .foregroundColor: UIColor(named: "TextWhite") ?? .white,
                .font: customFont
            ], for: .selected)

            UISegmentedControl.appearance().setTitleTextAttributes([
                .foregroundColor: UIColor.black,
                .font: customFont
            ], for: .normal)
        }
    
    var body: some Scene {
        WindowGroup {
            
            if sdkInitialized{
                ProductsNavigationView()
            }else{
                SDKInitializationView(onSuccess: {sdkInitialized = true})
            }
            
        }
    }
}
