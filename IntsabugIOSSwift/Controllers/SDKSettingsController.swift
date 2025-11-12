//
//  SDKSettingsController.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import Foundation
import LuciqSDK

class SDKSettingsController: ObservableObject {
    
    
    @Published var isEnabled = true
    @Published var userIdentificationName = ""
    @Published var userIdentificationID = ""
    @Published var userIdentificationEmail = ""
    @Published var welcomeMessageMode = "Live"
    
    func handleStateChange() {
        if isEnabled {
            Luciq.enabled = true
        } else {
            Luciq.enabled = false
        }
    }
    
    func identifyUser(name: String, ID: String, Email: String) -> Bool{
        
        if(self.userIdentificationID != ID && self.userIdentificationEmail != Email){
            let trimmedID = ID.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedEmail = Email.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmedID.isEmpty && !trimmedEmail.isEmpty else{
                return false
            }
            Luciq.identifyUser(withID: trimmedID, email: trimmedEmail, name: name)
            self.userIdentificationName = name
            self .userIdentificationEmail = trimmedEmail
            self.userIdentificationID = trimmedID
            return true
        }
        return true
    }
    
    func addUserAttirbute(key: String, value: String) -> Bool{
        guard !key.isEmpty && !value.isEmpty else{
            return false
        }
        Luciq.setUserAttribute(value, withKey: key)
        return true
    }
    
    func setWelcomeMessageMode(mode:String){
        if (self.welcomeMessageMode != mode){
            switch (mode) {
            case "Live":
                Luciq.welcomeMessageMode = WelcomeMessageMode.live
                self.welcomeMessageMode = "Live"
            case "Beta":
                Luciq.welcomeMessageMode = WelcomeMessageMode.beta
                self.welcomeMessageMode = "Beta"
            default:
                Luciq.welcomeMessageMode = WelcomeMessageMode.disabled
                self.welcomeMessageMode = "Disabled"
            }
        }
        
    }
    
}
