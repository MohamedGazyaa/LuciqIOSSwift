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
